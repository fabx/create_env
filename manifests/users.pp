define create_env::users ($ce_ensure,
                          $ce_carto,
                          $ce_type,
                          $ce_environment,
                          $ce_appli,
                          $ce_version,
                          $ce_user,
                          $ce_primary_group = undef,
                          $ce_secondary_groups = [],
                          $ce_home,
                          $ce_shell = '/bin/bash',)
{

  notify {"name: ${name} - ce_ensure: ${ce_ensure} - ce_user: ${ce_user} - ce_primary_group: ${ce_primary_group} - ce_secondary_groups: ${ce_secondary_groups} - ce_home: ${ce_home} - ce_shell: ${ce_shell} - ce_context: ${ce_context}":
    noop => true,
  }

  if (!defined(User["${name}"])) {

    create_resources(user, {"${name}" => {
                                              ensure           => $ce_ensure,
                                              name             => $ce_user,
                                              gid              => $ce_primary_group,
                                              groups           => $ce_secondary_groups,
                                              home             => $ce_home,
                                              shell            => $ce_shell,
                                            }})
  }

}
