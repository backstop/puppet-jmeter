class jmeter::install::plugins {
  # Currnetly only supports the standard plugin package.

  $dest = $provider ? {
    'tarball' => '/usr/local/jmeter/lib/ext',
    'package' => '/usr/share/jmeter/lib/ext',
  }

  if $jmeter_plugins_install == True {
    wget::fetch { 'plugins':
      source       => "http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-${::jmeter::params::plugins_version}.zip",
      destinations => "/root/JMeterPlugins-Standard-${::jmeter::params::plugins_version}.zip",
      notify       => Exec['install-jmeter-plugins'],
    }

    exec { 'install-jmeter-plugins':
      command => "unzip -q -d JMeterPlugins JMeterPlugins-${::jmeter::params::plugins_version}.zip && mv JMeterPlugins/JMeterPlugins.jar ${dest}",
      cwd     => '/root',
      creates => "${dest}/JMeterPlugins-Standard.jar",
      require => [Package['unzip']]
    }
  }
}
