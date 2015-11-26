define create_env::folders ($ce_ensure,
                            $ce_carto,
                            $ce_type,
                            $ce_environment,
                            $ce_appli,
                            $ce_version,
                            $ce_owner,
                            $ce_group,
                            $ce_mode,)
{

  notify {"name: ${name} - ce_ensure: ${ce_ensure} - ce_owner : ${ce_owner} - ce_group: ${ce_group} - ce_mode: ${ce_mode} - ce_context: ${ce_context}":
    noop => true,
  }

  if (!defined(File[$name])) {

    create_resources(file, {"${name}" => {
                              ensure => $ce_ensure,
                              owner  => $ce_owner,
                              group  => $ce_group,
                              mode   => $ce_mode
                            }})

  }
}

