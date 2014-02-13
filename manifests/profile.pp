# ex: syntax=puppet si ts=4 sw=4 et
class jmeter::profile (
    $jmeter_home,
) {
    file { '/etc/profile.d/jmeter.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('jmeter/profile.erb'),
    }
}
