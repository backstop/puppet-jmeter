# ex: syntax=puppet si ts=2 sw=2 et
class jmeter::install::tarball (
  $version,
) {
  file { "/usr/local/apache-jmeter-${version}.tgz",
    source => "puppet:///bigfiles/jmeter/apache-jmeter-${version}.tgz",
  }

  exec { 'unpack jmeter':
    command => "/bin/tar -zxf /usr/local/apache-jmeter-${version}.tgz -C /usr/local",
    user    => 'root',
    creates => "/usr/local/apache-jmeter-${version}",
    before  => File["/usr/local/apache-jmeter-${version}"],
  }

  file { "/usr/local/apache-jmeter-${version}":
    ensure => directory,
  }

  file { '/usr/local/jmeter':
    ensure => link,
    target => "/usr/local/apache-jmeter-${version}",
  }

  file {'/usr/bin/jmeter':
    ensure => present,
    source => 'puppet:///modules/jmeter/jmeter',
  }

  class { 'jmeter::profile':
    jmeter_home => '/usr/local/jmeter',
  }
}
