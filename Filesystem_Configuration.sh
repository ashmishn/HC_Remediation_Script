#IZ.C.1.1.2
findmnt --kernel /tmp
if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /tmp" >>p2
	echo "Separate partition exists for /tmp" >>p3
	echo "IZ.C.1.1.2">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /tmp" >>p2
	echo "Separate partition does not exist for /tmp" >>p3
	echo "IZ.C.1.1.2">>p12
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.C.1.1.3 
findmnt --kernel /tmp
if [ $? -eq 0 ];then
	findmnt --kernel /tmp | grep nodev
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /tmp partition" >>p2
		echo "nodev option is set on /tmp partition" >>p3
		echo "IZ.C.1.1.3">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/tmp"  |awk '{print $4}'`
		sed -i 's/\s\/tmp.*'$sk'/&,nodev/' /etc/fstab
		mount -o remount,nodev /tmp
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /tmp partition" >>p2
		echo "nodev option is not set on /tmp partition" >>p3
		echo "IZ.C.1.1.3">>p12
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	fi
else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /tmp partition" >>p2
		echo "/tmp FS not exists" >>p3
		echo "IZ.C.1.1.3">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi


#IZ.C.1.1.4
findmnt --kernel /tmp
if [ $? -eq 0 ];then
	findmnt --kernel /tmp | grep nosuid
	if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure nosuid option set on /tmp partition" >>p2
	echo "nosuid option is set on /tmp partition" >>p3
	echo "IZ.C.1.1.4">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else
	sk=`cat /etc/fstab |grep -v '#' |grep -w "/tmp"  |awk '{print $4}'`
	sed -i 's/\s\/tmp.*'$sk'/&,nosuid/' /etc/fstab
	mount -o remount,nodev /tmp
	echo "Filesystem Configuration" >>p1
	echo "Ensure nosuid option set on /tmp partition" >>p2
	echo "nosuid option is not set on /tmp partition" >>p3
	echo "IZ.C.1.1.4">>p12
	echo "Modified" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi
else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /tmp partition" >>p2
		echo "/tmp FS not exists" >>p3
		echo "IZ.C.1.1.4">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi



#IZ.C.1.1.5 
findmnt --kernel /tmp
if [ $? -eq 0 ];then
	findmnt --kernel /tmp | grep noexec
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure noexec option set on /tmp partition" >>p2
		echo "noexec option is set on /tmp partition" >>p3
		echo "IZ.C.1.1.5">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/tmp"  |awk '{print $4}'`
		sed -i 's/\s\/tmp.*'$sk'/&,noexec/' /etc/fstab
		mount -o remount,noexec /tmp
		echo "Filesystem Configuration" >>p1
		echo "Ensure noexec option set on /tmp partition" >>p2
		echo "noexec option is not set on /tmp partition" >>p3
		echo "IZ.C.1.1.5">>p12
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	fi
else
		echo "Filesystem Configuration" >>p1
		echo "Ensure noexec option set on /tmp partition" >>p2
		echo "/tmp FS not exists" >>p3
		echo "IZ.C.1.1.5">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi



#IZ.C.1.1.6
findmnt --kernel /var
if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var" >>p2
	echo "Separate partition exists for /var" >>p3
	echo "IZ.C.1.1.6">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var" >>p2
	echo "Separate partition does not exist for /var" >>p3
	echo "IZ.C.1.1.6">>p12
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.C.1.1.7
findmnt --kernel /var/tmp
if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var/tmp" >>p2
	echo "Separate partition exists for /var/tmp" >>p3
	echo "IZ.C.1.1.7">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else

	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var/tmp" >>p2
	echo "Separate partition does not exist for /var/tmp" >>p3
	echo "IZ.C.1.1.7">>p12
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.C.1.1.8 
findmnt --kernel /var/tmp
if [ $? -eq 0 ];then
	findmnt --kernel /var/tmp | grep nodev
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /var/tmp partition" >>p2
		echo "nodev option is set on /var/tmp partition" >>p3
		echo "IZ.C.1.1.8">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/var/tmp"  |awk '{print $4}'`
		sed -i 's/\s\/var\/tmp.*'$sk'/&,nodev/' /etc/fstab
		mount -o remount,nodev /var/tmp
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /var/tmp partition" >>p2
		echo "nodev option is not set on /var/tmp partition" >>p3
		echo "IZ.C.1.1.8">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /var/tmp partition" >>p2
		echo "/var/tmp FS not exists" >>p3
		echo "IZ.C.1.1.8">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi


#IZ.C.1.1.9 
findmnt --kernel /var/tmp
if [ $? -eq 0 ];then
	findmnt --kernel /var/tmp | grep nosuid
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /var/tmp partition" >>p2
		echo "nosuid option is set on /var/tmp partition" >>p3
		echo "IZ.C.1.1.9">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/var/tmp"  |awk '{print $4}'`
		sed -i 's/\s\/var\/tmp.*'$sk'/&,nosuid/' /etc/fstab
		mount -o remount,nosuid /var/tmp
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /var/tmp partition" >>p2
		echo "nosuid option is not set on /var/tmp partition" >>p3
		echo "IZ.C.1.1.9">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /var/tmp partition" >>p2
		echo "/var/tmp FS not exists" >>p3
		echo "IZ.C.1.1.9">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi



#IZ.C.1.1.10 
findmnt --kernel /var/tmp
if [ $? -eq 0 ];then
	findmnt --kernel /var/tmp | grep noexec
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure noexec option set on /var/tmp partition" >>p2
		echo "noexec option is set on /var/tmp partition" >>p3
		echo "IZ.C.1.1.10">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/var/tmp"  |awk '{print $4}'`
		sed -i 's/\s\/var\/tmp.*'$sk'/&,noexec/' /etc/fstab
		mount -o remount,noexec /var/tmp
		echo "Filesystem Configuration" >>p1
		echo "Ensure noexec option set on /var/tmp partition" >>p2
		echo "noexec option is not set on /var/tmp partition" >>p3
		echo "IZ.C.1.1.10">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure noexec option set on /var/tmp partition" >>p2
		echo "/var/tmp FS not exists" >>p3
		echo "IZ.C.1.1.10">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi

#IZ.C.1.1.11
findmnt --kernel /var/log
if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var/log" >>p2
	echo "Separate partition exists for /var/log" >>p3
	echo "IZ.C.1.1.11">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else

	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var/log" >>p2
	echo "Separate partition does not exist for /var/log" >>p3
	echo "IZ.C.1.1.11">>p12
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi

#IZ.C.1.1.12
findmnt --kernel /var/log/audit
if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var/log/audit" >>p2
	echo "Separate partition exists for /var/log/audit" >>p3
	echo "IZ.C.1.1.12">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else

	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /var/log/audit" >>p2
	echo "Separate partition does not exist for /var/log/audit" >>p3
	echo "IZ.C.1.1.12">>p12
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.C.1.1.13
findmnt --kernel /home
if [ $? -eq 0 ];then
	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /home" >>p2
	echo "Separate partition exists for /home" >>p3
	echo "IZ.C.1.1.13">>p12
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
else

	echo "Filesystem Configuration" >>p1
	echo "Ensure separate partition exists for /home" >>p2
	echo "Separate partition does not exist for /home" >>p3
	echo "IZ.C.1.1.13">>p12
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.C.1.1.14 
findmnt --kernel /home
if [ $? -eq 0 ];then
	findmnt --kernel /home | grep nodev
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /home partition" >>p2
		echo "nodev option is set on /home partition" >>p3
		echo "IZ.C.1.1.14">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/home"  |awk '{print $4}'`
		sed -i 's/\s\/home.*'$sk'/&,nodev/' /etc/fstab
		mount -o remount,nodev /home
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /home partition" >>p2
		echo "nodev option is not set on /home partition" >>p3
		echo "IZ.C.1.1.14">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /home partition" >>p2
		echo "/home FS not exists" >>p3
		echo "IZ.C.1.1.14">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi

#IZ.C.1.1.15
findmnt --kernel /dev/shm
if [ $? -eq 0 ];then
	findmnt --kernel /dev/shm | grep nodev
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /dev/shm partition" >>p2
		echo "nodev option is set on /dev/shm partition" >>p3
		echo "IZ.C.1.1.15">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/dev/shm"  |awk '{print $4}'`
		sed -i 's/\s\/dev\s/shm.*'$sk'/&,nodev/' /etc/fstab
		mount -o remount,nodev /dev/shm
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /dev/shm partition" >>p2
		echo "nodev option is not set on /dev/shm partition" >>p3
		echo "IZ.C.1.1.15">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nodev option set on /dev/shm partition" >>p2
		echo "/dev/shm FS not exists" >>p3
		echo "IZ.C.1.1.15">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi

#IZ.C.1.1.16
findmnt --kernel /dev/shm
if [ $? -eq 0 ];then
	findmnt --kernel /dev/shm | grep nosuid
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /dev/shm partition" >>p2
		echo "nosuid option is set on /dev/shm partition" >>p3
		echo "IZ.C.1.1.16">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/dev/shm"  |awk '{print $4}'`
		sed -i 's/\s\/dev\s/shm.*'$sk'/&,nosuid/' /etc/fstab
		mount -o remount,nosuid /dev/shm
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /dev/shm partition" >>p2
		echo "nosuid option is not set on /dev/shm partition" >>p3
		echo "IZ.C.1.1.16">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /dev/shm partition" >>p2
		echo "/dev/shm FS not exists" >>p3
		echo "IZ.C.1.1.16">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi

#IZ.C.1.1.17
findmnt --kernel /dev/shm
if [ $? -eq 0 ];then
	findmnt --kernel /dev/shm | grep nosuid
	if [ $? -eq 0 ];then
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /dev/shm partition" >>p2
		echo "nosuid option is set on /dev/shm partition" >>p3
		echo "IZ.C.1.1.16">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		sk=`cat /etc/fstab |grep -v '#' |grep -w "/dev/shm"  |awk '{print $4}'`
		sed -i 's/\s\/dev\s/shm.*'$sk'/&,nosuid/' /etc/fstab
		mount -o remount,nosuid /dev/shm
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /dev/shm partition" >>p2
		echo "nosuid option is not set on /dev/shm partition" >>p3
		echo "IZ.C.1.1.16">>p12
		echo "Modified" >>p4	
		echo "$c" >> p5
		echo "$z" >>p6
	fi

else
		echo "Filesystem Configuration" >>p1
		echo "Ensure nosuid option set on /dev/shm partition" >>p2
		echo "/dev/shm FS not exists" >>p3
		echo "IZ.C.1.1.16">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6

fi

#IZ.C.1.1.1.1
sk=`modprobe -n -v cramfs |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep cramfs`
        if [ $? -eq 0 ] ; then
                rmmod cramfs &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of cramfs filesystems is disabled">>p2
                echo "mounting of cramfs filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.1">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of cramfs filesystems is disabled">>p2
                echo "mounting of cramfs filesystems is disabled">>p3
                echo "IZ.C.1.1.1.1">>p12
                echo "yes" >>p4
        fi
else
        echo "install cramfs /bin/true" >/etc/modprobe.d/cramfs.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of cramfs filesystems is disabled" >>p2
        echo "mounting of cramfs filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.1">>p12
        echo "Modified"  >p4
fi



#IZ.C.1.1.1.2
sk=`modprobe -n -v freevxfs |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep freevxfs`
        if [ $? -eq 0 ] ; then
                rmmod freevxfs &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of freevxfs filesystems is disabled">>p2
                echo "mounting of freevxfs filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.2">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of freevxfs filesystems is disabled">>p2
                echo "mounting of freevxfs filesystems is disabled">>p3
                echo "IZ.C.1.1.1.2">>p12
                echo "yes" >>p4
        fi
else
        echo "install freevxfs /bin/true" >/etc/modprobe.d/freevxfs.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of freevxfs filesystems is disabled" >>p2
        echo "mounting of freevxfs filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.2">>p12
        echo "Modified"  >p4
fi




#IZ.C.1.1.1.3
sk=`modprobe -n -v jffs2 |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep jffs2`
        if [ $? -eq 0 ] ; then
                rmmod jffs2 &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of jffs2 filesystems is disabled">>p2
                echo "mounting of jffs2 filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.3">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of jffs2 filesystems is disabled">>p2
                echo "mounting of jffs2 filesystems is disabled">>p3
                echo "IZ.C.1.1.1.3">>p12
                echo "yes" >>p4
        fi
else
        echo "install jffs2 /bin/true" >/etc/modprobe.d/jffs2.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of jffs2 filesystems is disabled" >>p2
        echo "mounting of jffs2 filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.3">>p12
        echo "Modified"  >p4
fi



#IZ.C.1.1.1.4
sk=`modprobe -n -v hfs |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep hfs`
        if [ $? -eq 0 ] ; then
                rmmod hfs &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of hfs filesystems is disabled">>p2
                echo "mounting of hfs filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.4">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of hfs filesystems is disabled">>p2
                echo "mounting of hfs filesystems is disabled">>p3
                echo "IZ.C.1.1.1.4">>p12
                echo "yes" >>p4
        fi
else
        echo "install hfs /bin/true" >/etc/modprobe.d/hfs.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of hfs filesystems is disabled" >>p2
        echo "mounting of hfs filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.4">>p12
        echo "Modified"  >p4
fi


#IZ.C.1.1.1.5
sk=`modprobe -n -v hfsplus |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep hfsplus`
        if [ $? -eq 0 ] ; then
                rmmod hfsplus &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of hfsplus filesystems is disabled">>p2
                echo "mounting of hfsplus filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.5">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of hfsplus filesystems is disabled">>p2
                echo "mounting of hfsplus filesystems is disabled">>p3
                echo "IZ.C.1.1.1.5">>p12
                echo "yes" >>p4
        fi
else
        echo "install hfsplus /bin/true" >/etc/modprobe.d/hfsplus.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of hfsplus filesystems is disabled" >>p2
        echo "mounting of hfsplus filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.5">>p12
        echo "Modified"  >p4
fi


#IZ.C.1.1.1.6
sk=`modprobe -n -v squashfs |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep squashfs`
        if [ $? -eq 0 ] ; then
                rmmod squashfs &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of squashfs filesystems is disabled">>p2
                echo "mounting of squashfs filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.6">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of squashfs filesystems is disabled">>p2
                echo "mounting of squashfs filesystems is disabled">>p3
                echo "IZ.C.1.1.1.6">>p12
                echo "yes" >>p4
        fi
else
        echo "install squashfs /bin/true" >/etc/modprobe.d/squashfs.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of squashfs filesystems is disabled" >>p2
        echo "mounting of squashfs filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.6">>p12
        echo "Modified"  >p4
fi


#IZ.C.1.1.1.7
sk=`modprobe -n -v udf |grep "^install.*/bin/true"`
if [ $? -eq 0 ];then
        ts=`lsmod | grep udf`
        if [ $? -eq 0 ] ; then
                rmmod udf &>2
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of udf filesystems is disabled">>p2
                echo "mounting of udf filesystems is not disabled">>p3
                echo "IZ.C.1.1.1.7">>p12
                echo "Modified" >>p4
        else
                echo "Filesystem Configuration" >>p1
                echo "Ensure mounting of udf filesystems is disabled">>p2
                echo "mounting of udf filesystems is disabled">>p3
                echo "IZ.C.1.1.1.7">>p12
                echo "yes" >>p4
        fi
else
        echo "install udf /bin/true" >/etc/modprobe.d/udf.conf
        echo "Filesystem Configuration" >>p1
        echo "Ensure mounting of udf filesystems is disabled" >>p2
        echo "mounting of udf filesystems is not disabled" >>p3
        echo "IZ.C.1.1.1.7">>p12
        echo "Modified"  >p4
fi


#IZ.C.1.6.1.5
rpm -q mcstrans
if [ $? -eq 0 ] ; then
	yum remove mcstrans -y
	echo "Mandatory Access Control" >>p1
	echo "Ensure the MCS Translation Service (mcstrans) is not installed" >>p2
	echo "MCS Translation Service (mcstrans) is   installed" >>p3
	echo "IZ.C.1.6.1.5">>p12
	echo "Modified" >>p4
else
	echo "Mandatory Access Control" >>p1
	echo "Ensure the MCS Translation Service (mcstrans) is not installed" >>p2
	echo "MCS Translation Service (mcstrans) is not installed" >>p3
	echo "IZ.C.1.6.1.5">>p12
	echo "Yes" >>p4
fi
