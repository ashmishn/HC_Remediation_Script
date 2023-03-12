#IZ.1.8.1.2
echo "~root/.rhosts,~root/.netrc,,/usr,/etc,/boot,/boot/grub2,/etc/security/opasswd,/etc/shadow,/etc/gshadow,/etc/shadow-,/etc/gshadow-,/etc/crontab,/etc/cron.hourly,/etc/cron.daily,/etc/cron.weekly,/etc/cron.monthly,/etc/cron.d,/var,/var/log,/var/log/tallylog,/var/log/messages,/var/log/wtmp,/var/log/secure,/tmp,/etc/snmp/snmpd.conf,/var/tmp,/etc/profile.d/Kyndrylsinit.sh,/etc/profile.d/Kyndrylsinit.csh,/etc/yum.repos.d,/etc/yum.conf,/var/spool/cron/root,/etc/crontab,/etc/rc.d/rc0.d,/etc/rc.d/rc1.d,/etc/rc.d/rc2.d,/etc/rc.d/rc3.d,/etc/rc.d/rc4.d ,/etc/rc.d/rc5.d,/etc/rc.d/rc6.d ,/etc/rc.d/rcS.d" > temp

tr "," "\n" < temp > temp1

Release=`cat /etc/os-release |grep -w "VERSION="|awk -F"=" '{print $2}'|cut -c2-|awk -F"." '{print $1}'`

if [ "$Release" == "7" ]
then
uid_minimum=`cat /etc/login.defs |grep ^UID_MIN|awk '{print $2}'`
	for i in `cat temp1`
	do
	if [ -f $i ] || [ -d $i ]
	then
		sj=`ls -lnd $i |awk '{print $3}'`
		ss=`ls -ld $i |awk '{print $3}'`
		if [ $sj -le $uid_minimum ]
		then
			echo "Protecting Resources - OSRs" >>p1
			echo "User Ownership" >>p2
			echo "The file or dir $i is owned by $ss - Permission is Valid" >>p3 
			echo "yes" >>p4
			echo "$c"  >>p5
			echo "$z"  >>p6
			echo "IZ.1.8.1.2" >>p12
		else
			chown root $i
			echo "Protecting Resources - OSRs" >>p1
			echo "User Ownership" >>p2
			echo "The file or dir $i is owned by $ss - Permission changed to root" >>p3
			echo "Modified" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.8.1.2" >>p12
		fi
	else
		echo "Protecting Resources - OSRs" >>p1
		echo "User Ownership" >>p2
		echo "The file or dir $i - File Doesn't Exists" >>p3
		echo "yes" >>p4
		echo "$c"  >>p5
		echo "$z"  >>p6
		echo "IZ.1.8.1.2" >>p12
	fi
	done
elif [ "$Release" == "8" ]
then
sys_uid_max=`cat /etc/login.defs |grep ^SYS_UID_MAX|awk '{print $2}'`

	for i in `cat temp1`
	do
	if [ -f $i ] || [ -d $i ]
	then
		sj=`ls -lnd $i |awk '{print $3}'`
		ss=`ls -ld $i |awk '{print $3}'`
		if [ $sj -le $sys_uid_max ]
		then
			echo "Protecting Resources - OSRs" >>p1
			echo "User Ownership" >>p2
			echo "The file or dir $i is owned by $ss - Permission is Valid" >>p3
			echo "yes" >>p4
			echo "$c" >>p5 
			echo "$z" >>p6
			echo "IZ.1.8.1.2" >>p12
		else
			chown root $i
			echo "Protecting Resources - OSRs" >>p1
			echo "User Ownership" >>p2
			echo "The file or dir $i is owned by $ss - Permission changed to root" >>p3
			echo "Modified" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.8.1.2" >>p12
		fi
	else
		echo "Protecting Resources - OSRs" >>p1
		echo "User Ownership" >>p2
		echo "The file or dir $i - File Doesn't Exists" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.1.2" >>p12
	fi
	done
else
	echo "Protecting Resources - OSRs" >>p1
	echo "User Ownership" >>p2
	echo "Its not RHEL"  >>p3
	echo "yes" >>p4
	echo "$c" >>p5
	echo "$z" >>p6
	echo "IZ.1.8.1.2" >>p12
fi


##########################################################################################################################333333

#IZ.1.8.1.3
echo "~root/.rhosts,~root/.netrc,,/usr,/etc,/boot,/boot/grub2,/etc/security/opasswd,/etc/shadow,/etc/gshadow,/etc/shadow-,/etc/gshadow-,/etc/crontab,/etc/cron.hourly,/etc/cron.daily,/etc/cron.weekly,/etc/cron.monthly,/etc/cron.d,/var,/var/log,/var/log/tallylog,/var/log/messages,/var/log/wtmp,/var/log/secure,/tmp,/etc/snmp/snmpd.conf,/var/tmp,/etc/profile.d/Kyndrylsinit.sh,/etc/profile.d/Kyndrylsinit.csh,/etc/yum.repos.d,/etc/yum.conf,/var/spool/cron/root,/etc/crontab,/etc/rc.d/rc0.d,/etc/rc.d/rc1.d,/etc/rc.d/rc2.d,/etc/rc.d/rc3.d,/etc/rc.d/rc4.d ,/etc/rc.d/rc5.d,/etc/rc.d/rc6.d ,/etc/rc.d/rcS.d" > temp

tr "," "\n" < temp > temp1

Release=`cat /etc/os-release |grep -w "VERSION="|awk -F"=" '{print $2}'|cut -c2-|awk -F"." '{print $1}'`
if [ $Release == "7" ]
then

gid_minimum=`cat /etc/login.defs |grep ^GID_MIN|awk '{print $2}'`
	for i in `cat temp1`
	do
	if [ -f $i ] || [ -d $i ]
	then
		sk=`ls -lnd $i |awk '{print $4}'`
		ss=`ls -ld $i |awk '{print $4}'`
		if [ $sk -le $gid_minimum ] && [ $sk -ne 100 ]
		then
			echo "Protecting Resources - OSRs" >>p1
			echo "Groupids assigned to OSRs" >>p2
			echo "This file or dir $i group is owned by $ss - Permission is Valid" >>p3
			echo "yes" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.8.1.3" >>p12
		else
			chgrp root $i
			echo "Protecting Resources - OSRs" >>p1
			echo "Groupids assigned to OSRs"  >>p2
			echo "This file or dir $i is group owned by $ss - Permission is changed to root" >>p3
			echo "Modified" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.8.1.3" >>p12
		fi
	else
		echo "Protecting Resources - OSRs" >>p1
		echo "Groupids assigned to OSRs" >>p2
		echo "This file or dir $i - File Doesnt Exists" >>p3
		echo "yes" >>p4
		echo "$c"  >>p5
		echo "$z"  >>p6
		echo "IZ.1.8.1.3" >>p12
	fi
	done

elif [ $Release == "8" ]
then

sys_gid_max=`cat /etc/login.defs |grep ^SYS_GID_MAX |awk '{print $2}'`
	for i in `cat temp1`
	do
	if [ -f $i ] || [ -d $i ]
	then
		sk=`ls -lnd $i |awk '{print $4}'`
		ss=`ls -ld $i |awk '{print $4}'`
		if [ $sk -le $sys_gid_max ] && [ $sk -ne 100 ]
		then
			echo "Protecting Resources - OSRs" >>p1
			echo "Groupids assigned to OSRs"  >>p2
			echo "This file or dir $i group is owned by $ss - Permission is Valid" >>p3
			echo "yes" >>p4
			echo "$c"  >>p5
			echo "$z"  >>p6
			echo "IZ.1.8.1.3" >>p12
		else
			chgrp root $i
			echo "Protecting Resources - OSRs" >>p1
			echo "Groupids assigned to OSRs"  >>p2
			echo "This file or dir $i is group owned by $ss - Permission is changed to root" >>p3
			echo "Modified" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.8.1.3" >>p12
		fi
	else
		echo "Protecting Resources - OSRs" >>p1
		echo "Groupids assigned to OSRs" >>p2
		echo "This file or dir $i - File Doesnt Exists" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.1.3" >>p12
	fi
	done

else
	echo "Protecting Resources - OSRs" >>p1
	echo "User Ownership" >>p2
	echo "Its not RHEL" >>p3
	echo "yes" >>p4
	echo "$c" >>p5
	echo "$z" >>p6
	echo "IZ.1.8.1.3" >>p12
fi

#IZ.1.8.2.1
if [ -f ~root/.rhosts ]
then
	sz=$(stat -c "%a %n" ~root/.rhosts |awk '{print $1}')
	sk=`ls -ld ~root/.rhosts |awk '{print $4}'`
	if [ "$sz" == "600" ] && [ "$sk" == "root" ]
	then
		echo "Protecting Resources - OSRs" >>p1
		echo "~root/.rhosts" >>p2
		echo "The-file-is-read-write-only-by-root" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.2.1" >>p12
	else
		chmod 600 ~root/.rhosts
		chown root:root ~root/.rhosts
		echo "Protecting Resources - OSRs" >>p1
		echo "~root/.rhosts" >>p2
		echo "The-file-permission-is-modified" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.2.1" >>p12
	fi
else
		echo "Protecting Resources - OSRs" >>p1
		echo "~root/.rhosts" >>p2
		echo "The-file-is-not-available" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.2.1" >>p12
fi


#IZ.1.8.2.2
if [ -f ~root/.netrc ]
then
	sz=$(stat -c "%a %n" ~root/.netrc |awk '{print $1}')
	sk=`ls -ld ~root/.rhosts |awk '{print $4}'`
	if [ "$sz" == "600" ] && [ "$sk" == "root" ]
	then
		echo "Protecting Resources - OSRs" >>p1
		echo "~root/.netrc" >>p2
		echo "The-file-is-read-write-only-by-root" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.2.2" >>p12
	else
		chmod 600 ~root/.netrc
		chown root:root ~root/.netrc
		echo "Protecting Resources - OSRs" >>p1
		echo "~root/.netrc" >>p2
		echo "The-file-permission-is-modified" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.2.2" >>p12
	fi
else
		echo "Protecting Resources - OSRs" >>p1
		echo "~root/.netrc" >>p2
		echo "The-file-is-not-available" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.2.2" >>p12
fi

#IZ.1.8.3.1
str=`ls -ld / |awk '{print $1}' |cut -c9`
str1=`getfacl / |grep other |awk -F"::" '{print $2}' |cut -c 2`
sp=`getfacl / |grep other`
if [ "$str" == "w" ] || [ "$str1" == "w" ]
then
		chmod o-w /
		echo "Protecting Resources - OSRs" >>p1
		echo "/-dir-permission" >>p2
		echo "/-dir-is-writtable-by-others and ACL for / is set as '$sp'" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.1" >>p12
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/-dir-permission" >>p2
		echo "/-dir-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.1" >>p12
fi

#IZ.1.8.3.3
str=`ls -ld /etc |awk '{print $1}' |cut -c9`
if [ "$str" == "w" ]
then
		chmod o-w /etc
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc-dir-permission" >>p2
		echo "/etc-dir-is-writtable-by-others" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.3" >>p12
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc-dir-permission" >>p2
		echo "/etc-dir-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.3" >>p12
fi

#IZ.1.8.4.1
if [ -f /etc/security/opasswd ]
then
str=$(stat -c "%a %n" /etc/security/opasswd |awk '{print $1}')
if [ "$str" == "600" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/security/opasswd-permission" >>p2
		echo "/etc/security/opasswd-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.1" >>p12
else
		chmod g-wrx,o-wrx,u-x /etc/security/opasswd
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/security/opasswd-permission" >>p2
		echo "/etc/security/opasswd-permission-is-incorrect" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.1" >>p12
fi
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/security/opasswd-permission" >>p2
		echo "/etc/security/opasswd file not exist" >>p3
		echo "no" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.1" >>p12
fi

#IZ.1.8.5.1
str=`ls -ld /var |awk '{print $1}' |cut -c9`
if [ "$str" == "w" ]
then
		chmod o-w /var
		echo "Protecting Resources - OSRs" >>p1
		echo "/var-dir-permission" >>p2
		echo "/var-dir-is-writtable-by-others" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.5.1" >>p12
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/var-dir-permission" >>p2
		echo "/var-dir-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.5.1" >>p12
fi


#IZ.1.8.5.2
find /var/log -type d -perm /o+w \! -perm -1000 >world-writable-test
sk=`cat world-writable-test |wc -l`
if [ $sk -gt 0 ]
then
for i in `cat world-writable-test |grep -v "/bin/slogin"`
do
	chmod o-w $i
	echo "Protecting Resources - OSRs" >>p1
	echo "/var/log and it's sub-directories permissions" >>p2
	echo "Permission is invalid for $i" >> p3
	echo "Modified" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo IZ.1.8.5.2 >>p12
done
else
	echo "Protecting Resources - OSRs" >>p1
	echo "/var/log and it's sub-directories permissions" >>p2
	echo "Permission-is-valid for /var/log and it's sub-directories" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo IZ.1.8.5.2 >>p12
	echo "$z" >>p6
fi
rm -rf world-writable-test



#IZ.1.8.6.2
if [ $(grep -v '^\s*#' /etc/pam.d/system-auth | grep pam_tally2.so |wc -l) -gt 0 ] || [ $(grep -v '^\s*#' /etc/pam.d/password-auth | grep pam_tally2.so |wc -l) -gt 0 ]
then
	str6=$(stat -c "%a %n" /var/log/tallylog |awk '{print $1}')
	if [ "$str6" == "600" ]
	then
			echo "Protecting Resources - OSRs" >>p1
			echo "/var/log/tallylog" >>p2
			echo "/var/log/tallylog-Permission-is-valid" >> p3
			echo "yes" >>p4
			echo "$c" >> p5
			echo "$z" >>p6
			echo "IZ.1.8.6.2" >>p12
	else
			chmod g-wrx,o-wrx,u-x /var/log/tallylog
			echo "Protecting Resources - OSRs" >>p1
			echo "/var/log/tallylog" >>p2
			echo "/var/log/tallylog-Permission-is-invalid" >> p3
			echo "Modified" >>p4
			echo "$c" >> p5
			echo "$z" >>p6
			echo "IZ.1.8.6.2" >>p12
	fi
else
			echo "Protecting Resources - OSRs" >>p1
			echo "/var/log/tallylog" >>p2
			echo "Not applicable as pam_tally2 is not in use" >> p3
			echo "Not_Applicable" >>p4
			echo "$c" >> p5
			echo "$z" >>p6
			echo "IZ.1.8.6.2" >>p12
fi


#IZ.1.8.7.1
str1=`ls -ld /var/log/messages | awk '{print $1}' | cut -c6`
str2=`ls -ld /var/log/messages | awk '{print $1}' | cut -c9`
#str5=$(stat -c "%a %n" /var/log/messages |awk '{print $1}')
#if [ "$str5" == "600" ] || [ "$str5" == "644" ] || [ "$str5" == "755" ]
if [ "$str1" != "w" ] && [ "$str2" != "w" ]
then
	echo "Protecting Resources - OSRs" >>p1
	echo "/var/log/messages-permissions" >>p2
	echo "/var/log/messages-permissions is set correct" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "IZ.1.8.7.1" >>p12
	echo "$z" >>p6
else
	chmod g-wx,o-wx /var/log/messages
	echo "Protecting Resources - OSRs" >>p1
	echo "/var/log/messages-permissions" >>p2
	echo "IZ.1.8.7.1" >>p12
	echo "/var/log/messages-permissions is not set correct" >> p3
	echo "Modified" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi

#IZ.1.8.7.2
str1=`ls -ld /var/log/wtmp | awk '{print $1}' | cut -c9`
if [ "$str1" == "w" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/var/log/wtmp-permission" >>p2
		echo "Permission-is-valid for /var/log/wtmp" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.7.2" >>p12
else
		chmod g-x,o-wx /var/log/wtmp
		echo "Protecting Resources - OSRs" >>p1
		echo "/var/log/wtmp-permission" >>p2
		echo "Permission-is-invalid for /var/log/wtmp" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.7.2" >>p12
fi

#IZ.1.8.8
str5=$(stat -c "%a %n" /var/log/secure |awk '{print $1}')
if [ "$str5" == "600" ] || [ "$str5" == "640" ] || [ "$str5" == "700" ] || [ "$str5" == "740" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/var/log/secure-permission" >>p2
		echo "Permission-is-valid for /var/log/secure" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.8" >>p12
else
		chmod g-wx,o-wrx /var/log/secure
		echo "Protecting Resources - OSRs" >>p1
		echo "/var/log/secure-permission" >>p2
		echo "Permission-is-invalid for /var/log/secure" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.8" >>p12
fi

#IZ.1.8.9
str7=$(stat -c "%a %n" /tmp |awk '{print $1}')
if [ "$str7" == "1777" ]
then
	echo "Protecting Resources - OSRs" >>p1
	echo "/tmp-permission" >>p2
	echo "/tmp-permission-is-valid" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo IZ.1.8.9 >>p12
else
	chmod 1777 /tmp
	echo "Protecting Resources - OSRs" >>p1
	echo "/tmp-permission" >>p2
	echo "/tmp-permission-is-invalid" >> p3
	echo IZ.1.8.9 >>p12
	echo "Modified" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi

#IZ.1.8.15.2:IZ.1.8.15.3:IZ.1.8.18.2:IZ.1.8.20.2:IZ.1.8.22.1:IZ.1.8.22.2:IZ.1.8.22.3:IZ.1.8.22.4:IZ.1.8.13.1.2:IZ.1.8.22.5

find /usr/local -type f -perm /o+w \! -perm -1000 >world-writable-test
find /usr/local -type d -perm /o+w \! -perm -1000 >>world-writable-test
find /var -type f -perm /o+w \! -perm -1000 >>world-writable-test
find /var -type d -perm /o+w \! -perm -1000 >>world-writable-test
find /etc -type f -perm /o+w \! -perm -1000 >>world-writable-test
find /etc -type d -perm /o+w \! -perm -1000 >>world-writable-test
find /opt -type f -perm /o+w \! -perm -1000 >>world-writable-test
find /opt -type d -perm /o+w \! -perm -1000 >>world-writable-test
find /tmp -type f -perm /o+w \! -perm -1000 >>world-writable-test
find /tmp -type d -perm /o+w \! -perm -1000 >>world-writable-test
find /etc/opt -type f -perm /o+w \! -perm -1000 >>world-writable-test
find /etc/opt -type d -perm /o+w \! -perm -1000 >>world-writable-test

cp /root/world-writable-test /root/world-writable-test-before-permission-change

fc=`cat world-writable-test|wc -l`

if [ $fc == 0 ] 
then
	echo "Protecting Resources - OSRs" >>p1
	echo "File-Directory-write-permissions-for-others" >>p2
	echo "No files and directories found deviation" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo IZ.1.8.15.2:IZ.1.8.15.3:IZ.1.8.18.2:IZ.1.8.20.2:IZ.1.8.22.1:IZ.1.8.22.2:IZ.1.8.22.3:IZ.1.8.22.4:IZ.1.8.13.1.2:IZ.1.8.22.5 >>p12
else
	for i in `cat world-writable-test`
	do
		chmod o-w $i
		echo "Protecting Resources - OSRs" >>p1
		echo "File-Directory-write-permissions-for-others" >>p2
		echo "$i has others write permission" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo IZ.1.8.15.2:IZ.1.8.15.3:IZ.1.8.18.2:IZ.1.8.20.2:IZ.1.8.22.1:IZ.1.8.22.2:IZ.1.8.22.3:IZ.1.8.22.4:IZ.1.8.13.1.2:IZ.1.8.22.5 >>p12
	done
fi
rm -rf world-writable-test

#IZ.1.8.10
if [ -f /etc/snmp/snmpd.conf ]
then
str1=$(stat -c "%a %n" /etc/snmp/snmpd.conf |awk '{print $1}')
	if [ "$str1" == "640" ]
	then
		echo "Protecting Resources - OSRs" >>p1
		echo "snmpd.conf-permission" >>p2
		echo "snmpd.conf-permission-is-valid as $str1" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.10" >>p12
	else
		chmod u-x,g-wx,o-rwx /etc/snmp/snmpd.conf
		echo "Protecting Resources - OSRs" >>p1
		echo "snmpd.conf-permission" >>p2
		echo "snmpd.conf-permission-is-invalid as $str1" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.10" >>p12
	fi
else
		echo "Protecting Resources - OSRs" >>p1
		echo "snmpd.conf-permission" >>p2
		echo "snmpd.conf-file-not-exist" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.10" >>p12
fi


#IZ.1.8.11
str7=$(stat -c "%a %n" /var/tmp |awk '{print $1}')
if [ "$str7" == "1777" ]
then
	echo "Protecting Resources - OSRs" >>p1
	echo "/var/tmp-permission" >>p2
	echo "/var/tmp-permission-is-valid" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.8.11" >>p12
else
	chmod 1777 /var/tmp
	echo "Protecting Resources - OSRs" >>p1
	echo "/var/tmp-permission" >>p2
	echo "/var/tmp-permission-is-invalid" >> p3
	echo "IZ.1.8.11" >>p12
	echo "Modified" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.1.8.12.6
if [ -f /etc/profile.d/Kyndrylsinit.sh ]
then
str4=`ls -l /etc/profile.d/Kyndrylsinit.sh | awk '{print $1}' | cut -c9`
str5=`ls -l /etc/profile.d/Kyndrylsinit.sh | awk '{print $1}' | cut -c6`
str6=`ls -l /etc/profile.d/Kyndrylsinit.sh | awk '{print $3}'`
str7=`ls -l /etc/profile.d/Kyndrylsinit.sh | awk '{print $4}'`
	if [ "$str4" != "w" ] && [ "$str5" != "w" ] && [ "$str6" == "root" ] && [ "$str7" == "root" ]
	then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/profile.d/Kyndrylsinit.sh-permissions" >>p2
		echo "/etc/profile.d/Kyndrylsinit.sh-permission-is-valid" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.12.6" >>p12
	else
		chmod 755 /etc/profile.d/Kyndrylsinit.sh
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/profile.d/Kyndrylsinit.sh-permissions" >>p2
		echo "/etc/profile.d/Kyndrylsinit.sh-permission-is-not-valid" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.12.6" >>p12
	fi
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/profile.d/Kyndrylsinit.sh-permissions" >>p2
		echo "/etc/profile.d/Kyndrylsinit.sh-file-not-exist" >> p3
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.12.6" >>p12
fi

#IZ.1.8.12.7
if [ -f /etc/profile.d/Kyndrylsinit.csh ]
then
str4=`ls -l /etc/profile.d/Kyndrylsinit.csh | awk '{print $1}' | cut -c9`
str5=`ls -l /etc/profile.d/Kyndrylsinit.csh | awk '{print $1}' | cut -c6`
str6=`ls -l /etc/profile.d/Kyndrylsinit.csh | awk '{print $3}'`
str7=`ls -l /etc/profile.d/Kyndrylsinit.csh | awk '{print $4}'`
	if [ "$str4" != "w" ] && [ "$str5" != "w" ] && [ "$str6" == "root" ] && [ "$str7" == "root" ]
	then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/profile.d/Kyndrylsinit.csh-permissions" >>p2
		echo "/etc/profile.d/Kyndrylsinit.csh-permission-is-valid" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.12.7" >>p12
	else
		chmod 755 /etc/profile.d/Kyndrylsinit.csh
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/profile.d/Kyndrylsinit.csh-permissions" >>p2
		echo "/etc/profile.d/Kyndrylsinit.csh-permission-is-not-valid" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.12.7" >>p12
	fi
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/profile.d/Kyndrylsinit.csh-permissions" >>p2
		echo "/etc/profile.d/Kyndrylsinit.csh-file-not-exist" >> p3
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.12.7" >>p12
fi


#IZ.1.8.14.1
sk=`cat /var/spool/cron/root |grep -v '#' |grep -v '^$' |awk '{print $6}' |wc -l`
if [ $sk -gt 0 ]
then
cat /var/spool/cron/root |grep -v '#' |grep -v '^$' |awk '{print $6}' >t1
while IFS= read -r line
do
        sk1=`echo $line |cut -c 1`
        if [ "$sk1" == "/" ]
        then
                echo "Protecting Resources - OSRs" >>p1
                echo "/var/spool/cron/root" >>p2
		echo "Full-path-is-specified-for-command- $line in-/var/spool/cron/root" >>p3
		echo "IZ.1.8.14.1" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
                echo "Protecting Resources - OSRs" >>p1
                echo "/var/spool/cron/root" >>p2
		echo "Full-path-is-not-specified-for-command- $line in-/var/spool/cron/root" >>p3
		echo "Manual_Check" >>p4
		echo "IZ.1.8.14.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
        fi
done <t1
else
		echo "Protecting Resources - OSRs" >>p1
                echo "/var/spool/cron/root" >>p2
		echo "No entry found in-/var/spool/cron/root" >>p3
		echo "IZ.1.8.14.1" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi
rm -rf t1


#IZ.1.8.14.2
sk=`cat /var/spool/cron/root |grep -v '#' |grep -v '^$' |awk '{print $6}' |wc -l`
if [ $sk -gt 0 ]
then
cat /var/spool/cron/root |grep -v '#' |grep -v '^$' |awk '{print $6}' >t1
while IFS= read -r line
do
        str=`find $line -type f -perm /o+w \! -perm -1000 |wc -l`
	if [ $str -eq 0 ]
    then
        echo "Protecting Resources - OSRs" >>p1
        echo "/var/spool/cron/root" >>p2
		echo "Permission for others in $line in /var/spool/cron/root is valid" >>p3
		echo "IZ.1.8.14.2" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		chmod o-w $line
        echo "Protecting Resources - OSRs" >>p1
        echo "/var/spool/cron/root" >>p2
		echo "Permission for others in $line in /var/spool/cron/root is invalid" >>p3
		echo "Modified" >>p4
		echo "IZ.1.8.14.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
    fi
done <t1
else
		echo "Protecting Resources - OSRs" >>p1
        echo "/var/spool/cron/root" >>p2
		echo "No system facility entries exist in-/var/spool/cron/root" >>p3
		echo "yes" >>p4
		echo "IZ.1.8.14.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi
rm -rf t1

#IZ.1.8.14.3
sk=`cat /var/spool/cron/root |grep -v '#' |grep -v '^$' |awk '{print $6}' |wc -l`
if [ $sk -gt 0 ]
then
cat /var/spool/cron/root |grep -v '#' |grep -v '^$' |awk '{print $6}' >t1
while IFS= read -r line
do
        str=`find $line -type f -perm /o+w \! -perm -1000 |wc -l`
	if [ $str -eq 0 ]
    then
        echo "Protecting Resources - OSRs" >>p1
        echo "/var/spool/cron/root" >>p2
		echo "Permission for group in $line in /var/spool/cron/root is valid" >>p3
		echo "IZ.1.8.14.3" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		chmod g-w $line
        echo "Protecting Resources - OSRs" >>p1
        echo "/var/spool/cron/root" >>p2
		echo "Permission for group in $line in /var/spool/cron/root is invalid" >>p3
		echo "Modified" >>p4
		echo "IZ.1.8.14.3" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
    fi
done <t1
else
		echo "Protecting Resources - OSRs" >>p1
        echo "/var/spool/cron/root" >>p2
		echo "No system facility entries exist in-/var/spool/cron/root" >>p3
		echo "yes" >>p4
		echo "IZ.1.8.14.3" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi
rm -rf t1

#IZ.1.8.15.1
cat /etc/crontab |grep -v '#' |egrep -v 'SHELL|PATH|MAILTO|HOME' |grep -v '^$' |awk '{print $6}' >t1
if [ $? -ne 0 ]
then
while IFS= read -r line
do
        sk1=`echo $line |cut -c 1`
        if [ "$sk1" == "/" ]
        then
                echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "Full-path-is-specified-for-command- $line in-/etc/crontab" >>p3
		echo "IZ.1.8.15.1" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
                echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "Full-path-is-not-specified-for-command- $line in-/etc/crontab" >>p3
		echo "Manual_Check" >>p4
		echo "IZ.1.8.15.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
        fi
done <t1
else
		echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "No-cron-entry-found-in-/etc/crontab" >>p3
		echo "yes" >>p4
		echo "IZ.1.8.15.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi
rm -rf t1

#IZ.1.8.15.2
cat /etc/crontab |grep -v '#' |egrep -v 'SHELL|PATH|MAILTO|HOME' |grep -v '^$' |awk '{print $6}' >t1
if [ $? -ne 0 ]
then
while IFS= read -r line
do
        str=`ls -ld $line |awk '{print $1}' |cut -c9`
	if [ "$str" != "w" ]
        then
                echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "Permission for others in $line in /etc/crontab is valid" >>p3
		echo "IZ.1.8.15.2" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		chmod o-w $line
                echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "Permission for others in $line in /etc/crontab is invalid" >>p3
		echo "no" >>p4
		echo "IZ.1.8.15.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
        fi
done <t1
else
		echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "No system facility entries exist in-/etc/crontab" >>p3
		echo "yes" >>p4
		echo "IZ.1.8.15.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi

#IZ.1.8.15.3
cat /etc/crontab |grep -v '#' |egrep -v 'SHELL|PATH|MAILTO|HOME' |grep -v '^$' |awk '{print $6}' >t1
if [ $? -ne 0 ]
then
while IFS= read -r line
do
        str=`ls -ld $line |awk '{print $1}' |cut -c9`
	if [ "$str" != "w" ]
        then
                echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "Permission for group in $line in /etc/crontab is valid" >>p3
		echo "IZ.1.8.15.3" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		chmod g-w $line
                echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "Permission for group in $line in /etc/crontab is invalid" >>p3
		echo "no" >>p4
		echo "IZ.1.8.15.3" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
        fi
done <t1
else
		echo "Protecting Resources - OSRs" >>p1
                echo "/etc/crontab" >>p2
		echo "No system facility entries exist in-/etc/crontab" >>p3
		echo "yes" >>p4
		echo "IZ.1.8.15.3" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi

#IZ.1.8.20.1

entries=/etc/cron.d/*
ls $entries | while read DIR
do
cPath=$(echo $(grep PATH $DIR | sed 's/^PATH=/:/')":" | sed 's~:/sbin:~:~g'| sed 's~:/bin:~:~g' | sed 's~:/usr/sbin:~:~g')
removeRun=''
[[ "$cPath" == ":/usr/bin:" ]] && removeRun='run-parts'
tVar=$(grep -v '^[[:space:]]*#' $DIR | awk '{print $7}' | awk '{print $1}' | grep -v '/' | grep -v internal | grep -v "^$removeRun$" | grep -v '^$')
if [ -n "$tVar" ]

then
        echo "Protecting Resources - User Resources" >>p1
        echo "/etc/cron.d/-directory-structure" >>p2
        echo "Full-path-is-not specified-for-command- $tVar in-/etc/cron.d/$DIR" >>p3
        echo "IZ.1.8.20.1" >>p12
        echo "No" >>p4
        echo "$c" >> p5
        echo "$z" >>p6
else
	echo "Protecting Resources - User Resources" >>p1
        echo "/etc/cron.d/-directory-structure" >>p2
        echo "Full-path-is specified-for-command- $tVar in-/etc/cron.d/$DIR">>p3
        echo "IZ.1.8.20.1" >>p12
        echo "Yes" >>p4
        echo "$c" >> p5
        echo "$z" >>p6
fi



done

rm -rf t1 file2

#IZ.1.9.1.2
sk=`cat /etc/bashrc |grep -v '#'  |sed -n '/$UID -gt 199/,/fi/p' |head -2 |grep umask |awk '{print $2}'`
if [ "$sk" == "002" ]
then
        echo "Protecting Resources - User Resources" >>p1
        echo "umask-value-in-/etc/bashrc" >>p2
		echo "umask-value-set-as-$sk" >>p3
		echo "IZ.1.9.1.2" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
else
        echo "Protecting Resources - User Resources" >>p1
        echo "umask-value-in-/etc/bashrc" >>p2
		echo "umask-value-set-incorrect-as $sk" >>p3
		echo "no" >>p4
		echo "IZ.1.9.1.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi

cat /etc/bashrc |grep -v '#'  |sed -n '/$UID -gt 199/,/fi/p' |head -4 |grep umask |tail -1 |awk '{print $2}'


#IZ.1.9.1.2.1
sk=`grep "^[^#]*UMASK " /etc/login.defs |uniq |awk '{print $2}'`
if [ "$sk" == "077" ]
then
	echo "Protecting Resources - User Resources" >>p1
	echo "umask-value-in-/etc/login.defs" >>p2
	echo "umask-value set as 077 in /etc/login.defs" >>p3
	echo "IZ.1.9.1.2.1" >>p12
	echo "yes" >>p4
else
	sed -i 's/^UMASK.*/UMASK 077/g' /etc/login.defs
	echo "Protecting Resources - User Resources" >>p1
	echo "umask-value-in-/etc/login.defs" >>p2
	echo "umask-value not set as 077 in /etc/login.defs" >>p3
	echo "Modified" >>p4
	echo "IZ.1.9.1.2.1" >>p12
fi


#IZ.1.9.1.3
if [ -f /etc/profile.d/Kyndrylsinit.sh ]
then
	cat /etc/profile.d/Kyndrylsinit.sh |sed -n '/if/,/fi/p' |grep -v '#' |grep -i umask
	if [ $? -eq 0 ]
	then
		cat /etc/profile.d/Kyndrylsinit.sh |grep -v '#' |grep -i umask >t1
		while IFS= read -r line
		do
		sk1=`echo $line | awk '{print $2}'`
	       	if [ "$sk1" == "077" ]
			then
		        echo "Protecting Resources - User Resources" >>p1
		        echo "umask-value-in-/etc/profile.d/Kyndrylsinit.sh" >>p2
				echo "umask-value-set-as-$line" >>p3
				echo "IZ.1.9.1.3" >>p12
				echo "yes" >>p4
				echo "$c" >> p5
				echo "$z" >>p6
			else
				sed -i 's/^umask.*/umask 077/g' /etc/profile.d/Kyndrylsinit.sh
		        echo "Protecting Resources - User Resources" >>p1
		        echo "umask-value-in-/etc/profile.d/Kyndrylsinit.sh" >>p2
				echo "umask-value-set-as-$line" >>p3
				echo "Modified" >>p4
				echo "IZ.1.9.1.3" >>p12
				echo "$c" >> p5
				echo "$z" >>p6
			fi	
		done <t1
	else
		echo "umask 077" >>/etc/profile.d/Kyndrylsinit.sh
		echo "Protecting Resources - User Resources" >>p1
        echo "umask-value-in-/etc/profile.d/Kyndrylsinit.sh" >>p2
		echo "umask entry added in /etc/profile.d/Kyndrylsinit.sh" >>p3
		echo "Modified" >>p4
		echo "IZ.1.9.1.3" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
	fi
		
else
	touch /etc/profile.d/Kyndrylsinit.sh
	echo "if [ \$UID -gt 199 ]; then" > /etc/profile.d/Kyndrylsinit.sh
	echo "umask 077" >> /etc/profile.d/Kyndrylsinit.sh
	echo "fi" >> /etc/profile.d/Kyndrylsinit.sh
	chmod 755 /etc/profile.d/Kyndrylsinit.sh
	chown root:root /etc/profile.d/Kyndrylsinit.sh
	echo "Protecting Resources - User Resources" >>p1
    echo "umask-value-in-/etc/profile.d/Kyndrylsinit.sh" >>p2
	echo "File-doesnt-exist-/etc/profile.d/Kyndrylsinit.sh" >>p3
	echo "Modified" >>p4
	echo "IZ.1.9.1.3" >>p12
	echo "$c" >> p5
	echo "$z" >>p6
fi
rm -rf t1

#IZ.1.9.1.4
if [ -f /etc/profile.d/Kyndrylsinit.csh ]
then
	cat /etc/profile.d/Kyndrylsinit.csh |sed -n '/if/,/endif/p' |grep -v '#' |grep -i umask
	if [ $? -eq 0 ]
	then
		cat /etc/profile.d/Kyndrylsinit.csh |grep -v '#' |grep -i umask >t1
		while IFS= read -r line
		do
		sk1=`echo $line | awk '{print $2}'`
	       	if [ "$sk1" == "077" ]
			then
		        echo "Protecting Resources - User Resources" >>p1
		       	echo "umask-value-in-/etc/profile.d/Kyndrylsinit.csh" >>p2
				echo "umask-value-set-as-$line" >>p3
				echo "IZ.1.9.1.4" >>p12
				echo "yes" >>p4
				echo "$c" >> p5
				echo "$z" >>p6
			else
				sed -i 's/^umask.*/umask 077/g' /etc/profile.d/Kyndrylsinit.csh
		        echo "Protecting Resources - User Resources" >>p1
		        echo "umask-value-in-/etc/profile.d/Kyndrylsinit.csh" >>p2
				echo "umask-value-set-as-$line" >>p3
				echo "Modified" >>p4
				echo "IZ.1.9.1.4" >>p12
				echo "$c" >> p5
				echo "$z" >>p6
			fi	
		done <t1
	else
		sed -i 's/^umask.*/umask 077/g' /etc/profile.d/Kyndrylsinit.csh
		echo "Protecting Resources - User Resources" >>p1
		echo "umask-value-in-/etc/profile.d/Kyndrylsinit.csh" >>p2
		echo "umask-value not exist in /etc/profile.d/Kyndrylsinit.csh" >>p3
		echo "Modified" >>p4
		echo "IZ.1.9.1.4" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
	fi
else
		echo "if (\$uid > 199) then" > /etc/profile.d/Kyndrylsinit.csh
		echo "umask 077" >> /etc/profile.d/Kyndrylsinit.csh
		echo "endif" >> /etc/profile.d/Kyndrylsinit.csh
		chmod 755 /etc/profile.d/Kyndrylsinit.csh
		chown root:root /etc/profile.d/Kyndrylsinit.csh
		echo "Protecting Resources - User Resources" >>p1
        echo "umask-value-in-/etc/profile.d/Kyndrylsinit.csh" >>p2
		echo "File /etc/profile.d/Kyndrylsinit.csh created" >>p3
		echo "Modified" >>p4
		echo "IZ.1.9.1.4" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
fi
rm -rf t1

#IZ.1.9.1.5
if [ -f /etc/profile.d/Kyndrylsinit.sh ]
then
cat /etc/profile  |grep '.*/etc/profile.d/Kyndrylsinit.sh'
if [ $? -eq 0 ]
then
		echo "Protecting Resources - User Resources" >>p1
        echo "/etc/profile " >>p2
		echo "/etc/profile.d/Kyndrylsinit.sh_is_enabled" >>p3
		echo "IZ.1.9.1.5">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
else
		sed -i '$ a . /etc/profile.d/Kyndrylsinit.sh' /etc/profile
		echo "Protecting Resources - User Resources" >>p1
        echo "/etc/profile " >>p2
		echo "/etc/profile.d/Kyndrylsinit.sh_is_not_enabled" >>p3
		echo "IZ.1.9.1.5">>p12
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi
else
		echo "Protecting Resources - User Resources" >>p1
        echo "/etc/profile " >>p2
		echo "File /etc/profile.d/Kyndrylsinit.sh not exists" >>p3
		echo "IZ.1.9.1.5">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi

#IZ.1.9.1.6
if [ -f /etc/profile.d/Kyndrylsinit.csh ]
then
cat /etc/csh.login | grep 'source.*/etc/profile.d/Kyndrylsinit.csh'
if [ $? -eq 0 ]
then
		echo "Protecting Resources - User Resources" >>p1
        echo "/etc/csh.login " >>p2
		echo "/etc/profile.d/Kyndrylsinit.csh_is_enabled" >>p3
		echo "IZ.1.9.1.6">>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
else
		echo "source /etc/profile.d/Kyndrylsinit.csh" >>/etc/csh.login
		echo "Protecting Resources - User Resources" >>p1
        echo "/etc/csh.login" >>p2
		echo "/etc/profile.d/Kyndrylsinit.csh_is_not_enabled" >>p3
		echo "IZ.1.9.1.6">>p12
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi
else
		echo "Protecting Resources - User Resources" >>p1
        echo "/etc/csh.login" >>p2
		echo "/etc/profile.d/Kyndrylsinit.csh file created" >>p3
		echo "IZ.1.9.1.6">>p12
		echo "no" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi

#IZ.1.9.1.7
echo "/etc/skel/.cshrc,/etc/skel/.login,/etc/skel/.profile,/etc/skel/.bashrc,/etc/skel/.bash_profile,/etc/skel/.bash_login,/etc/skel/.tcshrc" >temp
tr "," "\n" < temp > temp1
for i in `cat temp1`
do
if [ -f $i ]
then
	cat $i | grep -v '#' |grep -i umask
	if [ $? -eq 0 ]
	then
	cat $i |grep -v '#' |grep -i umask >t1
	while IFS= read -r line
	do
      		sk1=`echo $line | awk '{print $2}'`
      		if [ "$sk1" == "077" ]
       		then
            		echo "Protecting Resources - User Resources" >>p1
       			echo "Default UMASK value in skeleton files" >>p2
			echo "umask-value-set-as-$line for $i" >>p3
			echo "IZ.1.9.1.7" >>p12
			echo "yes" >>p4
			echo "$c" >> p5
			echo "$z" >>p6
		else
			sed -i 's/^UMASK.*/UMASK 077/g' $i
          		echo "Protecting Resources - User Resources" >>p1
            		echo "Default UMASK value in skeleton files" >>p2
			echo "umask-value-set-as-$line for $i" >>p3
			echo "Modified" >>p4
			echo "IZ.1.9.1.7" >>p12
			echo "$c" >> p5
			echo "$z" >>p6
       		fi
	done <t1
	else
			echo "Protecting Resources - User Resources" >>p1
                        echo "Default UMASK value in skeleton files" >>p2
                        echo "umask-value-is-not-set in $i" >>p3
                        echo "yes" >>p4
                        echo "IZ.1.9.1.7" >>p12
                        echo "$c" >> p5
                        echo "$z" >>p6
	fi
else
			echo "Protecting Resources - User Resources" >>p1
                        echo "Default UMASK value in skeleton files" >>p2
                        echo "File $i not exist on the server" >>p3
                        echo "yes" >>p4
                        echo "IZ.1.9.1.7" >>p12
                        echo "$c" >> p5
                        echo "$z" >>p6
fi
done
rm -rf t1 temp temp1


#IZ.1.8.3.2.1
str=`ls -ld /usr |awk '{print $1}' |cut -c9`
if [ "$str" == "w" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/usr-dir-permission" >>p2
		echo "/usr-dir-is-writtable-by-others" >>p3
		echo "no" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.2.1" >>p12
else
		echo "Protecting Resources - OSRs" >>p1
		echo "/usr-dir-permission" >>p2
		echo "/usr-dir-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.2.1" >>p12
fi

#IZ.1.8.4.2.1
str=$(stat -c "%a %n" /etc/shadow |awk '{print $1}')
if [ "$str" == "0" ] || [ "$str" == "600" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/shadow permission" >>p2
		echo "/etc/shadow permission-is-correctly-set as $str" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.1" >>p12
	else
		chmod g-wrx,o-wrx,u-x /etc/shadow
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/shadow permission" >>p2
		echo "/etc/shadow permission-is-incorrectly set as $str" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.1" >>p12
fi

#IZ.1.8.4.2.3
str=$(stat -c "%a %n" /etc/shadow- |awk '{print $1}')
if [ "$str" == "0" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/shadow- permission" >>p2
		echo "/etc/shadow- permission-is-correctly-set as $str" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.3" >>p12
	else
		chmod 000 /etc/shadow-
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/shadow- permission" >>p2
		echo "/etc/shadow- permission-is-incorrectly set as $str" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.3" >>p12
fi

#IZ.1.8.4.2.2
str=$(stat -c "%a %n" /etc/gshadow |awk '{print $1}')
if [ "$str" == "0" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/gshadow permission" >>p2
		echo "/etc/gshadow permission-is-correctly-set as $str" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.2" >>p12
	else
		chmod 000 /etc/gshadow
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/gshadow permission" >>p2
		echo "/etc/gshadow permission-is-incorrectly set as $str" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.2" >>p12
fi

#IZ.1.8.4.2.4
str=$(stat -c "%a %n" /etc/gshadow- |awk '{print $1}')
if [ "$str" == "0" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/gshadow- permission" >>p2
		echo "/etc/gshadow- permission-is-correctly-set as $str" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.4" >>p12
	else
		chmod 000 /etc/gshadow-
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/gshadow- permission" >>p2
		echo "/etc/gshadow- permission-is-incorrectly set as $str" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.2.4" >>p12
fi

#IZ.1.8.18.3
find /etc/rc.d/ -type f -perm /g+w \! -perm -1000 >>world-writable-test
find /etc/rc.d/ -type d -perm /g+w \! -perm -1000 >>world-writable-test

fc=`cat world-writable-test |wc -l`

if [ $fc == 0 ] 
then
	echo "Protecting Resources - OSRs" >>p1
	echo "/etc/rc.d File-Directory-write-permissions-for-groups" >>p2
	echo "No files or directory found deviation" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.8.18.3" >>p12
else
	for i in `cat world-writable-test`
	do
		chmod g-w $i
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/rc.d File-Directory-write-permissions-for-groups" >>p2
		echo "$i has group write permission" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.18.3">>p12
	done
fi
rm -rf world-writable-test


#IZ.1.8.20.3
find /etc/cron.d/ -type f -perm /g+w \! -perm -1000 >>world-writable-test
find /etc/cron.d/ -type d -perm /g+w \! -perm -1000 >>world-writable-test

fc=`cat world-writable-test |wc -l`

if [ $fc == 0 ] 
then
	echo "Protecting Resources - OSRs" >>p1
	echo "/etc/cron.d File-Directory-write-permissions-for-groups" >>p2
	echo "No files found deviation $i" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.8.20.3">>p12
else
	for i in `cat world-writable-test`
	do
		chmod g-w $i
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.d File-Directory-write-permissions-for-groups" >>p2
		echo "Group has write permission for $i" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
		echo "IZ.1.8.20.3">>p12
	done
fi
rm -rf world-writable-test

#IZ.1.8.4.3.1
str=$(stat -c "%a %n" /etc/crontab |awk '{print $1}')
str1=$(ls -ld /etc/crontab |awk '{print $3}')
str2=$(ls -ld /etc/crontab |awk '{print $4}')
if [ "$str" == "600" ] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/crontab-permission" >>p2
		echo "/etc/crontab-permission-is-correctly set as $str and $str1:$str2" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.1" >>p12
else
		chown root:root /etc/crontab
		chmod og-rwx /etc/crontab
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/crontab-permission" >>p2
		echo "/etc/crontab-permission-is-incorrectly set as $str and $str1:$str2" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.1" >>p12
fi

#IZ.1.8.4.3.2
str=$(stat -c "%a %n" /etc/cron.hourly |awk '{print $1}')
str1=$(ls -ld /etc/cron.hourly |awk '{print $3}')
str2=$(ls -ld /etc/cron.hourly |awk '{print $4}')
if [[ "$str" == "700" || "$str" == "600" ]] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.hourly-permission" >>p2
		echo "/etc/cron.hourly-permission-is-correctly set as $str and $str1:$str2" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.2" >>p12
	else
		chown root:root /etc/cron.hourly
		chmod og-rwx /etc/cron.hourly
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.hourly-permission" >>p2
		echo "/etc/cron.hourly-permission-is-incorrectly set as $str and $str1:$str2" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.2" >>p12
fi

#IZ.1.8.4.3.3
str=$(stat -c "%a %n" /etc/cron.daily |awk '{print $1}')
str1=$(ls -ld /etc/cron.daily |awk '{print $3}')
str2=$(ls -ld /etc/cron.daily |awk '{print $4}')
if [[ "$str" == "700" || "$str" == "600" ]] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.daily-permission" >>p2
		echo "/etc/cron.daily-permission-is-correctly set as $str and $str1:$str2" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.3" >>p12
	else
		chown root:root /etc/cron.daily
		chmod og-rwx /etc/cron.daily
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.daily-permission" >>p2
		echo "/etc/cron.daily-permission-is-incorrectly set as $str and $str1:$str2" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.3" >>p12
fi

#IZ.1.8.4.3.4:Crontab.weekly
str=$(stat -c "%a %n" /etc/cron.weekly |awk '{print $1}')
str1=$(ls -ld /etc/cron.weekly |awk '{print $3}')
str2=$(ls -ld /etc/cron.weekly |awk '{print $4}')
if [[ "$str" == "700" || "$str" == "600" ]] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.weekly-permission" >>p2
		echo "/etc/cron.weekly-permission-is-correctly set as $str and $str1:$str2" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.4" >>p12
	else
		chown root:root /etc/cron.weekly
		chmod og-rwx /etc/cron.weekly
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.weekly-permission" >>p2
		echo "/etc/cron.weekly-permission-is-incorrectly set as $str and $str1:$str2" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.4" >>p12
fi

#IZ.1.8.4.3.5:Crontab.monthly
str=$(stat -c "%a %n" /etc/cron.monthly |awk '{print $1}')
str1=$(ls -ld /etc/cron.monthly |awk '{print $3}')
str2=$(ls -ld /etc/cron.monthly |awk '{print $4}')
if [[ "$str" == "700" || "$str" == "600" ]] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.monthly-permission" >>p2
		echo "/etc/cron.monthly-permission-is-correctly set as $str and $str1:$str2" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.5" >>p12
	else
		chown root:root /etc/cron.monthly
		chmod og-rwx /etc/cron.monthly
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.monthly-permission" >>p2
		echo "/etc/cron.monthly-permission-is-incorrectly set as $str and $str1:$str2" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.5" >>p12
fi

#IZ.1.8.4.3.6
str=$(stat -c "%a %n" /etc/cron.d |awk '{print $1}')
str1=$(ls -ld /etc/cron.d |awk '{print $3}')
str2=$(ls -ld /etc/cron.d |awk '{print $4}')
if [[ "$str" == "700" || "$str" == "600" ]] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.d-permission" >>p2
		echo "/etc/cron.d-permission-is-correctly set as $str and $str1:$str2" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.6" >>p12
else
		chown root:root /etc/cron.d
		chmod og-rwx /etc/cron.d
		echo "Protecting Resources - OSRs" >>p1
		echo "/etc/cron.d-permission" >>p2
		echo "/etc/cron.d-permission-is-incorrectly set as $str and $str1:$str2" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.4.3.6" >>p12
fi



#IZ.1.8.12.8:gpgcheck
sk=`cat /etc/yum.conf |grep ^gpgcheck |awk -F"=" '{print $2}'`
if [ "$sk" == "1" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "Gpgcheck" >>p2
		echo "IZ.1.8.12.8" >>p12
		echo "Gpgcheck is set correctly" >> p3
		echo "Yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
else
		sed -i 's/^gpgcheck.*/gpgcheck=1/g' /etc/yum.conf
		echo "Protecting Resources - OSRs" >>p1
		echo "Gpgcheck" >>p2
		echo "IZ.1.8.12.8" >>p12
		echo "Gpgcheck is not set as 1" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi

#IZ.1.8.3.5:Grub2-Permission
str=$(stat -c "%a %n" /boot/grub2 |awk '{print $1}')
str1=`ls -ld /boot/grub2 |awk '{print $3}'`
str2=`ls -ld /boot/grub2 |awk '{print $4}'`
if [ "$str" == "700" ] && [ "$str1" == "root" ] && [ "$str2" == "root" ]
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/boot/grub2-permission" >>p2
		echo "/boot/grub2-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.5" >>p12
	else
		chown root:root /boot/grub2
		chmod og-rwx /boot/grub2
		echo "Protecting Resources - OSRs" >>p1
		echo "/boot/grub2-permission" >>p2
		echo "/boot/grub2-permission-is-incorrect" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.5" >>p12
fi

#IZ.1.8.3.4:boot-permission&owner
str=$(stat -c "%a %n" /boot |awk '{print $1}')
str1=`ls -ld /boot |awk '{print $3}'`
if [ "$str" == 555 ] && [ "$str1" == root ]     
then
		echo "Protecting Resources - OSRs" >>p1
		echo "/boot-permission and owner" >>p2
		echo "/boot-permission-is-correctly-set" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.4" >>p12
	else
		chown root:root /boot
		chmod ugo-w /boot
		echo "Protecting Resources - OSRs" >>p1
		echo "/boot-permission and owner" >>p2
		echo "/boot-permission and owner-is-incorrect" >>p3
		echo "Modified" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.8.3.4" >>p12
fi





#IZ.1.8.3.2.2:/usr

echo "Protecting Resources - OSRs" >>p1
echo "/usr Exceptions to OSR" >>p2
echo "/usr Exceptions to OSR" >>p3
echo "Yes" >>p4
echo "$c" >>p5
echo "$z" >>p6
echo "IZ.1.8.3.2.2" >>p12




#IZ.1.8.23.1 
find / -xdev -type d -perm /o+w \! -perm -1000 2>/dev/null >world-writable-test

fc=`cat world-writable-test|wc -l`

if [ $fc == 0 ] 
then
	echo "Protecting Resources - mixed" >>p1
	echo "Ensure sticky bit is set on all world-writable directories on local file systems" >>p2
	echo "No deviation found for world writable dir has stickybit set" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.8.23.1" >>p12
else

for i in `cat world-writable-test`
do
	echo "Protecting Resources - mixed" >>p1
	echo "Ensure sticky bit is set on all world-writable directories on local file systems" >>p2
	echo "$i dir is set as writable for others and has no sticky bit set" >> p3
	echo "no" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.8.23.1" >>p12
done
fi
rm -rf world-writable-test


