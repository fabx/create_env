define create_env::files ($ce_ensure,
                          $ce_carto,
                          $ce_type,
                          $ce_environment,
                          $ce_appli,
                          $ce_version,
                          $ce_owner,
                          $ce_group,
                          $ce_mode,
                          $ce_source = undef,
                          $ce_content = undef,)
{

  notify {"name: ${name} - ce_ensure: ${ce_ensure} - ce_carto: ${ce_carto} - ce_type: ${ce_type} - ce_environment: ${ce_environment} - ce_appli: ${ce_appli} - ce_version: ${ce_version} - ce_owner: ${ce_owner} - ce_group: ${ce_group} - ce_mode: ${ce_mode} - ce_source: ${ce_source} - ce_content: ${ce_content}":
    noop => true,
  }

  if (!defined(File[$name])) {

    if ($ce_content) {

      create_resources(file, {"${name}" => {
                              ensure  => $ce_ensure,
                              owner   => $ce_owner,
                              group   => $ce_group,
                              mode    => $ce_mode,
                              source  => $ce_source,
                              content => template($ce_content),
                            }})
    } else {

      create_resources(file, {"${name}" => {
                              ensure  => $ce_ensure,
                              owner   => $ce_owner,
                              group   => $ce_group,
                              mode    => $ce_mode,
                              source  => $ce_source,
                            }})

    }

  }

}

