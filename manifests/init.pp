class telegraf (
  $package_name           = $telegraf::params::package_name,
  $ensure                 = $telegraf::params::ensure,
  $config_file            = $telegraf::params::config_file,
  $config_file_owner      = $telegraf::params::config_file_owner,
  $config_file_group      = $telegraf::params::config_file_group,
  $config_folder          = $telegraf::params::config_folder,
  $hostname               = $telegraf::params::hostname,
  $omit_hostname          = $telegraf::params::omit_hostname,
  $interval               = $telegraf::params::interval,
  $round_interval         = $telegraf::params::round_interval,
  $metric_batch_size      = $telegraf::params::metric_batch_size,
  $metric_buffer_limit    = $telegraf::params::metric_buffer_limit,
  $collection_jitter      = $telegraf::params::collection_jitter,
  $flush_interval         = $telegraf::params::flush_interval,
  $flush_jitter           = $telegraf::params::flush_jitter,
  $logfile                = $telegraf::params::logfile,
  $debug                  = $telegraf::params::debug,
  $quiet                  = $telegraf::params::quiet,
  $inputs                 = $telegraf::params::inputs,
  $outputs                = $telegraf::params::outputs,
  $global_tags            = $telegraf::params::global_tags,
  $manage_service         = $telegraf::params::manage_service,
  $manage_repo            = $telegraf::params::manage_repo,
  $purge_config_fragments = $telegraf::params::purge_config_fragments,
  $repo_type              = $telegraf::params::repo_type,
  $windows_package_url    = $telegraf::params::windows_package_url,
  $service_enable         = $telegraf::params::service_enable,
  $service_ensure         = $telegraf::params::service_ensure,
  $install_options        = $telegraf::params::install_options,
) inherits ::telegraf::params
  {

    $service_hasstatus = $telegraf::params::service_hasstatus
    $service_restart   = $telegraf::params::service_restart

    validate_string($package_name)
    validate_string($ensure)
    validate_string($config_file)
    validate_string($logfile)
    validate_string($config_file_owner)
    validate_string($config_file_group)
    validate_absolute_path($config_folder)
    validate_string($hostname)
    validate_bool($omit_hostname)
    validate_string($interval)
    validate_bool($round_interval)
    validate_integer($metric_batch_size)
    validate_integer($metric_buffer_limit)
    validate_string($collection_jitter)
    validate_string($flush_interval)
    validate_string($flush_jitter)
    validate_bool($debug)
    validate_bool($quiet)
    validate_hash($inputs)
    validate_hash($outputs)
    validate_hash($global_tags)
    validate_bool($manage_service)
    validate_bool($manage_repo)
    validate_bool($purge_config_fragments)
    validate_string($repo_type)
    validate_string($windows_package_url)
    validate_bool($service_hasstatus)
    validate_string($service_restart)
    validate_bool($service_enable)
    validate_string($service_ensure)

    # currently the only way how to obtain merged hashes
    # from multiple files (`:merge_behavior: deeper` needs to be
    # set in your `hiera.yaml`)
    $_outputs = lookup({
      name          => 'telegraf::outputs',
      default_value => $outputs,
    })
    $_inputs = lookup({
      name          => 'telegraf::inputs',
      default_value => $inputs,
    })

    contain ::telegraf::install
    contain ::telegraf::config
    contain ::telegraf::service

    Class['::telegraf::install']
    -> Class['::telegraf::config']
    -> Class['::telegraf::service']
  }