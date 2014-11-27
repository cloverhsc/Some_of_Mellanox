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
cp -af $tool_source/libibumad.* /usr/lib/
cp -af $tool_source/libopensm.* /usr/lib/
cp -af $tool_source/libosmcomp.* /usr/lib/
cp -af $tool_source/libosmvendor.* /usr/lib/

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
cp -af $tool_source/libpthread.so.0 /lib/x86_64-linux-gnu/
cp -af $tool_source/libc.so.6 /lib/x86_64-linux-gnu/

#ibstatus
cp -af $tool_source/ibstatus /usr/bin/

#ibping
cp -af $tool_source/ibping /usr/sbin/
cp -af $tool_source/libosmcomp.* /usr/lib/
cp -af $tool_source/libibmad.* /usr/lib/
cp -af $tool_source/libibumad.* /usr/lib

#ibnetdiscover
cp -af $tool_source/ibnetdiscover /usr/sbin/
cp -af $tool_source/libibnetdisc.* /usr/lib/

#ibhosts
cp -af $tool_source/ibhosts /usr/sbin/

#iblinkinfo
cp -af $tool_source/iblinkinfo /usr/sbin/

#ibacm
cp -af $tool_source/ibacm /usr/sbin

#ibaddr
cp -af $tool_source/ibaddr /usr/sbin

#ibcacheedit
cp -af $tool_source/ibcacheedit /usr/sbin/

#ibccconfig
cp -af $tool_source/ibccconfig /usr/sbin/

#ibccquery
cp -af $tool_source/ibccquery /usr/sbin/

#ibcheckerrors
cp -af $tool_source/ibcheckerrors /usr/sbin/
cp -af $tool_source/ibchecknode /usr/sbin/

#ibcheckerrs
cp -af $tool_source/ibcheckerrs /usr/sbin/

#ibchecknet
cp -af $tool_source/ibchecknet /usr/sbin/
cp -af $tool_source/ibcheckport /usr/sbin/

#ibcheckport
cp -af $tool_source/ibcheckport /usr/sbin/

#ibcheckportstate
cp -af $tool_source/ibcheckportstate /usr/sbin/

#ibcheckportwidth
cp -af $tool_source/ibcheckportwidth /usr/sbin/

#ibcheckstate
cp -af $tool_source/ibcheckstate /usr/sbin/

#ibcheckwidth
cp -af $tool_source/ibcheckwidth /usr/sbin/

#ibclearcounters
cp -af $tool_source/ibclearcounters /usr/sbin
cp -af $tool_source/perfquery /usr/sbin/

#perfquery
cp -af $tool_source/perfquery /usr/sbin/

#ibclearerrors
cp -af $tool_source/ibclearerrors /usr/sbin/

#ibdatacounters
cp -af $tool_source/ibdatacounters /usr/sbin/
cp -af $tool_source/ibchecknode /usr/sbin

#ibdiscover.pl
cp -af $tool_source/ibdiscover.pl /usr/sbin/

#ibfindnodesusing.pl
cp -af $tool_source/ibfindnodesusing.pl /usr/sbin/

#ibidsverify.pl
cp -af $tool_source/ibidsverify.pl /usr/sbin/

#iblinkinfo.pl
cp -af $tool_source/iblinkinfo.pl /usr/sbin/

#ibmirror
cp -af $tool_source/ibmirror /usr/sbin/

#ibnodes
cp -af $tool_source/ibnodes /usr/sbin/

#ibportstate
cp -af $tool_source/ibportstate /usr/sbin/

#ibprintca.pl
cp -af $tool_source/ibprintca.pl /usr/sbin/

#ibprintrt.pl
cp -af $tool_source/ibprintrt.pl /usr/sbin/

#ibprintswitch.pl
cp -af $tool_source/ibprintswitch.pl /usr/sbin/

#ibqueryerrors
cp -af $tool_source/ibqueryerrors /usr/sbin/

#openibd
cp -af $tool_source/openibd /etc/init.d/
 # It's need to check openib.conf and recover configuration after reboot !!
cp -af $tool_source/infiniband /etc/
touch /etc/debian_version

ldconfig
ifconfig ib0 192.168.99.104

/etc/init.d/opensmd restart
rm -rf /tmp/infb
#insmod /DOM/svcrdma.ko
insmod /DOM/xprtrdma.ko
