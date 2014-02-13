# ex: syntax=puppet si ts=4 sw=4 et
class jmeter::install::tarball (
    $version,
) {
    wget::fetch { 'ibiblio':
        source      => "http://mirrors.ibiblio.org/apache/jmeter/binaries/apache-jmeter-${version}.tgz",
        destination => "/usr/local/apache-jmeter-${version}.tgz",
        notify      => Exec['unpack jmeter'],
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

    file { "/usr/local/jmeter":
        ensure => "/usr/local/apache-jmeter-${version}",
    }

    class { 'jmeter::profile':
        jmeter_home => '/usr/local/jmeter',
    }
}
