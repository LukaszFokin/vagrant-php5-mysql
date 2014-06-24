# Puppet configurations

class base {
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
    }
}

class http {

    define apache::loadmodule () {
        exec { "/usr/sbin/a2enmod $name" :
            unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
            notify => Service[apache2]
        }
    }

    apache::loadmodule{"rewrite":}

    package { "apache2":
        ensure => present,
    }

    service { "apache2":
        ensure => running,
        require => Package["apache2"],
    }
}

class php {

    package { "php5":
        ensure => present,
    }

    package { "php5-cli":
        ensure => present,
    }

    package { "php5-xdebug":
        ensure => present,
    }

    package { "php5-mysql":
        ensure => present,
    }

    package { "php5-imagick":
        ensure => present,
    }

    package { "php5-mcrypt":
        ensure => present,
    }

    package { "php-pear":
        ensure => present,
    }

    package { "php5-dev":
        ensure => present,
    }

    package { "php5-curl":
        ensure => present,
    }

    package { "php5-sqlite":
        ensure => present,
    }

    package { "libapache2-mod-php5":
        ensure => present,
    }
}

class mysql{
    package { "mysql-server":
        ensure => present,
    }

    service { "mysql":
        ensure => running,
        require => Package["mysql-server"],
    }
}

class phpmyadmin {
    Exec { path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', ] }

    package { 'phpmyadmin':
      ensure => present,
    }

    # linux way: ln -s /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/phpmyadmin.conf
    file { '/etc/apache2/sites-available/phpmyadmin.conf':
      ensure => link,
      target => '/etc/phpmyadmin/apache.conf',
      require => Package['phpmyadmin'],
    }

    exec { 'enable-phpmyadmin':
      command => 'sudo a2ensite phpmyadmin.conf',
      require => File['/etc/apache2/sites-available/phpmyadmin.conf'],
    }

    exec { 'restart-apache':
      command => 'sudo /etc/init.d/apache2 restart',
      require => Exec['enable-phpmyadmin'],
    }
}

include base
include http
include php
include mysql
include phpmyadmin