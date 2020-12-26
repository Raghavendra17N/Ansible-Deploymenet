resource "null_resource" "entry" {
    triggers = {
        order = "${google_compute_instance.test-1-vm.name}"
    }
    provisioner "local-exec"{
       command = "echo [test_hosts1] >> inventory"
   }
}
resource "null_resource" "test1"{
    triggers = {
        order = "${null_resource.entry.id}"
    }
    provisioner "local-exec"{

        command = "echo ${google_compute_instance.test-1-vm.name} ansible_host=${google_compute_instance.test-1-vm.network_interface.0.access_config.0.nat_ip} >> "
    }
}
resource "null_resource" "entry2" {
    triggers = {
        order = "${null_resource.test1.id}"
    }
    provisioner "local-exec"{
       command = "echo [test_hosts2] >> inventory"
   }
}
resource "null_resource" "test2"{
    triggers = {
        order = "${null_resource.entry2.id}"
    }
    provisioner "local-exec"{

        command = "echo ${google_compute_instance.test-2-vm.name} ansible_host=${google_compute_instance.test-2-vm.network_interface.0.access_config.0.nat_ip} >>inventory"
    }
}
