#Base box:
vagrant box add precise64 http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box

#Vagrant-vbuest plugin (Check for guest additions correct version)
vagrant plugin install vagrant-vbguest

Run: vagrant up


#Configuration

New user passwords can be gernated with the following command:
openssl passwd -1 -salt <salt> <password> (This works for ubuntu, encyption depends on OS)