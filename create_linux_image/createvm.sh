#copy paste below on CVM
cat > $HOME/tmp/CC_createvm.sh <<EOF
#!/bin/bash

IMAGENAME=CC_CENTOSIMAGE1
VMNAME=CC_CENTOS1

echo "Image name is " \$IMAGENAME
echo -e "VM name is " \$VMNAME "\n"

exec 2> $HOME/tmp/CC_createvm.log

echo "Creating Image" \$IMAGENAME
acli image.create \$IMAGENAME image_type=kDiskImage container=SelfServiceContainer source_url=http://10.42.194.11/images/AHV/Centos7.qcow2

echo "Creating VM" \$VMNAME
acli vm.create \$VMNAME memory=4096M num_cores_per_vcpu=2 num_vcpus=1
echo "Cloning disk from image and attaching to VM"
acli vm.disk_create \$VMNAME clone_from_image=\$IMAGENAME
echo "Attaching NIC"
acli vm.nic_create \$VMNAME network=Network-01
echo -e "Powering VM on"
acli vm.on \$VMNAME
echo -e "Getting IP of VM"
acli vm.get \$VMNAME include_address_assignments=true | grep ip_address
echo ""
EOF
