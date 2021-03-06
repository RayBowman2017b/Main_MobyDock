#!/bin/bash


# SERVER_IP="${SERVER_IP:-192.168.1.99}"
SERVER_IP="${SERVER_IP:-192.168.11.99}"
# SERVER_IP="${SERVER_IP:-192.168.11.139}"
SSH_USER="${SSH_USER:-$(whoami)}"
KEY_USER="${KEY_USER:-$(whoami)}"
#DOCKER_VERSION="${DOCKER_VERSION:-1.8.3}"
DOCKER_VERSION="${DOCKER_VERSION:-17.05.0}"

# DOCKER_PULL_IMAGES=("postgres:9.4.5" "redis:2.8.22")
DOCKER_PULL_IMAGES=("postgres:9.6.5" "redis:4.0.1")

function preseed_staging() {
cat << EOF
STAGING SERVER (DIRECT VIRTUAL MACHINE) DIRECTIONS:
  1. Configure a static IP address directly on the VM
     su
     <enter password>
     nano /etc/network/interfaces
     [change the last line to look like this, remember to set the correct
      gateway for your router's IP address if it's not 192.168.1.1]
iface eth0 inet static
  address ${SERVER_IP}
  netmask 255.255.255.0
  gateway 192.168.1.1

  2. Reboot the VM and ensure the Debian CD is mounted

  3. Install sudo
     apt-get update && apt-get install -y -q sudo

  4. Add the user to the sudo group
     adduser ${SSH_USER} sudo

  5. Run the commands in: $0 --help
     Example:
       ./deploy.sh -a
EOF
}

function install_openssh_server () {
  echo "Installing openssh server..."
  ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
    sudo apt-get  -y -q install openssh-server openssh-client
  '"
  echo "done!"
}

function configure_sudo () {
  echo "Configuring passwordless sudo..."
  scp "sudo/sudoers" "${SSH_USER}@${SERVER_IP}:/tmp/sudoers"
  ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
sudo chmod 440 /tmp/sudoers
sudo chown root:root /tmp/sudoers
sudo mv /tmp/sudoers /etc
  '"
  echo "done!"
}

function add_ssh_key() {
  echo "Adding SSH key..."
  cat "$HOME/.ssh/id_rsa.pub" | ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
mkdir /home/${KEY_USER}/.ssh
cat >> /home/${KEY_USER}/.ssh/authorized_keys
    '"
  ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
chmod 700 /home/${KEY_USER}/.ssh
chmod 640 /home/${KEY_USER}/.ssh/authorized_keys
sudo chown ${KEY_USER}:${KEY_USER} -R /home/${KEY_USER}/.ssh
  '"
  echo "done!"
}

function configure_secure_ssh () {
  echo "Configuring secure SSH..."
  scp "ssh/sshd_config" "${SSH_USER}@${SERVER_IP}:/tmp/sshd_config"
  ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
sudo chown root:root /tmp/sshd_config
sudo mv /tmp/sshd_config /etc/ssh
sudo systemctl restart ssh
  '"
  echo "done!"
}

# sudo apt-get install -y -q libapparmor1 aufs-tools ca-certificates
# sudo apt-get install -y -q libapparmor1 aufs-tools ca-certificates libltdl7
# libltdl7 is not installed
# sudo apt-get install libltdl7

#wget -O "docker.deb https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_${1}-0~jessie_amd64.deb"
# wget -O "docker.deb https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_${1}-0~jessie_amd64.deb"

function install_docker () {
  echo "Configuring Docker v${1}..."
  ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
sudo apt-get update
sudo apt-get install -y -q libapparmor1 aufs-tools ca-certificates libltdl7
sudo apt-get install -y -q openssh-server openssh-client
wget -O "docker.deb https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_${1}~ce-0~debian-jessie_amd64.deb"
sudo dpkg -i  docker.deb
rm docker.deb
sudo usermod -aG docker "${KEY_USER}"
  '"
  echo "done!"
}

function docker_pull () {
  echo "Pulling Docker images..."
  for image in "${DOCKER_PULL_IMAGES[@]}"
  do
    ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'docker pull ${image}'"
  done
  echo "done!"
}


function provision_server () {
  configure_sudo
  echo "--- configure_sudo :> DONE"
  add_ssh_key
  echo "--- add_ssh_key :> DONE"
  configure_secure_ssh
  echo "--- configure_secure_ssh :> DONE"
  install_docker ${1}
  echo "--- install_docker :> DONE"
  docker_pull
  echo "--- docker_pull :> DONE"
  git_init
  echo "--- git_init :> DONE"
}

function git_init () {
  echo "Initialize git repo and hooks..."
  scp "git/post-receive/mobydock" "${SSH_USER}@${SERVER_IP}:/tmp/mobydock"
  ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
sudo apt-get update && sudo apt-get install -y -q git
sudo rm -rf /var/git/mobydock.git /var/git/mobydock
sudo mkdir -p /var/git/mobydock.git /var/git/mobydock
sudo git --git-dir=/var/git/mobydock.git --bare init

sudo mv /tmp/mobydock /var/git/mobydock.git/hooks/post-receive
sudo chmod +x /var/git/mobydock.git/hooks/post-receive
sudo chown ${SSH_USER}:${SSH_USER} -R /var/git/mobydock.git /var/git/mobydock
  '"
  echo "done!"
}

function help_menu () {
cat << EOF
Usage: ${0} (-h | -S | -u | -v | -k | -s | -d [docker_ver] | -l | -a [docker_ver])

ENVIRONMENT VARIABLES:
   SERVER_IP        IP address to work on, ie. staging or production
                    Defaulting to ${SERVER_IP}

   SSH_USER         User account to ssh and scp in as
                    Defaulting to ${SSH_USER}

   KEY_USER         User account linked to the SSH key
                    Defaulting to ${KEY_USER}

   DOCKER_VERSION   Docker version to install
                    Defaulting to ${DOCKER_VERSION}

OPTIONS:
   -h|--help                 Show this message
   -S|--preseed-staging      Preseed intructions for the staging server
   -u|--sudo                 Configure passwordless sudo
   -v|--openssh-server       install openssh server
   -k|--ssh-key              Add SSH key
   -s|--ssh                  Configure secure SSH
   -d|--docker               Install Docker
   -l|--docker-pull          Pull necessary Docker images
   -g|--git-init             Install and initialize git
   -a|--all                  Provision everything except preseeding

EXAMPLES:
   Configure passwordless sudo:
        $ deploy -u

   Add SSH key:
        $ deploy -k

   Configure secure SSH:
        $ deploy -s

   Install openssh server:
        $ deploy -v

   Install Docker v${DOCKER_VERSION}:
        $ deploy -d

   Install custom Docker version:
        $ deploy -d 1.8.1

   Pull necessary Docker images:
        $ deploy -l

   Install and initialize git:
        $ deploy -g

   Configure everything together:
        $ deploy -a

   Configure everything together with a custom Docker version:
        $ deploy -a 1.8.1
EOF
}


while [[ $# > 0 ]]
do
case "${1}" in
  -S|--preseed-staging)
  preseed_staging
  shift
  ;;
  -u|--sudo)
  configure_sudo
  shift
  ;;
  -v|--ssh-server)
  install_openssh_server
  shift
  ;;
  -k|--ssh-key)
  add_ssh_key
  shift
  ;;
  -s|--ssh)
  configure_secure_ssh
  shift
  ;;
  -d|--docker)
  install_docker "${2:-${DOCKER_VERSION}}"
  shift
  ;;
  -l|--docker-pull)
  docker_pull
  shift
  ;;
  -g|--git-init)
  git_init
  shift
  ;;
  -a|--all)
  provision_server "${2:-${DOCKER_VERSION}}"
  shift
  ;;
  -h|--help)
  help_menu
  shift
  ;;
  *)
  echo "${1} is not a valid flag, try running: ${0} --help"
  ;;
esac
shift
done
