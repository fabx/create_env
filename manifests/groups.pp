define create_env::groups ($ce_ensure,
                           $ce_carto,
                           $ce_type,
                           $ce_environment,
                           $ce_appli,
                           $ce_version,
                           $ce_group,)
{

  notify{"name: ${name} - ce_ensure: ${ce_ensure} - ce_group: ${ce_group} - ce_context: ${ce_context}":
    noop => true,
  }


  if ! defined(Group[$name]) {

    create_resources(group, {"${name}" => {
                                              ensure => $ce_ensure,
                                              # group  => $ce_group,
                                            }})

  }

}

