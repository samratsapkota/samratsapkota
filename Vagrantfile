# -- mode: ruby --
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$script = <<ENDSCRIPT
  sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
  sudo sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
  sudo sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
  sudo yum -y update
  sudo yum install -y epel-release
  sudo yum install -y net-tools
  sudo yum install -y wget
  sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
  sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
  sudo yum install java-11-openjdk
  echo 'export JAVA_HOME=/usr/lib/jvm/jre-11-openjdk' | sudo tee -a /etc/profile
  echo 'export JRE_HOME=/usr/lib/jvm/jre-11' | sudo tee -a /etc/profile
  source /etc/profile
  echo $JAVA_HOME
  echo $JRE_HOME
  cd ~ 
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  sudo sed -i '$ a gpgkey=http://pkg.jenkins.io/redhat-stable/jenkins.io.key' /etc/yum.repos.d/jenkins.repo
  sudo yum install jenkins
  sudo yum clean all
  
  sudo systemctl start jenkins.service
  sudo systemctl enable jenkins.service
  sudo yum install git
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl start docker
ENDSCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.93.12",name:"VirtualBox Host-Only Ethernet Adapter #4"
  config.vm.network "forwarded_port", guest: 8080, host: 8888
  config.vm.provision "shell", inline: $script
end
