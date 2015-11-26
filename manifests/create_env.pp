define create_env::create_env ( $ce_ensure,
                                $ce_carto,
                                $ce_type,
                                $ce_environment,
                                $ce_appli,
                                $ce_version = undef,
                                $ce_params = undef,
                                $ce_version = undef) {

  $ce_config = $name

  $array = split($ce_config, '/')

  $ce_config_carto = $array[0]
  $ce_config_type = $array[1]

  validate_re($ce_ensure, '^present$|^absent$|^directory$', "ensure doit etre present ou absent et non ${ce_ensure}")

  validate_string($ce_carto)
  validate_string($ce_config_carto)
  validate_re($ce_carto, "^${ce_config_carto}$", "carto doit correspondre a la cle de configuration")

  validate_string($ce_type)
  validate_string($ce_config_type)
  validate_re($ce_type, "^${ce_config_type}$", "type doit correspondre a la cle de configuration")
  validate_re($ce_type, "^standard$|^oracle11$|^oracle12$|^mq$|^pajee$|^mongodb$", "type doit etre standard, oracle11, oracle12, ,mq, pajee ou mongodb et non ${ce_type}")

  validate_re($ce_environment, "^test$|^integration$|^production$", "environment doit valoir test, integration ou production et non ${ce_environment}")

  validate_string($ce_appli)

  case $ce_type {
    'standard': {
      $local_default_volumes         = { ce_ensure       => present, }
      $local_default_groups          = { ce_ensure       => present, }
      $local_default_users           = { ce_shell        => '/bin/bash',
                                         ce_ensure       => present, }
      $local_default_folders         = { ce_group        => "${ce_carto}grp",
                                         ce_ensure      => directory, }
      $local_default_files           = { ce_ensure      => present,
                                         ce_owner       => 'root',
                                         ce_group       => 'sys', }
      $local_default_templates       = { ce_ensure      => present,
                                         ce_owner       => "${ce_carto}mgr",
                                         ce_group       => "${ce_carto}grp",
                                         ce_carto       => "${ce_carto}",
                                         ce_type        => "${ce_type}",
                                         ce_environment => "${ce_environment}",
                                         ce_appli       => "${ce_appli}",}
    }

    'oracle11','oracle12': {
      $create_env_params = hiera('create_env_params')
      $oracle_user = $create_env_params['oracle']["${ce_version}"]['user']
      $oracle_group = $create_env_params['oracle']["${ce_version}"]['primary_group']
      $local_default_volume_groups   = { ce_ensure      => present,
                                         ce_create_only => true, }
      $local_default_volumes         = { ce_ensure      => present, }
      $local_default_groups          = { ce_ensure      => present, }
      $local_default_users           = { ce_shell       => '/bin/bash',
                                         ce_ensure => present, }
      $local_default_folders         = { ce_ensure => directory,
                                         ce_owner  => "${oracle_user}",
                                         ce_group  => "${oracle_group}",}
      $local_default_files           = { ce_ensure => present,
                                         ce_owner  => "${oracle_user}",
                                         ce_group  => "${oracle_group}",}
      $local_default_templates       = { ce_ensure => present,
                                         ce_owner => "${ce_carto}mgr",
                                         ce_group => "${ce_carto}grp", }
    }
  }

  $context = { ce_ensure      => $ce_ensure,
               ce_carto       => $ce_carto,
               ce_type        => $ce_type,
               ce_environment => $ce_environment,
               ce_appli       => $ce_appli,
               ce_version     => $ce_version }

  $default_volume_groups   = merge($local_default_volume_groups, $context)
  $default_volumes         = merge($local_default_volumes, $context)
  $default_groups          = merge($local_default_groups, $context)
  $default_users           = merge($local_default_uses, $context)
  $default_folders         = merge($local_default_folders, $context)
  $default_files           = merge($local_default_files, $context)
  $default_templates       = merge($local_default_templates, $context)

  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_volume_groups: ${local_default_volume_groups}": noop => true, }
  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_volumes: ${local_default_volumes}": noop => true, }
  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_groups: ${local_default_groups}": noop => true, }
  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_users: ${local_default_users}": noop => true, }
  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_folders: ${local_default_folders}": noop => true, }
  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_files: ${local_default_files}": noop => true, }
  notify {"ce_carto: ${ce_carto} - ce_type: ${ce_type} - local_default_templates: ${local_default_templates}": noop => true, }

  # VOLUME_GOUPS
  # $list_volume_groups = hiera("create_env_${ce_type}_volume_groups")
  # if $list_volume_groups { create_resources(create_env::volume_groups, $list_volume_groups, $default_volume_groups) }

  # VOLUMES
  # $list_volumes = hiera("create_env_${ce_type}_volumes")
  # if $list_volumes { create_resources(create_env::volumes, $list_volumes, $default_volumes) }

  # GROUPES
  $list_groups = hiera("create_env_${ce_type}_groups")
  if $list_groups { create_resources(create_env::groups, $list_groups, $default_groups) }

  # USER
  $list_users = hiera("create_env_${ce_type}_users")
  if $list_users { create_resources(create_env::users, $list_users, $default_users) }

  # FILE (FOLDERS)
  $list_folders = hiera("create_env_${ce_type}_folders")
  if $list_folders { create_resources(create_env::files, $list_folders, $default_folders) }

  # FILE (FILES)
  $list_files = hiera("create_env_${ce_type}_files")
  if $list_files { create_resources(create_env::files, $list_files, $default_files) }

  # FILE (TEMPLATE)
  $list_templates = hiera("create_env_${ce_type}_templates")
  if $list_templates { create_resources(create_env::files, $list_templates, $default_templates) }

}
