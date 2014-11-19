#!/bin/bash
#--------------------------------------------#
# This script will rmmod Mellanox driver.
#by Clover 2014.11.19
#--------------------------------------------#
for ko in mlx4_ib mlx4_en mlx4_core ib_ipoib ib_srp ib_ucm rdma_ucm rdma_cm iw_cm ib_cm ib_sa ib_umad ib_mad mlx5_ib mlx5_core ib_uverbs ib_core ib_core ib_addr scsi_transport_srp compat
do
        mod=`lsmod |grep $ko`
        if [ "$mod" != "" ];then
               
   		rmmod $ko
                echo "$ko removed !"
        fi

done
