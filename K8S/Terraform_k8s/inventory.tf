resource "null_resource" "empty_inv"{
    provisioner "local-exec"{
        command = "cat /dev/null > ../Inventory/inventory.txt"
    }
}
resource "null_resource" "master-grp" {
    triggers = {
        order = "${google_compute_instance.master-k8s.name}"
    }
    provisioner "local-exec"{
       command = "echo [k8s_master] >> inventory"
   }
}
resource "null_resource" "master-ip"{
    triggers = {
        order = "${null_resource.master-grp.id}"
    }
    provisioner "local-exec"{

        command = "echo ${google_compute_instance.master-k8s.name} ansible_host=${google_compute_instance.master-k8s.network_interface.0.access_config.0.nat_ip} >> ../Inventory/inventory.txt"
    }
}
resource "null_resource" "worker-grp" {
    triggers = {
        order = "${null_resource.master-ip.id}"
    }
    provisioner "local-exec"{
       command = "echo [k8s_worker] >> ../Inventory/inventory.txt"
   }
}
resource "null_resource" "worker-ip"{
    triggers = {
        order = "${null_resource.worker-grp.id}"
    }
    provisioner "local-exec"{

        command = "echo ${google_compute_instance.node-k8s.name} ansible_host=${google_compute_instance.node-k8s.network_interface.0.access_config.0.nat_ip} >> ../Inventory/inventory.txt"
    }
}
