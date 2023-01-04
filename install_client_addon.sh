#!/bin/bash
export USU=msoares
export KUBECONFIG=/home/$USU/.kube/config

green=`tput setaf 2`
reset=`tput sgr0`



echo "${green}Add apt repo for kubernetes${reset}"

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list

echo "${green}Update Ubuntu${reset}"
apt-get update 
apt-get upgrade -y

echo "${green}Install Kubernetes component (kubectl)${reset}"
apt-get install -y apt-transport-https ca-certificates curl
apt -y install vim git curl wget  kubectl=1.26.0-00
apt-mark hold  kubectl


echo "${green}Add Nodes /etc/hosts ${reset}"
if ! (grep kmaster /etc/hosts > /dev/null)
then
  echo "${green}Update /etc/hosts file${reset}"
cat >>/etc/hosts<<EOF
172.16.16.100   kmaster.example.com     kmaster
172.16.16.101   kworker1.example.com    kworker1
172.16.16.102   kworker2.example.com    kworker2

EOF

fi

rm -f /root/.ssh/known_hosts /home/$USU/.kube/config
echo "${green}Get kubernetes config of ControlPlane${reset}"
mkdir -p /home/$USU/.kube
sshpass -p  kubeadmin scp -o StrictHostKeyChecking=no root@kmaster:/etc/kubernetes/admin.conf /home/$USU/.kube/config
chown -R $USU:$USU /home/$USU/.kube
