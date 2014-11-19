ifconfig lan0 192.168.100.107
# ----Startup for infiniband driver and tools by Clover---- #
red='\e[0;31m'
nc='\e[0m'
#tar xf /DOM/infb.tgz -C /tmp
target=/lib/modules
source=/DOM/mlnx-driver-u12.04
#test ! -f /var/log/infb_driver.log && touch /var/log/infb_driver.log

cd $source

#cp driver to correct location

cd drivers
if [ -f $source/drivers/map ];then

	#Start to copy infiniband ko file to /lib/modules/`uname -r`/kernel/
	ker_v=`uname -r`

        while read line
        do
                test -z $line && continue
		test ! -z `echo $line |grep '#'` && continue
                dirc=`dirname $line`
                if [ -d $target/$ker_v/kernel/$dirc ];then
                        cp -af $line $target/$ker_v/kernel/$dirc
			if [ $? == "0" ];then
	                        echo -e " cp $line $target/$ker_v/kernel/$dirc Finish ."
			else
				echo -e "cp $line ${red}Failed${nc}"
			fi
                else
                        mkdir -p $target/$ker_v/kernel/$dirc
                        cp -af $line $target/$ker_v/kernel/$dirc
                        if [ $? == "0" ];then
                                echo  -e " cp $line $target/$ker_v/kernel/$dirc Finish ."
                        else
                                echo -e "cp $line ${red}Failed${nc}"
                        fi

                fi
        done < $source/drivers/map

else
	echo "Cant find driver map file!"
        exit -1
fi