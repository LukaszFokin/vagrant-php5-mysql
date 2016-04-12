# vagrant-php5-mysql

This is a box with php 5.5 and Mysql 5.5.

### Installation

To install this box you will need Virtual Box and Vagrant instaled on your computer.

1 - Clone this repo.

```sh
git clone https://github.com/LukaszFokin/vagrant-php5-mysql.git vagrant
```

2 - Get into cloned folder
```sh
cd /path/where/you/cloned
vagran up
```

3 - Your virtual machine is ready to use

### Configure the IP of your machine

O IP padrão da máquina virtual é 10.0.10.10. Mas você pode definir o ip que você quiser editando o arquivo VagrantFile.

```sh
config.vm.network "private_network", ip: "new ip"
```
### SSH

To access your virtual machine via ssh you can use the default IP and the new IP you configured.

The default port is 22.

#### Teste

### HTTP access

The sites folder is shared between your local computer and your virtual box. You can configure the document root for the virtual box pointing to the shared folder /vagrant/sites.

```sh
$ vim /etc/apache2/apache2.conf
```

Locate the block below within the apache2.conf

```sh
<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>
```

And replace with:

```sh
<Directory /vagrant/sites>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>
```

After this, reload your apache

```sh
$ service apache2 restart
```

Now when you access the IP configured in your browser, all folders and files that are created within the directory sites you will see in the browser.
