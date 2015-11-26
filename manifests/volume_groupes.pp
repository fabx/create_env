define create_env::volume_groups ($ce_ensure,
                                  $ce_carto,
                                  $ce_type,
                                  $ce_environment,
                                  $ce_appli,
                                  $ce_version,
                                  $ce_physical_volumes,
                                  $ce_create_only)
{

  notify {"name: ${name} - ce_ensure: ${ce_ensure} - ce_physical_volumes: ${ce_physical_volumes} - ce_create_only: ${ce_create_only}":
    noop => true,
  }

  if (!defined(Volume_groups["${name}"])) {

    volume_group{"${name}":
      ensure              => $ce_ensure,
      ce_physical_volumes => $ce_physical_volumes,
      ce_create_only      => $ce_create_only,
    }

  }
}

