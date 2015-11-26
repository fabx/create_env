class create_env::params{
  $create_env_params = hiera_hash('create_env_params')
  validate_hash($create_env_params)

  $create_env_config = hiera_hash('create_env_config')
  validate_hash($create_env_config)
}

