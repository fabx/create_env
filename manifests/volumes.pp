define create_env::volumes ($ce_ensure,
                            $ce_carto,
                            $ce_type,
                            $ce_environment,
                            $ce_appli,
                            $ce_version,
                            $ce_vg,
                            $ce_mountpath,
                            $ce_initial_size = undef)
{

  notify {"name: ${name} - ce_ensure: ${ce_ensure} - ce_vg: ${ce_vg} - ce_initial_size: ${ce_initial_size}":
    noop => true,
  }

  if (!defined(Volume["${name}"])) {

    logical_volume{"${name}":
      ensure       => $ce_ensure,
      volume_group => $ce_vg,
      initial_size => $ce_initial_size,
    } ->

    filesystem {"/dev/${ce_vg}/${name}":
      ensure  => $ce_ensure,
      fs_type => 'ext4',
      options => 'rw,nodev',
    } ->

    mount{"${ce_mountpath}":
      ensure => mounted,
    }
  }
}

