sudo su raghu -c "ansible -m ping -i Inventory/inventory.txt all">/tmp/ssh_logs.txt
a=`grep -Eo "Failed to connect" /tmp/ssh_logs.txt|uniq`
while [ "$a" = "Failed to connect" ]
    do
        sleep 15
        sudo su raghu -c "ansible -m ping -i Inventory/inventory.txt all">/tmp/ssh_logs.txt
        a=`grep -Eo "Failed to connect" /tmp/ssh_logs.txt|uniq`
    done
echo "SSH connection Established"
