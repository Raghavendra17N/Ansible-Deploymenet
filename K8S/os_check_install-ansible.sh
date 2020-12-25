source /etc/os-release
echo "$PWD"
os_vendor=`echo $ID`
if [ "$os_vendor" = "centos" ]
  then
    sudo yum install epel-release -y 
	sudo yum install ansible -y 
elif [ "$os_vendor" = "suse" ]
  then
    sudo zypper update
	sudo zypper install ansible -y 
else 
  sudo apt-get update 
  sudo apt install ansible -y 
fi
mkdir -p /etc/ansible/group_vars
sudo cp K8S/Inventory/group_vars/k8s_master.txt /etc/ansible/group_vars/k8s_master
sudo cp K8S/Inventory/group_vars/k8s_worker.txt /etc/ansible/group_vars/k8s_worker
