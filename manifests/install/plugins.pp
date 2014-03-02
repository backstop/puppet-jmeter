class jmeter::install::plugins {
  # Currnetly only supports the standard plugin package.

  $dest = $::jmeter::provider ? {
    'tarball' => '/usr/local/jmeter',
    'package' => '/usr/share/jmeter',
  }

  wget::fetch { 'plugins':
    source      => "http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-${::jmeter::params::plugins_version}.zip",
    destination => "/root/JMeterPlugins-Standard-${::jmeter::params::plugins_version}.zip",
    notify      => Exec['install-jmeter-plugins'],
  }

  exec { 'install-jmeter-plugins':
    command => "unzip -q -o -d ${dest} JMeterPlugins-Standard-${::jmeter::params::plugins_version}.zip",
    cwd     => '/root',
    creates => "${dest}/lib/ext/JMeterPlugins-Standard.jar",
    require => [Package['unzip']]
  }
}
