class create_env::init (
) inherits create_env::params{

  notify {'coucou':}

  # Volumes<| |> -> Volume_groups<| |> -> Groups<| |> -> Users<| |> -> Folders<| |> -> Files<| |>
  # Groups<| |> -> Users<| |> -> Folders<| |> -> Files<| |>

  $create_env_config = hiera('create_env_config')
  if $create_env_config { create_resources('create_env::create_env',$create_env_config) }

}
