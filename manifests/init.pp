# ex: syntax=puppet si ts=4 sw=4 et
class jmeter (
    $provider = $::jmeter::params::provider,
    $version  = $::jmeter::params::version,
    $plugins  = false,
    $plugins_version = $::jmeter::params::plugins_version,
) inherits jmeter::params {
    case $provider {
        tarball: {
            class { 'jmeter::install::tarball':
                version => $version,
                before  => Class['jmeter::install::plugins'],
            }
        }
        package: {
            class { 'jmeter::install::package':
                version => $version,
                before  => Class['jmeter::install::plugins'],
            }
        }
        default: {
            fail("Unknown provider for jmeter: ${provider}")
        }
    }

    if $plugins {
        class {'jmeter::install::plugins': }
    }
}
