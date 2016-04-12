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

class composer{
 
  package { "curl":
    ensure => installed,
  }

  package { "git":
    ensure => installed,
  }
 
  exec { 'install composer':
    command => 'curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer',     			
    require => Package['curl'],
  } 
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin", "/usr/local/sbin", "~/.composer/vendor/bin/" ] }

include base
include http
include php
include mysql
include composer