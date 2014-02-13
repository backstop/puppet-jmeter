# ex: syntax=puppet si ts=4 sw=4 et
class jmeter (
    $provider = $::jmeter::params::provider,
    $version  = $::jmeter::params::version,
) inherits jmeter::params {
    case $provider {
        tarball: {
            class { 'jmeter::install::tarball':
                version => $version,
            }
        }
        package: {
            class { 'jmeter::install::package':
                version => $version,
            }
        }
        default: {
            fail("Unknown provider for jmeter: ${provider}")
        }
    }
}
