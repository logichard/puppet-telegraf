class telegraf::params {
  $config_file          = '/etc/telegraf/telegraf.conf'
  $config_file_owner    = 'telegraf'
  $config_file_group    = 'telegraf'
  $config_folder        = '/etc/telegraf/telegraf.d'
  $logfile              = ''
  $manage_repo          = true
  $service_enable       = true
  $service_ensure       = running
  $service_hasstatus    = true
  $service_restart      = 'pkill -HUP telegraf'
  $package_name           = 'telegraf'
  $ensure                 = 'present'
  $install_options        = []
  $hostname               = $::hostname
  $omit_hostname          = false
  $interval               = '10s'
  $round_interval         = true
  $metric_batch_size      = '1000'
  $metric_buffer_limit    = '10000'
  $collection_jitter      = '0s'
  $flush_interval         = '10s'
  $flush_jitter           = '0s'
  $debug                  = false
  $quiet                  = false
  $global_tags            = {}
  $manage_service         = true
  $purge_config_fragments = false
  $repo_type              = 'stable'

  $outputs = {
    'influxdb'  => {
      'urls'     => [ 'udp://metrics.[domain].com:8086' ],
      'database' => 'DB',
      'username' => 'DBUSER',
      'password' => 'DBPASSWORD',
    }
  }

  $inputs = {
    'cpu'  => {
      'percpu'   => true,
      'totalcpu' => true,
    }
  }
}
