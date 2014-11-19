#!/bin/bash
#need first modprobe compat then do others
depmod
mod=`lsmod |grep compat`
if [ "$mod" == "" ];then
	insmod /lib/modules/3.13.11/kernel/compat/compat.ko
        sleep 1
else
        echo "compat in used !"
        exit 1
fi

for ko in mlx4_core mlx4_en rdma_cm rdma_ucm ib_core ib_mad ib_sa ib_umad ib_uverbs ib_ipoib ib_ucm iw_cm ib_srp scsi_transport_srp ib_addr ib_cm ib_sa ib_mad mlx4_ib mlx5_core mlx5_ib

do
	mod=`lsmod |grep $ko`
	if [ "$mod" == "" ];then
	        `modprobe $ko`
		echo "modprobe $ko"
	      	sleep 1
	else
	        echo "$ko in used !"
	fi

done


