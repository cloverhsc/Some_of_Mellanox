ifconfig lan0 192.168.100.107
# ----Startup for infiniband driver and tools by Clover---- #

tar xf /DOM/infb.tgz -C /tmp
target=/lib/modules
source=/tmp/infb
test ! -f /var/log/infb_driver.log && touch /var/log/infb_driver.log

cd $source

#cp driver to correct location

cd drivers
if [ -f $source/drivers/map ];then

	#Start to copy infiniband ko file to /lib/modules/`uname -r`/kernel/
	ker_v=`uname -r`

        while read line
        do
                test -z $line && continue
                dirc=`dirname $line`
                if [ -d $target/$ker_v/kernel/$dirc ];then
                        cp -af $line $target/$ker_v/kernel/$dirc
                        echo "`date` cp $line $target/$ker_v/kernel/$dirc Finish!" >> /var/log/infb_driver.log
                else
                        mkdir -p $target/$ker_v/kernel/$dirc
                        cp -af $line $target/$ker_v/kernel/$dirc
                        echo "`date` cp $line $target/$ker_v/kernel/$dirc Finish!" >> /var/log/infb_driver.log
                fi
        done < $source/drivers/map

else
	echo "Cant find driver map file!"
        exit -1
fi

#rmmod original infiniband driver
for i in mlx4_ib mlx4_en mlx4_core ib_umad ib_ipoib ib_cm ib_sa ib_mad ib_core
do
	rmmod $i
done

#modprobe new driver
/tmp/infb/mod_ib.sh

#------------tools------------------#

#ibdev2netdev
tool_source=/tmp/infb/tools
cp -af $tool_source/ibdev2netdev /usr/bin/

#opensmd daemon
cp -af $tool_source/opensmd /etc/init.d/opensmd
cp -af $tool_source/opensm /usr/sbin/
cp -af $tool_source/libibumad.so.3 /usr/lib/
cp -af $tool_source/libopensm.so.7 /usr/lib/
cp -af $tool_source/libosmcomp.so.3 /usr/lib/
cp -af $tool_source/libosmvendor.so.3 /usr/lib/

#connectx_port_config
cp -af $tool_source/connectx_port_config /sbin/
mkdir /etc/infiniband
touch /etc/infiniband/connectx.conf

#ib_send_bw
cp -af $tool_source/ib_send_bw /usr/bin/
cp -af $tool_source/libibumad.so.3 /usr/lib/
cp -af $tool_source/libibverbs.so.1 /usr/lib/
cp -af $tool_source/libibverbs.so.1.0.0 /usr/lib/
cp -af $tool_source/libibverbs.so /usr/lib/
cp -af $tool_source/librdmacm.a /usr/lib/
cp -af $tool_source/librdmacm.so /usr/lib/
cp -af $tool_source/librdmacm.so.1 /usr/lib/
cp -af $tool_source/librdmacm.so.1.0.0 /usr/lib/
cp -af $tool_source/libnl.so.1 /usr/lib/x86_64-linux-gnu/
cp -af $tool_source/libibverbs.d /etc/
cp -af $tool_source/libibverbs /usr/lib/

#ibstat
cp -af $tool_source/ibstat /usr/sbin
cp -af $tool_source/libibmad.* /usr/lib/
cp -af $tool_source/libibumad.so.3 /usr/lib


rm -rf /tmp/infb
