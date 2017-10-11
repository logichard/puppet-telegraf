class telegraf::install {

  assert_private()

  $_operatingsystem = downcase($::operatingsystem)

  if $::telegraf::manage_repo {
    case $::osfamily {
      'Debian': {
        apt::source { 'influxdata':
          comment  => 'Mirror for InfluxData packages',
          location => "https://repos.influxdata.com/${_operatingsystem}",
          release  => $::lsbdistcodename,
          repos    => $::telegraf::repo_type,
          key      => {
            'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
            'source' => 'https://repos.influxdata.com/influxdb.key',
          },
        }
        Class['apt::update'] -> Package[$::telegraf::package_name]
      }
      'RedHat': {
        yumrepo { 'influxdata':
          name     => 'influxdata',
          descr    => "InfluxData Repository - ${::operatingsystem} \$releasever",
          enabled  => 1,
          baseurl  => "https://repos.influxdata.com/rhel/\$releasever/\$basearch/${::telegraf::repo_type}",
          gpgkey   => 'https://repos.influxdata.com/influxdb.key',
          gpgcheck => 1,
        }
        Yumrepo['influxdata'] -> Package[$::telegraf::package_name]
      }
      default: {
        fail('Only RedHat, CentOS, OracleLinux, Debian, Ubuntu')
      }
    }
  }
  ensure_packages([$::telegraf::package_name], { ensure => $::telegraf::ensure, install_options => $::telegraf::install_options })
}
