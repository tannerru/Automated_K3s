# installing libguestfs-tools only required once, prior to first run
apt update -y
apt install libguestfs-tools -y

# remove existing image in case last execution did not complete successfully
rm focal-server-cloudimg-amd64.img
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent
qm create 9000 --name "ubuntu22-04-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 jammy-server-cloudimg-amd64.img SLOW
qm set 9000 --scsihw virtio-scsi-pci --scsi0 SLOW:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 SLOW:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1
qm template 9000
rm jammy-server-cloudimg-amd64.img
echo "next up, clone VM, then expand the disk"
echo "you also still need to copy ssh keys to the newly cloned VM"