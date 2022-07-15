#!/bin/bash

echo "Creating Image"

#ssh to CVM and run command
ssh nutanix@10.38.15.134 "acli image.create linux2 source_url=http://10.42.194.11/images/AHV/Centos7.qcow2 image_type=kDiskImage container=Images"
