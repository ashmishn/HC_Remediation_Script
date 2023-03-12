serv=`whereis service |awk '{print $2}'`

PASS_MAX_DAYS=`cat hc_remediation_parameter |grep ^PASS_MAX_DAYS |awk '{print $2}'`
PASS_MIN_DAYS=`cat hc_remediation_parameter |grep ^PASS_MIN_DAYS |awk '{print $2}'`
PASS_MIN_LENGTH=`cat hc_remediation_parameter |grep ^PASS_MIN_LENGTH |awk '{print $2}'`
DIGIT=`cat hc_remediation_parameter |grep ^DIGIT |awk '{print $2}'`
UPPER_CASE=`cat hc_remediation_parameter |grep ^UPPER_CASE |awk '{print $2}'`
LOWER_CASE=`cat hc_remediation_parameter |grep ^LOWER_CASE |awk '{print $2}'`
OTHER_CHAR=`cat hc_remediation_parameter |grep ^OTHER_CHAR |awk '{print $2}'`
LOG_ROTATE=`cat hc_remediation_parameter |grep ^LOG_ROTATE |awk '{print $2}'`
PAM_REMEMBER=`cat hc_remediation_parameter |grep ^PAM_REMEMBER |awk '{print $2}'`
UMASK_VAL=`cat hc_remediation_parameter |grep ^UMASK_VAL |awk '{print $2}'`
UMASK_BASHRC_VAL=`cat hc_remediation_parameter |grep ^UMASK_BASHRC_VAL |awk '{print $2}'`
PERMITROOTLOGIN=`cat hc_remediation_parameter |grep ^PERMITROOTLOGIN |awk '{print $2}'`
PERMITEMPTYPASSWORDS=`cat hc_remediation_parameter |grep ^PERMITEMPTYPASSWORDS |awk '{print $2}'`
PERMITUSERENVIRONMENT=`cat hc_remediation_parameter |grep ^PERMITUSERENVIRONMENT |awk '{print $2}'`
TCPKEEPALIVE=`cat hc_remediation_parameter |grep ^TCPKEEPALIVE |awk '{print $2}'`
MAXSTARTUPS=`cat hc_remediation_parameter |grep ^MAXSTARTUPS |awk '{print $2}'`
MAXAUTHTRIES=`cat hc_remediation_parameter |grep ^MAXAUTHTRIES |awk '{print $2}'`
LOGINGRACETIME=`cat hc_remediation_parameter |grep ^LOGINGRACETIME |awk '{print $2}'`
KEYREGENERATIONINTERVAL=`cat hc_remediation_parameter |grep ^KEYREGENERATIONINTERVAL |awk '{print $2}'`
LOGLEVEL=`cat hc_remediation_parameter |grep ^LOGLEVEL |awk '{print $2}'`
GATEWAYPORTS=`cat hc_remediation_parameter |grep ^GATEWAYPORTS |awk '{print $2}'`
STRICTMODES=`cat hc_remediation_parameter |grep ^STRICTMODES |awk '{print $2}'`
PRINTMOTD=`cat hc_remediation_parameter |grep ^PRINTMOTD |awk '{print $2}'`
LOG_ROTATE_WEEK=`cat hc_remediation_parameter |grep ^LOG_ROTATE_WEEK |awk '{print $2}'`
LOG_ROTATE_MONTH=`cat hc_remediation_parameter |grep ^LOG_ROTATE_MONTH |awk '{print $2}'`
SHARED_ID_VAULTED=`cat hc_remediation_parameter |grep ^SHARED_ID_VAULTED |awk '{print $2}'`
TMOUT=`cat hc_remediation_parameter |grep ^TMOUT |awk '{print $2}'`
AUTOLOGOUT=`cat hc_remediation_parameter |grep ^AUTOLOGOUT |awk '{print $2}'`
SYSLOG_IP=`cat hc_remediation_parameter |grep ^SYSLOG_IP |awk '{print $2}'`
NFS_USE=`cat hc_remediation_parameter |grep ^NFS_USE |awk -F: '{print $2}'`
FTP_USE=`cat hc_remediation_parameter |grep ^FTP_USE |awk -F: '{print $2}'`
LDAP_USE=`cat hc_remediation_parameter |grep ^LDAP_USE |awk -F: '{print $2}'`
SQUID_PROXY_USE=`cat hc_remediation_parameter |grep ^SQUID_PROXY_USE |awk -F: '{print $2}'`
DNS_SERVER_USE=`cat hc_remediation_parameter |grep ^DNS_SERVER_USE |awk -F: '{print $2}'`
HTTP_USE=`cat hc_remediation_parameter |grep ^HTTP_USE |awk -F: '{print $2}'`

#IZ.1.1.2.0
sk=` cat /etc/security/pwquality.conf |grep -v '^#' |grep ^minlen |awk -F= '{print $2}'`
sl=` cat /etc/security/pwquality.conf |grep -v '^#' |grep ^ucredit |awk -F= '{print $2}'`
sm=` cat /etc/security/pwquality.conf |grep -v '^#' |grep ^ocredit |awk -F= '{print $2}'`
sn=` cat /etc/security/pwquality.conf |grep -v '^#' |grep ^dcredit |awk -F= '{print $2}'`
sp=` cat /etc/security/pwquality.conf |grep -v '^#' |grep ^lcredit |awk -F= '{print $2}'`
	if [ "$sk" == "$PASS_MIN_LENGTH" ] && [ "$sl" == "$UPPER_CASE" ] && [ "$sm" == "$OTHER_CHAR" ] && [ "$sn" == "$DIGIT" ] && [ "$sp" == "$LOWER_CASE" ] ; then
		echo "Password Requirements" >>p1
		echo "PASS_MIN_LEN-password_complexity" >>p2
		echo "No-violation-for--password_complexity-in-/etc/security/pwquality.conf" >> p3
		echo "IZ.1.1.2.0">>p12
		echo "yes" >>p4
	else
		sed -i 's/.*minlen.*/minlen = '$PASS_MIN_LENGTH'/g' /etc/security/pwquality.conf
		sed -i 's/.*ucredit.*/ucredit = '$UPPER_CASE'/g' /etc/security/pwquality.conf
		sed -i 's/.*ocredit.*/ocredit = '$OTHER_CHAR'/g' /etc/security/pwquality.conf
		sed -i 's/.*dcredit.*/dcredit = '$DIGIT'/g' /etc/security/pwquality.conf
		sed -i 's/.*lcredit.*/lcredit = '$LOWER_CASE'/g' /etc/security/pwquality.conf
		echo "IZ.1.1.2.0" >>p12
		echo "Password Requirements" >>p1
		echo "PASS_MIN_LEN-password_complexity" >>p2
		echo "password_complexity-modified-in-/etc/pam.d/password-auth" >> p3
		echo "Modified" >>p4
	fi
	
len=`cat /etc/login.defs |grep ^PASS_MIN_LEN |awk '{print $2}'`
if [ "$len" == "$PASS_MIN_LENGTH" ]
then
		echo "IZ.1.1.2.0" >>p12
		echo "Password Requirements" >>p1
		echo "PASS_MIN_LEN-password_complexity in /etc/login.defs" >>p2
		echo "PASS_MIN_LEN is set as $len in /etc/login.defs" >> p3
		echo "yes" >>p4
else
		sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN	'$PASS_MIN_LENGTH'/g' /etc/login.defs
		echo "IZ.1.1.2.0" >>p12
		echo "Password Requirements" >>p1
		echo "PASS_MIN_LEN-password_complexity in /etc/login.defs" >>p2
		echo "password_complexity-modified-in-/etc/login.defs" >> p3
		echo "Modified" >>p4
fi


#IZ.1.1.1.1:PASS_MAX_DAYS
sz=`cat /etc/login.defs |grep -v "#"| grep ^PASS_MAX_DAYS | awk '{print $2}' |uniq`
if [ "$sz" != "$PASS_MAX_DAYS" ]
then
	sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   '$PASS_MAX_DAYS'/g' /etc/login.defs
	echo "Password Requirementss" >>p1
	echo "PASS_MAX_DAYS value in /etc/login.defs" >>p2
	echo "PASS_MAX_DAYS value in /etc/login.defs changed to $PASS_MAX_DAYS"  >>p3
	echo "Modified" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.1.1.1" >>p12

else
	echo "Password Requirementss" >>p1
	echo "PASS_MAX_DAYS value in /etc/login.defs" >>p2
	echo "PASS_MAX_DAYS value in /etc/login.defs is $sz" >>p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.1.1.1" >>p12
	
fi


#IZ.1.1.1.2;IZ.1.1.9.0:Fifth field of /etc/shadow
CHAGE_DATE=`date +"%Y-%m-%d"`
cat hc_remediation_parameter |grep ^NON_EXPIRY_ID |awk -F: '{print $2}' |sed -e 's/ //g' |sed -e 's/,/|/g' |grep -v '^$' >file1
sk=`cat file1 |wc -l`
if [ $sk -gt 0 ]
then
	sp=`cat file1`
	cat /etc/passwd | egrep -v "/sbin/nologin|sync|shutdown|halt|/bin/false|$sp" | awk -F":" '{print $1}' >temp_passwd
	for i in `cat temp_passwd` ; do
	sk=`chage -l $i |grep "^Maximum" |sed -e 's/://g' |awk '{print $8}'`
			if [ "$sk" -le "$PASS_MAX_DAYS" ] && [ "$sk" -gt 0 ] ; then
				echo "Password Requirements" >>p1
				echo "PASS_MAX_DAYS" >>p2
				echo "Fifth field of /etc/shadow is set as $sk for id $i" >>p3
				echo "IZ.1.1.1.2;IZ.1.1.9.0" >>p12
				echo "yes" >>p4
			else
				chage -M $PASS_MAX_DAYS $i
				chage -d "$CHAGE_DATE" $i
				echo "Password Requirements" >>p1
				echo "PASS_MAX_DAYS" >>p2
				echo "Fifth field of /etc/shadow is set as $PASS_MAX_DAYS for id $i" >>p3
				echo "Modified" >>p4
				echo "IZ.1.1.1.2;IZ.1.1.9.0" >>p12
			fi
	done
else
	cat /etc/passwd | egrep -v "/sbin/nologin|sync|shutdown|halt|/bin/false" | awk -F":" '{print $1}' >temp_passwd
	for i in `cat temp_passwd` ; do
	sk=`chage -l $i |grep "^Maximum" |sed -e 's/://g' |awk '{print $8}'`
			if [ "$sk" -le "$PASS_MAX_DAYS" ] && [ "$sk" -gt 0 ] ; then
				echo "Password Requirements" >>p1
				echo "PASS_MAX_DAYS" >>p2
				echo "Fifth field of /etc/shadow is set as $sk for id $i" >>p3
				echo "IZ.1.1.1.2;IZ.1.1.9.0" >>p12
				echo "yes" >>p4
			else
				chage -M $PASS_MAX_DAYS $i
				chage -d "$CHAGE_DATE" $i
				echo "Password Requirements" >>p1
				echo "PASS_MAX_DAYS" >>p2
				echo "Fifth field of /etc/shadow is set as $PASS_MAX_DAYS for id $i" >>p3
				echo "Modified" >>p4
				echo "IZ.1.1.1.2;IZ.1.1.9.0" >>p12
			fi
	done
fi
rm -rf temp_passwd

#IZ.1.1.2.1:2nd field of /etc/shadow
cat /etc/shadow | awk -F":" '{print $1}' >temp_shadow2
for i in `cat temp_shadow2`
do
        sk1=`passwd -S $i |awk '{print $2}'`
        if [ "$sk1" == "NP" ]
        then
			passwd -l $i
			echo "Password Requirements" >>p1
            echo "password specification within /etc/shadow" >>p2
			echo "A null password is assigned for user '$i'" >>p3
			echo "Modified" >>p4
			echo "IZ.1.1.2.1" >>p12
			echo "$c" >> p5
			echo "$z" >>p6
                
	else
			echo "Password Requirements" >>p1
			echo "password specification within /etc/shadow" >>p2
			echo "User '$i' has no no null password set" >>p3
			echo "IZ.1.1.2.1" >>p12
			echo "yes" >>p4
			echo "$c" >> p5
			echo "$z" >>p6
               
        fi
done
rm -rf temp_shadow2

#IZ.1.1.2.2:2nd field of /etc/passwd
cat /etc/passwd | awk -F":" '{print $1}' >temp_passwd
for i in `cat temp_passwd`
do
        sk1=`cat /etc/passwd |grep -w ^$i |awk -F: '{print $2}'`
        if [ "$sk1" == "" ]
        then
		echo "Password Requirements" >>p1
                echo "second field of /etc/passwd" >>p2
		echo "The second field /etc/passwd is set as null for user $i" >>p3
		echo "Manual_Check_Required" >>p4
		echo "IZ.1.1.2.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
	else
		echo "Password_requirement" >>p1
                echo "second field of /etc/passwd" >>p2
		echo "The second field /etc/passwd is not set as null for user $i" >>p3
		echo "IZ.1.1.2.2" >>p12
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
        fi
done
rm -rf temp_passwd


#IZ.1.1.3.1:PASS_MIN_DAYS
sm=`cat /etc/login.defs | grep -v "#"| grep ^PASS_MIN_DAYS  | awk '{print $2}' |uniq`
if [ "$sm" != "$PASS_MIN_DAYS" ]
then
	sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   '$PASS_MIN_DAYS'/g' /etc/login.defs
	echo "Password Requirementss" >>p1
	echo "Per-userid Minimum Password Age" >>p2
	echo "PASS_MIN_DAYS value in /etc/login.defs changed to $PASS_MIN_DAYS" >>p3
	echo "Modified" >>p4
	echo "IZ.1.1.3.1" >>p12
	echo "$c" >> p5
	echo "$z" >>p6
else
	echo "Password Requirementss" >>p1
	echo "PASS_MIN_DAYS value in /etc/login.defs" >>p2
	echo "PASS_MIN_DAYS value in /etc/login.defs is $sm" >>p3
	echo "yes" >>p4
	echo "IZ.1.1.3.1" >>p12
	echo "$c" >> p5
	echo "$z" >>p6
fi


#IZ.1.1.3.2:4th field of /etc/shadow - updated (06-05-2021)
cat /etc/passwd | egrep -v "/sbin/nologin|sync|shutdown|halt|/bin/false" | awk -F":" '{print $1}' >temp_passwd
for i in `cat temp_passwd`
do
sk=`chage -l $i |grep "^Minimum" |sed -e 's/://g' |awk '{print $8}'`
	if [ "$sk" -ge "$PASS_MIN_DAYS" ]
        then
                echo "Password Requirements" >>p1
                echo "Per-userid_Minimum_Password_Age" >>p2
			echo "Field 4 of /etc/shadow is set as "$sk" for id $i" >>p3
			echo "IZ.1.1.3.2" >>p12
			echo "yes" >>p4
			echo "$c" >> p5
			echo "$z" >>p6
	else
			chage -m $PASS_MIN_DAYS $i
            echo "Password Requirements" >>p1
            echo "Per-userid_Minimum_Password_Age" >>p2
			echo "Field 4 of /etc/shadow is modified as "$PASS_MIN_DAYS" for id $i" >>p3
			echo "Modified" >>p4
			echo "IZ.1.1.3.2" >>p12
			echo "$c" >> p5
			echo "$z" >>p6
    fi
done
rm -rf temp_passwd


#IZ.1.1.4.1:pam-settings
	E=`cat /etc/pam.d/system-auth |grep -v '#' |grep ^password |egrep 'required|sufficient' |grep pam_unix.so |grep remember=$PAM_REMEMBER |egrep 'use_authtok|sha512|md5|shadow'`
	if [ $? -eq 0 ]
	then
		echo "Password Requirementss" >>p1
		echo "prevent_reuse_of_lat_eight_passwords" >>p2
		echo "pam_unix.so_remember value set correct in /etc/pam.d/system-auth" >>p3
		echo "yes" >> p4
		echo "IZ.1.1.4.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6	
	else
		sp2=`cat /etc/pam.d/system-auth |grep ^password |egrep 'required|sufficient' |grep pam_unix.so |awk '{print $2}'`
		sed -i '/^password.*'$sp2'.*pam_unix.so/c\password    '$sp2'      pam_unix.so remember='$PAM_REMEMBER' sha512 shadow try_first_pass use_authtok' /etc/pam.d/system-auth
		echo "Password Requirementss" >>p1
		echo "prevent_reuse_of_lat_eight_passwords" >>p2
		echo "pam_unix.so_remember value modified in /etc/pam.d/system-auth" >>p3
		echo "Modified" >> p4
		echo "IZ.1.1.4.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
	fi


	E=`cat /etc/pam.d/password-auth |grep -v '#' |grep ^password |egrep 'required|sufficient' |grep pam_unix.so |grep remember=$PAM_REMEMBER |egrep 'use_authtok|sha512|md5|shadow'`
	if [ $? -eq 0 ]
	then
		echo "Password Requirementss" >>p1
		echo "prevent_reuse_of_lat_eight_passwords" >>p2
		echo "pam_unix.so_remember value set correct in /etc/pam.d/password-auth" >>p3
		echo "yes" >> p4
		echo "IZ.1.1.4.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6	
	else
		sp2=`cat /etc/pam.d/password-auth |grep ^password |egrep 'required|sufficient' |grep pam_unix.so |awk '{print $2}'`
		sed -i '/^password.*'$sp2'.*pam_unix.so/c\password    '$sp2'      pam_unix.so remember='$PAM_REMEMBER' sha512 shadow try_first_pass use_authtok' /etc/pam.d/password-auth
		echo "Password Requirementss" >>p1
		echo "prevent_reuse_of_lat_eight_passwords" >>p2
		echo "pam_unix.so_remember value modified in /etc/pam.d/password-auth" >>p3
		echo "Modified" >> p4
		echo "IZ.1.1.4.1" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
	fi

#IZ.1.1.6.0:loginretries value in password-auth and system-auth
if [ -f /etc/pam.d/system-auth ]
then
sk=`cat /etc/pam.d/system-auth |grep -v '#' | grep ^auth |grep required | egrep -w "pam_tally.so.*deny=5 |pam_tally2.so.*deny=5" |wc -l`
sl=`cat /etc/pam.d/system-auth |grep -v '#' | grep ^account |grep required | egrep -w "pam_tally.so |pam_tally2.so" |wc -l`
sk1=`cat /etc/pam.d/system-auth |grep -v '#' | grep ^auth |grep required | egrep -w "pam_faillock.so.*preauth.*deny=5" |wc -l`
sk2=`cat /etc/pam.d/system-auth |grep -v '#' | grep ^[default=die] | egrep -w "pam_faillock.so.*authfail.*deny=5" |wc -l`
sl1=`cat /etc/pam.d/system-auth |grep -v '#' | grep ^account |grep required | egrep -w "pam_faillock.so" |wc -l`
	if [ $sk -gt 0 ] && [ $sl -gt 0 ]
	then
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "Consecutive failed login attempts is set in /etc/pam.d/system-auth"  >>p3
		echo "IZ.1.1.6.0"  >>p12
		echo "yes"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
	elif [ $sk1 -gt 0 ] && [ $sl1 -gt 0 ] &&  [ $sk2 -gt 0 ]
	then
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "Consecutive failed login attempts is set in /etc/pam.d/system-auth"  >>p3
		echo "IZ.1.1.6.0"  >>p12
		echo "yes"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
	else
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "Consecutive failed login attempts is not set in /etc/pam.d/system-auth"  >>p3
		echo "IZ.1.1.6.0"  >>p12
		echo "no"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
	fi
else
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "File not found /etc/pam.d/system-auth"
		echo "IZ.1.1.6.0"  >>p12
		echo "no"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
fi
if [ -f /etc/pam.d/password-auth ]
then
sk=`cat /etc/pam.d/password-auth |grep -v '#' | grep ^auth |grep required | egrep -w "pam_tally.so.*deny=5 |pam_tally2.so.*deny=5" |wc -l`
sl=`cat /etc/pam.d/password-auth |grep -v '#' | grep ^account |grep required | egrep -w "pam_tally.so |pam_tally2.so" |wc -l`
sk1=`cat /etc/pam.d/password-auth |grep -v '#' | grep ^auth |grep required | egrep -w "pam_faillock.so.*preauth.*deny=5" |wc -l`
sk2=`cat /etc/pam.d/password-auth |grep -v '#' | grep ^[default=die] | egrep -w "pam_faillock.so.*authfail.*deny=5" |wc -l`
sl1=`cat /etc/pam.d/password-auth |grep -v '#' | grep ^account |grep required | egrep -w "pam_faillock.so" |wc -l`
	if [ $sk -gt 0 ] && [ $sl -gt 0 ]
	then
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "Consecutive failed login attempts is set in /etc/pam.d/password-auth"  >>p3
		echo "IZ.1.1.6.0"  >>p12
		echo "yes"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
	elif [ $sk1 -gt 0 ] && [ $sl1 -gt 0 ] &&  [ $sk2 -gt 0 ]
	then
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "Consecutive failed login attempts is set in /etc/pam.d/password-auth"  >>p3
		echo "IZ.1.1.6.0"  >>p12
		echo "yes"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
	else
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "Consecutive failed login attempts is not set in /etc/pam.d/password-auth"  >>p3
		echo "IZ.1.1.6.0"  >>p12
		echo "no"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
	fi
else
		echo "Password Requirements"  >>p1
		echo "loginretries"  >>p2
		echo "File not found /etc/pam.d/password-auth"  >>p3
		echo "IZ.1.1.6.0" >>p12
		echo "no"  >>p4
		echo "$c" >> p5
		echo "$z"  >> p6
fi





#IZ.1.1.7.1
szkl=`passwd -S root |awk '{print $2}'`
sk=`chage -l root |grep "^Maximum" |sed -e 's/://g' |awk '{print $8}'`
if [ "$szkl" == "PS" ] && [[ "$sk" -le "$PASS_MAX_DAYS" && "$sk" -gt "0" ]]
then
		echo "IZ.1.1.7.1" >>p12
		echo "Password Requirements" >>p1
		echo "Password and expiry settings for ROOT" >>p2
		echo "root_passwd_is_set and expiry period set as $sk" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
else
		chage -M $PASS_MAX_DAYS root
		echo "IZ.1.1.7.1" >>p12
		echo "Password Requirements" >>p1
		echo "Password and expiry settings for ROOT" >>p2
		echo "root_passwd expiry setting modified as $PASS_MAX_DAYS" >> p3
		echo "Modified" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi


#IZ.1.1.7.2
sz=`sshd -T |grep -i permitrootlogin | awk '{print $2}' |uniq`
if [ "$sz" == "no" ]
then
		echo "Password Requirements" >>p1
        	echo "ROOT Login access must be restricted to the physical console" >>p2
		echo "PermitRootLogin is set as $sz in /etc/ssh/sshd_config. Interactive root login is disabled" >> p3
		echo "yes" >>p4
         	echo "$c" >> p5
                echo "$z" >>p6
		echo "IZ.1.1.7.2" >>p12
else
		sed -i 's/^PermitRootLogin.*/PermitRootLogin '$PERMITROOTLOGIN'/g' /etc/ssh/sshd_config
		echo "Password Requirementss" >>p1
        	echo "ROOT Login access must be restricted to the physical console" >>p2
		echo "PermitRootLogin is modified as $PERMITROOTLOGIN in /etc/ssh/sshd_config" >> p3
                echo "Modified" >>p4
                echo "$c" >> p5
                echo "$z" >>p6
		echo "IZ.1.1.7.2" >>p12
fi


#IZ.1.1.8.2:UID-validation
cat /etc/passwd | awk -F":" '{print $3}'| sort  | uniq -cd | awk '{print $2}'> temp_uid
sp=`cat temp_uid | wc -c`
if [ "$sp" == 0 ]
then
		echo "Password Requirementss" >>p1
		echo "UID_validation" >>p2
		echo  "No_duplicate_uid_value_for_users_in_/etc/passwd" >>p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "IZ.1.1.8.2" >>p12
		echo "$z" >>p6	
else
		for i in `cat temp_uid`
		do
		echo "Password Requirementss" >>p1
		echo "uid_validation" >>p2
		echo "Duplicate-uid-value-for-UID-$i" >>p3
		echo "Manual_Check_Required" >>p4
		echo "$c" >> p5
		echo "IZ.1.1.8.2" >>p12
		echo "$z" >>p6	
		done
fi



#IZ.1.1.10.1
cat hc_remediation_parameter |grep ^NON_EXPIRY_ID |awk -F: '{print $2}' |sed -e 's/ //g' |sed -e 's/,/|/g' |grep -v '^$' >file1
sk=`cat file1 |wc -l`
if [ $sk -gt 0 ]
then
	sp=`cat file1`
	for i in `cat /etc/passwd | egrep -v "/sbin/nologin|sync|shutdown|halt|/bin/false|$sp" | awk -F":" '{print $1}'`
	do
	sk=`chage -l $i | grep "Password expires" |sed -e 's/://' | awk '{ print $3}'`
	if [ "$sk" == "never" ]
	then
		sl=`getent passwd $i |awk -F: '{print $7}'`
		if [ "$sl" == "/sbin/nologin" ] || [ "$sl" == "/bin/false" ]
		then
			echo "Password Requirementss" >>p1
			echo "direct_or_remote_login" >>p2
			echo "User $i has a valid shell $sl" >>p3
			echo "yes" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.1.10.1" >>p12
		else
			usermod -s /sbin/nologin $i
			echo "Password Requirementss" >>p1
			echo "direct_or_remote_login" >>p2
			echo "User $i shell modified as /sbin/nologin as it is set as non-expire and not in exception" >>p3
			echo "Modified" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.1.10.1" >>p12
		fi
	else
		sl=`getent passwd $i |awk -F: '{print $7}'`
		echo "Password Requirementss" >>p1
		echo "direct_or_remote_login" >>p2
		echo "User $i has valid shell $sl" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.1.10.1" >>p12	
	fi
	done
else
	for i in `cat /etc/passwd | egrep -v "/sbin/nologin|sync|shutdown|halt|/bin/false" | awk -F":" '{print $1}'`
	do
	sk=`chage -l $i | grep "Password expires" |sed -e 's/://' | awk '{ print $3}'`
	if [ "$sk" == "never" ]
	then
		sl=`getent passwd $i |awk -F: '{print $7}'`
		if [ "$sl" == "/sbin/nologin" ] || [ "$sl" == "/bin/false" ]
		then
			echo "Password Requirementss" >>p1
			echo "direct_or_remote_login" >>p2
			echo "User $i has a valid shell $sl" >>p3
			echo "yes" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.1.10.1" >>p12
		else
			usermod -s /sbin/nologin $i
			echo "Password Requirementss" >>p1
			echo "direct_or_remote_login" >>p2
			echo "User $i shell modified as /sbin/nologin as it is set as non-expire and not in exception" >>p3
			echo "Modified" >>p4
			echo "$c" >>p5
			echo "$z" >>p6
			echo "IZ.1.1.10.1" >>p12
		fi
	else
		sl=`getent passwd $i |awk -F: '{print $7}'`
		echo "Password Requirementss" >>p1
		echo "direct_or_remote_login" >>p2
		echo "User $i has valid shell $sl" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.1.10.1" >>p12	
	fi
	done
fi

##IZ.1.1.11.1;IZ.1.1.13.1;IZ.1.1.13.2:Non-expiring ID's
for i in `cat /etc/passwd | egrep -v "/sbin/nologin|sync|shutdown|halt|/bin/false" | awk -F":" '{print $1}'`
do
sk=`chage -l $i | grep "Password expires" |sed -e 's/://' | awk '{ print $3}'`
if [ "$sk" == "never" ]
then
	sk1=`passwd -S $i |awk '{print $2}'`
        if [ "$sk1" == "LK" ]
        then
		echo "Password Requirements" >>p1
		echo "direct_or_remote_login" >>p2
		echo "User $i has non-expiring password but the account is locked" >>p3
		echo "yes" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.1.11.1:IZ.1.1.13.1:IZ.1.1.13.2" >>p12
	else
		echo "Password Requirements" >>p1
		echo "direct_or_remote_login" >>p2
		echo "User $i has non-expiring password but the account is not locked" >>p3
		echo "no" >>p4
		echo "$c" >>p5
		echo "$z" >>p6
		echo "IZ.1.1.11.1:IZ.1.1.13.1:IZ.1.1.13.2" >>p12
	fi
else
	echo "Password Requirements" >>p1
	echo "direct_or_remote_login" >>p2
	echo "User $i has expiry password set" >>p3
	echo "yes" >>p4
	echo "$c" >>p5
	echo "$z" >>p6
	echo "IZ.1.1.11.1:IZ.1.1.13.1:IZ.1.1.13.2" >>p12	
fi
done

#IZ.1.1.13.3,IZ.1.1.10.2:FTP filecheck
rpm -q vsftpd
if [ $? -ne 0 ]
then
		echo "Password Requirements" >>p1
		echo "Restrict ftp access" >>p2
		echo "IZ.1.1.13.3:IZ.1.1.10.2" >>p12
		echo "Base package vsftpd is not installed" >> p3
		echo "Not_Applicable" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
else
if [ -f /etc/ftpusers ] || [ -f /etc/vsftpd.ftpusers ] || [ -f /etc/vsftpd/ftpusers ]
then
	
	then
		echo "Password Requirements" >>p1
		echo "Restrict ftp access" >>p2
		echo "IZ.1.1.13.3:IZ.1.1.10.2" >>p12
		echo "ftp_file_exist-but-no-ftp-id" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
	else
		echo "Password Requirements" >>p1
		echo "Restrict ftp access" >>p2
		echo "ftp_file_exist-with-ftp-id" >> p3
		echo "no" >>p4
		echo "IZ.1.1.13.3:IZ.1.1.10.2" >>p12
		echo "$c" >> p5
		echo "$z" >>p6
	fi
else
		echo "Password Requirements" >>p1
		echo "Restrict ftp access" >>p2
		echo "IZ.1.1.13.3:IZ.1.1.10.2" >>p12
		echo "ftp_file_doesnt-exist" >> p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "$z" >>p6
fi
fi


#IZ.1.1.13.4:PAM-yes
sk=`sshd -T |grep -i usepam |awk '{print $2}'`
if [ "$sk" == "yes" ]
then
	echo "Password Requirements" >>p1
	echo "/etc/ssh/sshd_config" >>p2
	echo "UsePAM_yes_is_valid" >> p3
	echo "yes" >>p4
	echo "$c" >> p5
	echo "$z" >>p6
	echo "IZ.1.1.13.4" >>p12
else
	PAM=`cat /etc/ssh/sshd_config |grep ^UsePAM |uniq |wc -l`
  	if [ $PAM -gt 0 ]
  	then
		sed -i 's/^UsePAM.*/UsePAM	yes/g' /etc/ssh/sshd_config
		systemctl reload sshd
		echo "Password Requirements" >>p1
		echo "/etc/ssh/sshd_config" >>p2
		echo "IZ.1.1.13.4" >>p12
		echo "UsePAM_yes_is_modified in /etc/ssh/sshd_config" >> p3
		echo "Modified" >>p4
	else
	PAM=`cat /etc/ssh/sshd_config |grep ^#UsePAM |uniq |wc -l`
	if [ $PAM -gt 0 ]
  	then
		sed -i 's/#UsePAM.*/UsePAM	yes/g' /etc/ssh/sshd_config
		systemctl reload sshd
		echo "Password Requirements" >>p1
		echo "/etc/ssh/sshd_config" >>p2
		echo "IZ.1.1.13.4" >>p12
		echo "UsePAM_yes_is_modified in /etc/ssh/sshd_config" >> p3
		echo "Modified" >>p4
	fi
	fi
fi

#IZ.1.1.4.7
egrep "^password\s" /etc/pam.d/password-auth |grep pam_unix.so |grep "remember="
if [ $? -eq 0 ]
then
	sk1=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |head -1`
	sk2=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |head -2 |tail -1`
	sk3=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |tail -1`

	if [[ "$sk1" == "pam_pwquality.so" || "$sk1" == "pam_cracklib.so" ]] && [ "$sk2" == "pam_unix.so" ] && [ "$sk3" == "pam_deny.so" ]
	then
		echo "Password Requirements" >>p1
		echo "Ensure pam modules are in correct order" >>p2
		echo "PAM password modules are in correct order in /etc/pam.d/password-auth" >>p3
		echo "yes" >>p4
		echo "IZ.1.1.4.7" >>p12
		echo "$c" >>p5
		echo "$z" >>p6
	else
		echo "Password Requirements" >>p1
		echo "Ensure pam modules are in correct order" >>p2
		echo "All are in correct order /etc/pam.d/password-auth" >>p3
		echo "yes" >>p4
		echo "IZ.1.1.4.7" >>p12
		echo "$c" >>p5
		echo "$z" >>p6
	fi
else
	egrep "^password\s" /etc/pam.d/password-auth |grep pam_pwhistory.so
	if [ $? -eq 0 ]
	then
		sk1=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |head -1`
		sk2=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |head -2 |tail -1`
		sk3=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |head -3 |tail -1`
		sk4=`egrep "^password\s" /etc/pam.d/password-auth | awk '{print $3}' |tail -1`
		if [[ "$sk1" == "pam_pwquality.so" || "$sk1" == "pam_cracklib.so" ]] && [ "$sk2" == "pam_pwhistory.so" ] && [ "$sk3" == "pam_unix.so" ] && [ "$sk4" == "pam_deny.so" ]
		then
			echo "Password Requirements" >>p1
			echo "Ensure pam modules are in correct order" >>p2
			echo "PAM password modules are in correct order in /etc/pam.d/password-auth" >>p3
			echo "yes" >>p4
			echo "IZ.1.1.4.7" >>p12
			echo "$c" >>p5
			echo "$z" >>p6
		else
			echo "Password Requirements" >>p1
			echo "Ensure pam modules are in correct order" >>p2
			echo "PAM password modules are not in correct order in /etc/pam.d/password-auth" >>p3
			echo "no" >>p4
			echo "IZ.1.1.4.7" >>p12
			echo "$c" >>p5
			echo "$z" >>p6
		fi
	else
			echo "Password Requirements" >>p1
			echo "Ensure pam modules are in correct order" >>p2
			echo "remember= is not coded on the pam_unix.so module and pam_pwhistory.so not available in /etc/pam.d/password-auth" >>p3
			echo "no" >>p4
			echo "IZ.1.1.4.7" >>p12
			echo "$c" >>p5
			echo "$z" >>p6
	fi
fi

egrep "^password\s" /etc/pam.d/system-auth |grep pam_unix.so |grep "remember="
if [ $? -eq 0 ]
then
	sk1=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |head -1`
	sk2=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |head -2 |tail -1`
	sk3=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |tail -1`

	if [[ "$sk1" == "pam_pwquality.so" || "$sk1" == "pam_cracklib.so" ]] && [ "$sk2" == "pam_unix.so" ] && [ "$sk3" == "pam_deny.so" ]
	then
		echo "Password Requirements" >>p1
		echo "Ensure pam modules are in correct order" >>p2
		echo "PAM password modules are in correct order in /etc/pam.d/system-auth" >>p3
		echo "yes" >>p4
		echo "IZ.1.1.4.7" >>p12
		echo "$c" >>p5
		echo "$z" >>p6
	else
		echo "Password Requirements" >>p1
		echo "Ensure pam modules are in correct order" >>p2
		echo "All are in correct order /etc/pam.d/system-auth" >>p3
		echo "yes" >>p4
		echo "IZ.1.1.4.7" >>p12
		echo "$c" >>p5
		echo "$z" >>p6
	fi
else
	egrep "^password\s" /etc/pam.d/system-auth |grep pam_pwhistory.so
	if [ $? -eq 0 ]
	then
		sk1=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |head -1`
		sk2=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |head -2 |tail -1`
		sk3=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |head -3 |tail -1`
		sk4=`egrep "^password\s" /etc/pam.d/system-auth | awk '{print $3}' |tail -1`
		if [[ "$sk1" == "pam_pwquality.so" || "$sk1" == "pam_cracklib.so" ]] && [ "$sk2" == "pam_pwhistory.so" ] && [ "$sk3" == "pam_unix.so" ] && [ "$sk4" == "pam_deny.so" ]
		then
			echo "Password Requirements" >>p1
			echo "Ensure pam modules are in correct order" >>p2
			echo "PAM password modules are in correct order in /etc/pam.d/system-auth" >>p3
			echo "yes" >>p4
			echo "IZ.1.1.4.7" >>p12
			echo "$c" >>p5
			echo "$z" >>p6
		else
			echo "Password Requirements" >>p1
			echo "Ensure pam modules are in correct order" >>p2
			echo "PAM password modules are not in correct order in /etc/pam.d/system-auth" >>p3
			echo "no" >>p4
			echo "IZ.1.1.4.7" >>p12
			echo "$c" >>p5
			echo "$z" >>p6
		fi
	else
			echo "Password Requirements" >>p1
			echo "Ensure pam modules are in correct order" >>p2
			echo "remember= is not coded on the pam_unix.so module and pam_pwhistory.so not available in /etc/pam.d/system-auth" >>p3
			echo "no" >>p4
			echo "IZ.1.1.4.7" >>p12
			echo "$c" >>p5
			echo "$z" >>p6
	fi
fi



#IZ.1.1.7.3
echo "bin,daemon,adm,lp,sync,shutdown,halt,mail,uucp,operator,games,gopher,ftp,nobody,dbus,usbmuxd,rpc,avahi-autoipd,vcsa,rtkit,saslauth,postfix,avahi,ntp,apache,radvd,rpcuser,nfsnobody,qemu,haldaemon,nm-openconnect,pulse,gsanslcd,gdm,sshd,tcpdump,abrt,chrony,colord,geoclue,gluster,gnome-initial-setup,insights,polkitd,rpc,setroubleshoot,sssd,systemd-bus-proxy,systemd-network,tss,unbound" >temp
tr "," "\n" < temp > temp1
             
	for i in `cat temp1`
        do
		#cat /etc/shadow | awk -F":" '{print $1}' | grep -w ^$i
		getent passwd $i
		if [ $? -eq 0 ]
		then
		sk=`passwd -S $i |awk '{print $2}'`
		if [ "$sk" == "PS" ]
                then
					passwd -l $i
                        echo "IZ.1.1.7.3" >>p12
                        echo "Password_requirement" >>p1
                        echo "Password for system ID's" >>p2
                        echo "Password is locked for system ID $i" >> p3
                        echo "Modified" >>p4
                        echo "$c" >> p5
                        echo "$z" >>p6
		else
			echo "IZ.1.1.7.3" >>p12
                        echo "Password_requirement" >>p1
                        echo "Password for system ID's" >>p2
                        echo "Password is not set for system ID $i" >> p3
                        echo "yes" >>p4
                        echo "$c" >> p5
                        echo "$z" >>p6
		fi
		fi
        done
rm -rf temp temp1

#IZ.1.1.8.3.1:GID-validation
cat /etc/group | awk -F":" '{print $3}'| sort  | uniq -cd | awk '{print $2}'> temp_gid
sp=`cat temp_gid | wc -c`
if [ "$sp" == 0 ]
then
		echo "Password_requirement" >>p1
		echo "GID_validation" >>p2
		echo "No_duplicate_GID-value_for_users_in_/etc/group" >>p3
		echo "yes" >>p4
		echo "$c" >> p5
		echo "IZ.1.1.8.3.1" >>p12
		echo "$z" >>p6	
else
		for i in `cat temp_gid`
		do
		echo "Password_requirement" >>p1
		echo "gid_validation" >>p2
		echo "Duplicate-gid-value-for-GID-$i in /etc/group" >>p3
		echo "no" >>p4
		echo "$c" >> p5
		echo "IZ.1.1.8.3.1" >>p12
		echo "$z" >>p6	
		done
fi

#IZ.1.1.8.3.2
flag=0
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
  grep -q -P "^.*?:[^:]*:$i:" /etc/group 
  if [ $? -ne 0 ]; then 
  	flag=1
	echo "Password Requirements" >>p1
	echo "Ensure all groups in /etc/passwd exist in /etc/group" >>p2
	echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group" >>p3
	echo "no" >>p4
	echo "IZ.1.1.8.3.2" >>p12	
  fi 
done
if [ $flag == 0 ] ; then
	echo "Password Requirements" >>p1
	echo "Ensure all groups in /etc/passwd exist in /etc/group" >>p2
	echo "All groups in /etc/passwd exist in /etc/group" >>p3
	echo "yes" >>p4
	echo "IZ.1.1.8.3.2" >>p12	
fi

#IZ.1.1.4.5
if [ $(egrep -v '^\s*#' /etc/pam.d/password-auth | egrep 'auth.*pam_unix.so.*nullok' |wc -l) -gt 0 ] || [ $(egrep -v '^\s*#' /etc/pam.d/system-auth | egrep 'auth.*pam_unix.so.*nullok' |wc -l) -gt 0 ]
then
	echo "Password Requirements" >>p1
        echo "Do not accept null passwords" >>p2
        echo "Nullok is allowed in /etc/pam.d/password-auth or /etc/pam.d/system-auth" >> p3
        echo "IZ.1.1.4.5">>p12
	echo "Manual_Check_Required" >>p4
        echo "$c" >> p5
        echo "$z" >>p6
        
else
	echo "Password Requirements" >>p1
        echo "Null Password is allowed" >>p2
        echo "Nullok is not allowed in /etc/pam.d/password-auth or /etc/pam.d/system-auth" >> p3
        echo "IZ.1.1.4.5">>p12
	echo "yes" >>p4
        echo "$c" >> p5
        echo "$z" >>p6
        
fi


#IZ.1.1.1.3
epoch=$(($(date --date "$1" +%s)/86400))
sk=`cat /etc/shadow | awk -F: -v epoch="$epoch" '($3 > epoch ) { print $1 " has a future date password change: " $3 " : today epoch is "epoch }' |wc -l`
if [ $sk -gt 0 ]
then
cat /etc/shadow | awk -F: -v epoch="$epoch" '($3 > epoch ) { print $1 " has a future date password change: " $3 " : today epoch is "epoch }' >user
while IFS= read -r line
do
	echo "Password Requirements" >>p1
	echo "last password change date in /etc/shadow" >>p2
	echo "$line" >>p3
	echo "Manual_Check_Required" >>p4
	echo "IZ.1.1.1.3" >>p12
	echo "$c" >> p5
	echo "$z" >>p6
done <user
else
	echo "Password Requirements" >>p1
	echo "last password change date in /etc/shadow" >>p2
	echo "No user has last password change date in future" >>p3
	echo "yes" >>p4
	echo "IZ.1.1.1.3" >>p12
	echo "$c" >> p5
	echo "$z" >>p6
fi
rm -rf user

