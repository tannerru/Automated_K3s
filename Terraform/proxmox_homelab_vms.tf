resource "proxmox_vm_qemu" "k3s_master" {
  for_each    = var.k3s_masters
  name        = each.value.name
  desc        = each.value.name
  target_node = each.value.target_node
  os_type     = "cloud-init"
  full_clone  = true
  memory      = each.value.memory
  sockets     = "1"
  cores       = each.value.vcpu
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = var.k3s_source_template
  agent       = 1
  disk {
    size    = each.value.disk_size
    type    = "virtio"
    storage = "SLOW"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag = "40"
  }

  # Cloud-init section
  ipconfig0 = "ip=${each.value.ip}/24,gw=${each.value.gw}"
  ipconfig1 = "ip=${each.value.ip2}/24"
  ssh_user  = var.ssh_user
  sshkeys   = var.ssh_pub_key
  ciuser = var.ciuser
  cipassword = var.cipassword
  

  # Post creation actions
  #provisioner "remote-exec" {
    #inline = concat(var.extend_root_disk_script)
   # connection {
    #  type        = "ssh"
     # user        = var.ssh_user
      #password    = var.ssh_password
      #private_key = file("~/.ssh/id_rsa")
      #host        = each.value.ip
    #}
  #}
}

resource "proxmox_vm_qemu" "k3s_workers" {
  for_each    = var.k3s_workers
  name        = each.value.name
  desc        = each.value.name
  target_node = each.value.target_node
  os_type     = "cloud-init"
  full_clone  = true
  memory      = each.value.memory
  sockets     = "1"
  cores       = each.value.vcpu
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = var.k3s_source_template
  agent       = 1
  disk {
    size    = each.value.disk_size
    type    = "virtio"
    storage = "SLOW"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag = "40"
  }

  # Cloud-init section
  ipconfig0 = "ip=${each.value.ip}/24,gw=${each.value.gw}"
  ipconfig1 = "ip=${each.value.ip2}/24"
  ssh_user  = var.ssh_user
  sshkeys   = var.ssh_pub_key
  ciuser = var.ciuser
  cipassword = var.cipassword
  # Post creation actions
  #provisioner "remote-exec" {
    #inline = concat(var.extend_root_disk_script)
   # connection {
    #  type        = "ssh"
     # user        = var.ssh_user
      #password    = var.ssh_password
      #private_key = file("~/.ssh/id_rsa")
      #host        = each.value.ip
    #}
  #}
}

