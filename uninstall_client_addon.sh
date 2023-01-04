#!/bin/bash
export USU=msoares
export KUBECONFIG=/home/$USU/.kube/config

green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Remove apt repo for kubernetes${reset}"
rm -f /etc/apt/sources.list.d/kubernetes.list

echo "${green}Remove Kubernetes component (kubectl)${reset}"
apt remove  --allow-change-held-packages kubectl   -y

 
echo "${green}Remove Nodes /etc/hosts ${reset}"
if  (grep kmaster /etc/hosts > /dev/null)
then
    grep -v -E "kmaster|kworker" /etc/hosts > /tmp/hosttmp
    cp /tmp/hosttmp /etc/hosts

fi

echo "${green}Remove kubernetes config ${reset}"
rm -f /root/.ssh/known_hosts /home/$USU/.kube/config
rm -rf /home/$USU/.kube /tmp/hosttmp

