#IZ.1.5.13.1
res=`grep "hard core" /etc/security/limits.conf /etc/security/limits.d/*.conf | LC_ALL=C sort -V |tail -1`
if [ $? -eq 0 ] ; then
        echo "Network Settings" >>p1
        echo "Ensure core dumps are restricted" >>p2
        echo "core dumps are restricted" >>p3
        echo "IZ.1.5.13.1">>p12
        echo "yes" >>p4
else
        echo '* hard core 0' >> /etc/security/limits.conf
        echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
        echo "Network Settings" >>p1
        echo "Ensure core dumps are restricted" >>p2
        echo "core dumps are restricted" >>p3
        echo "IZ.1.5.13.1">>p12
        echo "Modified" >>p4
fi

res1=`sysctl fs.suid_dumpable|awk -F= '{print $2}' |sed -e 's/ //g'`
if [ $res1 == 0 ] ; then
        echo "Network Settings" >>p1
        echo "Ensure core dumps are restricted" >>p2
        echo "core dumps are restricted" >>p3
        echo "IZ.1.5.13.1">>p12
        echo "yes" >>p4
else
        sysctl -w fs.suid_dumpable=0
        sysctl -p
        echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
        echo "Network Settings" >>p1
        echo "Ensure core dumps are restricted" >>p2
        echo "core dumps are restricted" >>p3
        echo "IZ.1.5.13.1">>p12
        echo "Modified" >>p4
fi

#IZ.1.5.13.2
if [[ "$(sysctl kernel.randomize_va_space)" == "kernel.randomize_va_space = 2" ]];then
        echo "Network Settings" >>p1
        echo "ASLR" >>p2
        echo "ASLR is enabled" >>p3
        echo "IZ.1.5.13.2">>p12
        echo "Yes" >>p4


else
        if [ $(cat /etc/sysctl.conf |grep ^kernel.randomize_va_space |wc -l) -gt 0 ];then
                sed  -i 's/kernel.randomize_va_space/#kernel.randomize_va_space/g' /etc/sysctl.conf
                echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settings" >>p1
                echo "ASLR" >>p2
                echo "ASLR is disabled" >>p3
                echo "IZ.1.5.13.2">>p12
                echo "Modified" >>p4

        else
                echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settings" >>p1
                echo "ASLR" >>p2
                echo "ASLR is disabled" >>p3
                echo "IZ.1.5.13.2">>p12
                echo "Modified" >>p4

        fi
fi

#IZ.1.5.9.20.9

if [[ "$(sysctl net.ipv4.conf.all.rp_filter)" == "net.ipv4.conf.all.rp_filter = 1" ]]
then

        echo "Network Settings" >>p1
        echo "Ensure Reverse Path Filtering is enabled" >>p2
        echo "net.ipv4.conf.all.rp_filter value is set to 1" >>p3
        echo "IZ.1.5.9.20.9">>p12
        echo "yes" >>p4

else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.all.rp_filter |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.all.rp_filter/#net.ipv4.conf.all.rp_filter/g' /etc/sysctl.conf
                echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settings" >>p1
                echo "Ensure Reverse Path Filtering is enabled" >>p2
                echo "net.ipv4.conf.all.rp_filter value is not set to 1" >>p3
                echo "IZ.1.5.9.20.9">>p12
                echo "Modified" >>p4
        else
                echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settings" >>p1
                echo "Ensure Reverse Path Filtering is enabled" >>p2
                echo "net.ipv4.conf.all.rp_filter value is not set to 1" >>p3
                echo "IZ.1.5.9.20.9">>p12
                echo "Modified" >>p4
        fi
fi

if [[ "$(sysctl net.ipv4.conf.default.rp_filter)" == "net.ipv4.conf.default.rp_filter = 1" ]]
then

        echo "Network Settings" >>p1
        echo "Ensure Reverse Path Filtering is enabled" >>p2
        echo "sysctl net.ipv4.conf.default.rp_filter value is set to 1" >>p3
        echo "IZ.1.5.9.20.9">>p12
        echo "yes" >>p4

else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.default.rp_filter |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.default.rp_filter/#net.ipv4.conf.default.rp_filter/g' /etc/sysctl.conf
                echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settings" >>p1
                echo "Ensure Reverse Path Filtering is enabled" >>p2
                echo "sysctl net.ipv4.conf.default.rp_filter value is not set to 1" >>p3
                echo "IZ.1.5.9.20.9">>p12
                echo "Modified" >>p4
        else
                echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settings" >>p1
                echo "Ensure Reverse Path Filtering is enabled" >>p2
                echo "sysctl net.ipv4.conf.default.rp_filter value is not set to 1" >>p3
                echo "IZ.1.5.9.20.9">>p12
                echo "Modified" >>p4
        fi
fi

#IZ.1.5.9.20.1 Done
if [[ "$(sysctl net.ipv4.tcp_syncookies)" == "net.ipv4.tcp_syncookies = 1" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.tcp_syncookies = 1 in /etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.1 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.tcp_syncookies |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.tcp_syncookies/#net.ipv4.tcp_syncookies/g' /etc/sysctl.conf
                echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "Incorrect-value-set-for-net.ipv4.tcp_syncookies-in-/etc/sysctl.conf" >> p3
                echo "Modified" >>p4

                echo IZ.1.5.9.20.1 >>p12
        else
                echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "Incorrect-value-set-for-net.ipv4.tcp_syncookies-in-/etc/sysctl.conf" >> p3
                echo "Modified" >>p4

                echo IZ.1.5.9.20.1 >>p12
        fi
fi


#IZ.1.5.9.20.2
if [[ "$(sysctl net.ipv4.icmp_echo_ignore_broadcasts)" == "net.ipv4.icmp_echo_ignore_broadcasts = 1" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.icmp_echo_ignore_broadcasts=1-in-/etc/sysctl.conf" >>p3
        echo IZ.1.5.9.20.2 >>p12
        echo "yes" >>p4

else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.icmp_echo_ignore_broadcasts |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.icmp_echo_ignore_broadcasts/#net.ipv4.icmp_echo_ignore_broadcasts/g' /etc/sysctl.conf
                echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.icmp_echo_ignore_broadcasts=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.2 >>p12

        else
                echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.icmp_echo_ignore_broadcasts=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.2 >>p12

        fi
fi


#IZ.1.5.9.20.3
if [[ "$(sysctl net.ipv4.conf.all.accept_redirects)" == "net.ipv4.conf.all.accept_redirects = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.all.accept_redirects=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.3 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.all.accept_redirects |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.all.accept_redirects/#net.ipv4.conf.all.accept_redirects/g' /etc/sysctl.conf
                echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.accept_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.3 >>p12

        else
                echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.accept_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.3 >>p12

        fi

fi


#IZ.1.5.9.20.4
if [[ "$(sysctl net.ipv4.ip_forward)" == "net.ipv4.ip_forward = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.ip_forward=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.4 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.ip_forward |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.ip_forward/#net.ipv4.ip_forward/g' /etc/sysctl.conf
                echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.ip_forward=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.4 >>p12

        else
                echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.ip_forward=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.4 >>p12

        fi
fi

#IZ.1.5.9.20.5
if [[ "$(sysctl net.ipv4.conf.all.accept_source_route)" == "net.ipv4.conf.all.accept_source_route = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.all.accept_source_route=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.5 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.all.accept_source_route |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.all.accept_source_route/#net.ipv4.conf.all.accept_source_route/g' /etc/sysctl.conf
                echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.accept_source_route=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.5 >>p12

        else
                echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.accept_source_route=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.5 >>p12

        fi
fi

if [[ "$(sysctl net.ipv4.conf.default.accept_source_route)" == "net.ipv4.conf.default.accept_source_route = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.default.accept_source_route=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.5 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.default.accept_source_route |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.default.accept_source_route/#net.ipv4.conf.default.accept_source_route/g' /etc/sysctl.conf
                echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.default.accept_source_route=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.5 >>p12

        else
                echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.default.accept_source_route=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.5 >>p12

        fi
fi



#IZ.1.5.9.20.6
if [[ "$(sysctl net.ipv4.conf.all.secure_redirects)" == "net.ipv4.conf.all.secure_redirects = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.all.secure_redirects=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.6 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.all.secure_redirects |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.all.secure_redirects/#net.ipv4.conf.all.secure_redirects/g' /etc/sysctl.conf
                echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.secure_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.6 >>p12

        else
                echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.secure_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.6 >>p12

        fi
fi

if [[ "$(sysctl net.ipv4.conf.default.secure_redirects)" == "net.ipv4.conf.default.secure_redirects = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.default.secure_redirects=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.6 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.default.secure_redirects |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.default.secure_redirects/#net.ipv4.conf.default.secure_redirects/g' /etc/sysctl.conf
                echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.default.secure_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.6 >>p12

        else
                echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.default.secure_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.6 >>p12

        fi
fi



#IZ.1.5.9.20.7
if [[ "$(sysctl net.ipv4.conf.all.log_martians)" == "net.ipv4.conf.all.log_martians = 1" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.all.log_martians=1-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.7 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.all.log_martians |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.all.log_martians/#net.ipv4.conf.all.log_martians/g' /etc/sysctl.conf
                echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.log_martians=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.7 >>p12

        else
                echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.all.log_martians=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.7 >>p12

        fi
fi

if [[ "$(sysctl net.ipv4.conf.default.log_martians)" == "net.ipv4.conf.default.log_martians = 1" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.conf.default.log_martians=1-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo IZ.1.5.9.20.7 >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.conf.default.log_martians |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.conf.default.log_martians/#net.ipv4.conf.default.log_martians/g' /etc/sysctl.conf
                echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.default.log_martians=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.7 >>p12

        else
                echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.conf.default.log_martians=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.7 >>p12

        fi
fi

#IZ.1.5.9.20.8
if [[ "$(sysctl net.ipv4.icmp_ignore_bogus_error_responses)" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv4.icmp_ignore_bogus_error_responses=1-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4
    echo IZ.1.5.9.20.8 >>p12


else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv4.icmp_ignore_bogus_error_responses |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv4.icmp_ignore_bogus_error_responses/#net.ipv4.icmp_ignore_bogus_error_responses/g' /etc/sysctl.conf
                echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.icmp_ignore_bogus_error_responses=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.8 >>p12

        else
                echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv4.icmp_ignore_bogus_error_responses=1_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo IZ.1.5.9.20.8 >>p12

        fi
fi


#IZ.1.5.9.21.1
if [[ "$(sysctl net.ipv6.conf.all.accept_ra)" == "net.ipv6.conf.all.accept_ra = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv6.conf.all.accept_ra=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo "IZ.1.5.9.21.1" >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv6.conf.all.accept_ra |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv6.conf.all.accept_ra/#net.ipv6.conf.all.accept_ra/g' /etc/sysctl.conf
                echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.all.accept_ra=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.1" >>p12

        else
                echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.all.accept_ra=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.1" >>p12

        fi
fi

if [[ "$(sysctl net.ipv6.conf.default.accept_ra)" == "net.ipv6.conf.default.accept_ra = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv6.conf.default.accept_ra=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo "IZ.1.5.9.21.1" >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv6.conf.default.accept_ra |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv6.conf.default.accept_ra/#net.ipv6.conf.default.accept_ra/g' /etc/sysctl.conf
                echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.default.accept_ra=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.1" >>p12

        else
                echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.default.accept_ra=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.1" >>p12

        fi
fi


#IZ.1.5.9.21.2
if [[ "$(sysctl net.ipv6.conf.all.accept_redirects)" == "net.ipv6.conf.all.accept_redirects = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv6.conf.all.accept_redirects=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo "IZ.1.5.9.21.2" >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv6.conf.all.accept_redirects |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv6.conf.all.accept_redirects/#net.ipv6.conf.all.accept_redirects/g' /etc/sysctl.conf
                echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.all.accept_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.2" >>p12

        else
                echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.all.accept_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.2" >>p12

        fi
fi

if [[ "$(sysctl net.ipv6.conf.default.accept_redirects)" == "net.ipv6.conf.default.accept_redirects = 0" ]];then
        echo "Network Settingss" >>p1
        echo "/etc/sysctl.conf" >>p2
        echo "Correct-setting-net.ipv6.conf.default.accept_redirects=0-in-/etc/sysctl.conf" >>p3
        echo "yes" >>p4

        echo "IZ.1.5.9.21.2" >>p12
else
        if [ $(cat /etc/sysctl.conf |grep ^net.ipv6.conf.default.accept_redirects |wc -l) -gt 0 ];then
                sed  -i 's/net.ipv6.conf.default.accept_redirects/#net.ipv6.conf.default.accept_redirects/g' /etc/sysctl.conf
                echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.default.accept_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.2" >>p12

        else
                echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
                sysctl -p
                echo "Network Settingss" >>p1
                echo "/etc/sysctl.conf" >>p2
                echo "net.ipv6.conf.default.accept_redirects=0_is_not_set-in-/etc/sysctl.conf" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.21.2" >>p12

        fi
fi

#IZ.1.5.9.40:rsh package
rpm -q rsh
if [ $? -eq 0 ]
then
                yum remove -y rsh
                echo "Network Settings" >>p1
                echo "RSH" >>p2
                echo "RSH package is removed" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.40" >>p12
        else
                echo "Network Settings" >>p1
                echo "RSH" >>p2
                echo "RSH package is not installed" >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.40" >>p12
fi

#IZ.1.5.10.3
rp=`rpm -q ypbind`
if [ $? -ne 0 ] ; then
        echo "Network Settings" >>p1
        echo "NIS+ maps" >>p2
        echo "ypbind is not installed" >>p3
        echo "IZ.1.5.10.3">>p12
        echo "yes" >>p4

else
        ypbind.service is enabled
        if [ $? -eq 0 ];then
                systemctl disable ypbind.service
                echo "Network Settings" >>p1
                echo "NIS+ maps" >>p2
                echo "ypbind service was running disabled" >>p3
                echo "IZ.1.5.10.3">>p12
                echo "Modified" >>p4
        else
                echo "Network Settings" >>p1
                echo "NIS+ maps" >>p2
                echo "ypbind service is disabled" >>p3
                echo "IZ.1.5.10.3">>p12
                echo "yes" >>p4
        fi
fi

#IZ.1.5.1.1
if [ "$(rpm -q ftp)" != "package ftp is not installed" ] || [ "$(rpm -q vsftpd)" != "package vsftpd is not installed" ]
then
        sk=`systemctl is-enabled ftpd`
        sl=`systemctl is-enabled vsftpd`
        if [ "$sk" == "enabled" ] || [ "$sl" == "enabled" ]
        then
                sp=`cat /etc/vsftpd/vsftpd.conf |grep ^anonymous_enable |awk -F"=" '{print $2}'`
                if [ "$sp" == "YES" ]
                then
                        grep "^ftp" /etc/xinetd.d/wu-ftpd | grep "-u" | grep -q 027
                        if [ $? -eq 0 ]
                        then
                                        echo "Network Settingss" >> p1
                                        echo "Anonymous FTP System Settings" >>p2
                                        echo "FTP service is running and anonymous write is allowed and wu-ftpd is in use" >>p3
                                        echo "IZ.1.5.1.1">>p12
                                        echo "yes" >>p4
                                        echo "$c" >>p5
                                        echo "$z" >>p6
                        else
                                        echo "Network Settingss" >> p1
                                        echo "Anonymous FTP System Settings" >>p2
                                        echo "FTP service is running but anonymous write setting is not correct" >>p3
                                        echo "IZ.1.5.1.1">>p12
                                        echo "no" >>p4
                                        echo "$c" >>p5
                                        echo "$z" >>p6
                        fi
                else
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "ftpd or vsftpd service is enabled but anonymous FTP setting is disabled " >>p3
                        echo "IZ.1.5.1.1">>p12
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                fi
        else
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "ftpd or vsftpd package is installed but ftpd or vsftpd service is not enabled " >>p3
                        echo "IZ.1.5.1.1">>p12
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
        fi
else
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "ftpd or vsftpd package is not installed" >>p3
                        echo "IZ.1.5.1.1">>p12
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6

fi

#IZ.1.5.1.2:IZ.1.5.1.3:IZ.1.5.1.4:IZ.1.5.1.5:IZ.1.5.1.6:IZ.1.5.1.7:IZ.1.5.1.8
if [ "$(rpm -q ftp)" != "package ftp is not installed" ] || [ "$(rpm -q vsftpd)" != "package vsftpd is not installed" ]
then
        sk=`systemctl is-enabled ftpd`
        sl=`systemctl is-enabled vsftpd`
        if [ "$sk" == "enabled" ] || [ "$sl" == "enabled" ]
        then
                sp=`cat /etc/vsftpd/vsftpd.conf |grep ^anonymous_enable |awk -F"=" '{print $2}'`
                if [ "$sp" == "YES" ]
                then
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "Anonymous FTP is enabled. Please check Techspec for correct setting" >>p3
                        echo "IZ.1.5.1.2:IZ.1.5.1.3:IZ.1.5.1.4:IZ.1.5.1.5:IZ.1.5.1.6:IZ.1.5.1.7:IZ.1.5.1.8">>p12
                        echo "no" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                else
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "Anonymous FTP is disabled" >>p3
                        echo "IZ.1.5.1.2:IZ.1.5.1.3:IZ.1.5.1.4:IZ.1.5.1.5:IZ.1.5.1.6:IZ.1.5.1.7:IZ.1.5.1.8">>p12
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                fi

        else
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "ftpd or vsftpd package is installed but ftpd or vsftpd service is not enabled " >>p3
                        echo "IZ.1.5.1.2:IZ.1.5.1.3:IZ.1.5.1.4:IZ.1.5.1.5:IZ.1.5.1.6:IZ.1.5.1.7:IZ.1.5.1.8">>p12
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
        fi
else
                        echo "Network Settingss" >> p1
                        echo "Anonymous FTP System Settings" >>p2
                        echo "ftpd or vsftpd package is not installed" >>p3
                        echo "IZ.1.5.1.2:IZ.1.5.1.3:IZ.1.5.1.4:IZ.1.5.1.5:IZ.1.5.1.6:IZ.1.5.1.7:IZ.1.5.1.8">>p12
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6

fi

#IZ.1.5.2.1;IZ.1.5.2.2:TFTP filecheck
rpm -qa |egrep "tftp-server|tftp"
if [ $? -ne 0 ]
then
                echo "Network Settings" >>p1
                echo "TFTP System Setting" >>p2
                echo "IZ.1.5.2.1" >>p12
                echo "Base package tftp or tftp-server is not installed" >> p3
                echo "Not_Applicable" >>p4

else
                echo "Network Settings" >>p1
                echo "TFTP System Setting" >>p2
                echo "IZ.1.5.2.1" >>p12
                echo "Base package tftp or tftp-server is installed. Please check the Techspec for Additional check" >> p3
                echo "no" >>p4

fi

#IZ.1.5.3.1
systemctl is-enabled nfs-server
if [ $? -eq 0 ]
then
        sk=`ls -ld /etc/exports |awk '{print $3}'`
        szm=$(stat -c "%a %n" /etc/exports |awk '{print $1}')
        if [ "$sk" == "root" ] && [[ "$szm" == "644" || "$szm" == "640" || "$szm" == "600" ]]
        then
                echo "Network Settingss" >>p1
                echo "/etc/exports" >>p2
                echo "NFS service is enabled and file permission is correct" >> p3
                echo "yes" >>p4
                echo "IZ.1.5.3.1" >>p12

        else
                chown root:root /etc/exports
                chmod 644 /etc/exports
                echo "Network Settingss" >>p1
                echo "/etc/exports" >>p2
                echo "NFS service is enabled and file permission is modified" >> p3
                echo "Modified" >>p4
                echo "$z" >>p6
                echo "$c" >> p5
                echo "IZ.1.5.3.1" >>p12
        fi
else
                echo "Network Settingss" >>p1
                echo "/etc/exports" >>p2
                echo "NFS service is not enabled" >> p3
                echo "yes" >>p4
                echo "$z" >>p6
                echo "$c" >> p5
                echo "IZ.1.5.3.1" >>p12
fi

#IZ.1.5.4.1
if [ -f /etc/hosts.equiv ]
then
        cp -p /etc/hosts.equiv /etc/hosts.equiv.$CHNG_NUMBER
        rm -rf /etc/hosts.equiv
        echo "Network Settings" >>p1
        echo "/etc/hosts.equiv" >>p2
        echo "/etc/hosts.equiv-file-removed" >> p3
        echo "IZ.1.5.4.1" >>p12
        echo "Modified" >>p4

else
        echo "Network Settings" >>p1
        echo "/etc/hosts.equiv" >>p2
        echo "/etc/hosts.equiv-file-not-exist" >> p3
        echo "IZ.1.5.4.1" >>p12
        echo "yes" >>p4


fi

#IZ.1.5.3.3
systemctl is-enabled nfs-server
if [ $? -eq 0 ]
then
        sk=`grep no_root_squash /etc/exports |wc -l`
        if [ $sk -gt 0 ]
        then
                echo "Network Settingss" >>p1
                echo "/etc/exports" >>p2
                echo "NFS service is enabled and no_root_squash option is there in /etc/exports" >> p3
                echo "no" >>p4
                echo "IZ.1.5.3.3" >>p12

        else
                echo "Network Settingss" >>p1
                echo "/etc/exports" >>p2
                echo "NFS service is enabled and no_root_squash option is not there in /etc/exports" >> p3
                echo "yes" >>p4
                echo "$z" >>p6
                echo "$c" >> p5
                echo "IZ.1.5.3.3" >>p12
        fi
else
                echo "Network Settingss" >>p1
                echo "/etc/exports" >>p2
                echo "NFS service is not enabled" >> p3
                echo "yes" >>p4
                echo "$z" >>p6
                echo "$c" >> p5
                echo "IZ.1.5.3.3" >>p12
fi

#IZ.1.5.4.2
if [ -f /etc/pam.d/rlogin ] || [ -f  /etc/pam.d/rsh ]
then
        sm=`grep "^[^#]*pam_rhosts_auth.so" /etc/pam.d/rlogin | grep -v no_hosts_equiv |wc -l`
        sn=`grep "^[^#]*pam_rhosts_auth.so" /etc/pam.d/rsh | grep -v no_hosts_equiv |wc -l`
        if [ $sm -eq 0 ] || [ $sn -eq 0 ]
        then
                echo "Network Settingss" >>p1
                echo "/etc/pam.d-and-etc/pam.d/rlogin" >>p2
                echo "pam_rhosts_auth.so and no_hosts_equiv stanza is not present in-/etc/pam.d/rlogin or /etc/pam.d/rsh" >> p3
                echo "yes" >>p4
                echo "$c" >> p5
                echo IZ.1.5.4.2 >>p12
                echo "$z" >>p6
        else
                echo "Network Settingss" >>p1
                echo "/etc/pam.d-and-etc/pam.d/rlogin" >>p2
                echo "Required-settings-not-found-in-file-/etc/pam.d/rlogin-and-/etc/pam.d/rsh" >> p3
                echo "no" >>p4

                echo IZ.1.5.4.2 >>p12
        fi
else
                echo "Network Settingss" >>p1
                echo "/etc/pam.d-and-etc/pam.d/rlogin" >>p2
                echo "Files /etc/pam.d/rlogin or /etc/pam.d/rsh not exists" >> p3
                echo "yes" >>p4
                echo IZ.1.5.4.2 >>p12
fi

#IZ.1.5.5;IZ.1.5.9.1,IZ.1.5.9.2,IZ.1.5.9.3,IZ.1.5.9.4,IZ.1.5.9.6,IZ.1.5.9.7,AD,1.5.9.8,IZ.1.5.9.10,IZ.1.5.9.11,IZ.1.5.9.12,IZ.1.5.9.14
echo "rexd,chargen,daytime,discard,echo,finger,systat,rwho,echo,chargen,rstatd,tftp,rwalld,rusersd,discard,daytime,finger,sprayd,pcnfsd" >temp
tr "," "\n" < temp > temp1
for i in `cat temp1`
do
        ls /etc/xinetd.d |grep $i >services1
        if [ $(cat services1 |wc -l) -gt 0 ];then
        for j in `cat services1`
        do
        sk=`cat /etc/xinetd.d/$j |grep -v '#' |grep -v '^$' |grep disable |awk -F= '{print $2}' |sed -e 's/ //g'`
                if [ "$sk" == "no" ]
                then
                        sed -i 's/disable.*/disable         = yes/g' /etc/xinetd.d/$j
                        echo "Service $j is disabled in /etc/xinetd.d" >>p3
                        echo "Network Settings" >>p1
                        echo "Denial of service" >>p2
                        echo "IZ.1.5.5,IZ.1.5.9.1,IZ.1.5.9.2,IZ.1.5.9.3,IZ.1.5.9.4,IZ.1.5.9.6,IZ.1.5.9.7,AD,1.5.9.8,IZ.1.5.9.10,IZ.1.5.9.11,IZ.1.5.9.12,IZ.1.5.9.14" >>p12
                        echo "Modified" >>p4
                        echo "$c" >>p5
                else
                        echo "Service $j is not enabled in /etc/xinetd.d" >>p3
                        echo "Network Settings" >>p1
                        echo "Denial of service" >>p2
                        echo "IZ.1.5.5,IZ.1.5.9.1,IZ.1.5.9.2,IZ.1.5.9.3,IZ.1.5.9.4,IZ.1.5.9.6,IZ.1.5.9.7,AD,1.5.9.8,IZ.1.5.9.10,IZ.1.5.9.11,IZ.1.5.9.12,IZ.1.5.9.14" >>p12
                        echo "yes" >>p4
                fi
        done
        fi
done
rm -rf services1 temp temp1

for service in chargen-dgram chargen-stream daytime-dgram daytime-stream discard-dgram discard-stream echo-dgram echo-stream time-dgram time-stream tftp echo rexd finger rstatd rwalld rusersd sprayd pcnfsd rexec.socket tftp.socket
do
        ENABLED_SERVICES=$(systemctl list-unit-files | awk '($2 == "enabled") {print $0}')
        sp=`whereis systemctl |awk '{print $2}'`
        echo $ENABLED_SERVICES | grep $service 2>&1 > /dev/null
        if [ $? -eq 0 ]
        then
                $sp disable $service
                echo "Service $service is disabled in systemctl" >>p3
                echo "Network Settings" >>p1
                echo "Denial of service" >>p2
                echo "IZ.1.5.5,IZ.1.5.9.1,IZ.1.5.9.2,IZ.1.5.9.3,IZ.1.5.9.4,IZ.1.5.9.6,IZ.1.5.9.7,AD,1.5.9.8,IZ.1.5.9.10,IZ.1.5.9.11,IZ.1.5.9.12,IZ.1.5.9.14" >>p12
                echo "Modified" >>p4
                echo "$c" >>p5
        else
                echo "Service $service is not present in systemctl" >>p3
                echo "Network Settings" >>p1
                echo "Denial of service" >>p2
                echo "IZ.1.5.5,IZ.1.5.9.1,IZ.1.5.9.2,IZ.1.5.9.3,IZ.1.5.9.4,IZ.1.5.9.6,IZ.1.5.9.7,AD,1.5.9.8,IZ.1.5.9.10,IZ.1.5.9.11,IZ.1.5.9.12,IZ.1.5.9.14" >>p12
                echo "yes" >>p4
                echo "$c" >>p5
        fi

        ENABLED_SERVICES=`chkconfig --list |grep $service`
        sp=`whereis chkconfig |awk '{print $2}'`
        echo $ENABLED_SERVICES | grep $service 2>&1 > /dev/null
        if [ $? -eq 0 ]
        then
                $sp $service off
                echo "Service $service is disabled in chkconfig" >>p3
                echo "Network Settings" >>p1
                echo "Denial of service" >>p2
                echo "IZ.1.5.5,IZ.1.5.9.1,IZ.1.5.9.2,IZ.1.5.9.3,IZ.1.5.9.4,IZ.1.5.9.6,IZ.1.5.9.7,AD,1.5.9.8,IZ.1.5.9.10,IZ.1.5.9.11,IZ.1.5.9.12,IZ.1.5.9.14" >>p12
                echo "Modified" >>p4
                echo "$c" >>p5
        fi
done



#IZ.1.5.9.1;IZ.1.5.9.2;IZ.1.5.9.7;IZ.1.5.9.8;IZ.1.5.9.9
for service in chargen-dgram chargen-stream daytime-dgram daytime-stream discard-dgram discard-stream echo-dgram echo-stream time-dgram time-stream bootps
do
sk=`chkconfig --list 2>/dev/null |awk '{$1=$1};1' |grep ^$service |awk -F":" '{print $2}' |awk '{$1=$1};1'`
if [ "$sk" == "on" ]
then
        echo "Network Settings" >>p1
        echo "Denial of Service through xinetd or inetd" >>p2
        echo "Service $service is enabled in chkconfig" >>p3
        echo "no" >>p4
        echo "IZ.1.5.9.1;IZ.1.5.9.2;IZ.1.5.9.7;IZ.1.5.9.8;IZ.1.5.9.9" >>p12
        echo "$c" >>p5
        echo "$z" >>p6
else
        echo "Network Settings" >>p1
        echo "Denial of Service through xinetd or inetd" >>p2
        echo "Service $service is not enabled in chkconfig" >>p3
        echo "yes" >>p4
        echo "IZ.1.5.9.1;IZ.1.5.9.2;IZ.1.5.9.7;IZ.1.5.9.8;IZ.1.5.9.9" >>p12
        echo "$c" >>p5
        echo "$z" >>p6
fi
done


#IZ.1.5.9.23
rpm -qa |grep telnet-server
if [ $? -eq 0 ]
then
        systemctl is-enabled telnet.socket
        if [ $? -eq 0 ]
        then
                echo "Network Settings" >>p1
                echo "telnet-service" >>p2
                echo "telnet-server package is installed and telnet.socket service is enabled" >>p3
                echo "no" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.23" >>p12
        else
                echo "Network Settings" >>p1
                echo "telnet-service" >>p2
                echo "telnet-server package is installed but telnet.socket service is disabled" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.23" >>p12
        fi
else
                echo "Network Settings" >>p1
                echo "telnet-service" >>p2
                echo "telnet-server package is not installed" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.23" >>p12
fi

#IZ.1.5.9.24.2
systemctl is-active vsftpd
if [ $? -eq 0 ] ; then
sp=`cat /etc/vsftpd/vsftpd.conf |grep ^anonymous_enable |awk -F"=" '{print $2}'`
        if [ "$sp" == "YES" ]
        then
                sed -i 's/^anonymous_enable.*/anonymous_enable=NO/g' /etc/vsftpd/vsftpd.conf
                echo "Network Settings" >>p1
                echo "Disable anonymous ftp if vsftpd is enabled" >>p2
                echo "vsftpd service is enabled and anonymous_enable is modified as NO" >> p3
                echo "Modified" >>p4

                echo "IZ.1.5.9.24.2" >>p12
        else
                echo "Network Settings" >>p1
                echo "Disable anonymous ftp if vsftpd is enabled" >>p2
                echo "vsftpd service is enabled and anonymous_enable is set as $sp" >> p3
                echo "yes" >>p4
                echo "IZ.1.5.9.24.2" >>p12

        fi
else
        echo "Network Settings" >>p1
        echo "Disable anonymous ftp if vsftpd is enabled" >>p2
        echo "vsftpd service is disabled" >> p3
        echo "yes" >>p4

        echo "IZ.1.5.9.24.2" >>p12
fi



#IZ.1.5.10.1
rpm -q ypserv ypbind
if [ $? -eq 0 ]
then
        sl=`which service`
        $sl yppasswdd status
        if [ $? -eq 0 ]
        then
                        yum remove ypbind
                        yum remove ypserv
                        echo "Network Settings" >>p1
                        echo "yppasswdd-daemon" >>p2
                        echo "ypserv and ypbind package removed" >>p3
                        echo "Modified" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                        echo "IZ.1.5.10.1" >>p12
        else
                        echo "Network Settings" >>p1
                        echo "yppasswdd-daemon" >>p2
                        echo "yppasswdd-daemon-is-not-running" >>p3
                        echo "yes" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                        echo "IZ.1.5.10.1" >>p12
        fi
else
        echo "Network Settings" >>p1
        echo "yppasswdd-daemon" >>p2
        echo "NIS packages not installed" >>p3
        echo "yes" >>p4
        echo "$c" >>p5
        echo "$z" >>p6
        echo "IZ.1.5.10.1" >>p12
fi


#IZ.1.5.10.2
rpm -q ypbind
if [ $? -eq 0 ]
then
        systemctl disable ypbind.service
        echo "Network Settings" >>p1
        echo "NIS and NIS+ maps" >>p2
        echo "ypbind service is disabled" >>p3
        echo "Modified" >>p4
        echo "$c" >>p5
        echo "$z" >>p6
        echo "IZ.1.5.10.2" >>p12
else
        echo "Network Settings" >>p1
        echo "NIS and NIS+ maps" >>p2
        echo "ypbind package is not installed" >>p3
        echo "yes" >>p4
        echo "$c" >>p5
        echo "$z" >>p6
        echo "IZ.1.5.10.2" >>p12
fi

#IZ.1.5.11.1;IZ.1.5.11.2;IZ.1.5.11.3
if [[ "$(rpm -q rsh-server)" != "package rsh-server is not installed" ]]
then
        for service in rsh.socket rlogin.socket rexec.socket;do
        systemctl is-enabled $service
        if [ $? -eq 0 ]
        then
                systemctl disable $service
                echo "Network Settings" >>p1
                echo "rlogin" >>p2
                echo "$service is disabled" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.11.1;IZ.1.5.11.2;IZ.1.5.11.3" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                echo "Network Settings" >>p1
                echo "rlogin" >>p2
                echo "$service is not enabled" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.11.1;IZ.1.5.11.2;IZ.1.5.11.3" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
        done
else
                echo "Network Settings" >>p1
                echo "rlogin" >>p2
                echo "rsh-server package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.11.1;IZ.1.5.11.2;IZ.1.5.11.3" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.18.1
rpm -qa | grep net-snmp
if [ $? -eq 0 ]
then
        systemctl is-enabled snmpd
        if [ $? -eq 0 ]
        then
                systemctl disabled snmpd
                echo "Network Settings" >>p1
                echo "SNMP Service, disabled" >>p2
                echo "net-snmp package is installed and snmpd service is disabled" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.1" >>p12
        else
                echo "Network Settings" >>p1
                echo "SNMP Service, disabled" >>p2
                echo "net-snmp package is installed and snmpd service is not enabled" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.1" >>p12
        fi
else
                echo "Network Settings" >>p1
                echo "SNMP Service, disabled" >>p2
                echo "net-snmp package is not installed" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.1" >>p12
fi

#IZ.1.5.9.18.2
systemctl is-enabled snmpd
if [ $? -eq 0 ]
then
        sk=`cat /etc/snmp/snmpd.conf |grep ^rocommunity |grep -i public |wc -l`
        if [ $sk -gt 0 ]
        then
                echo "Network Settings" >>p1
                echo "SNMP Service, no 'public'" >>p2
                echo "snmpd service is enabled and Public community is enabled in /etc/snmp/snmpd.conf" >>p3
                echo "no" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.2" >>p12
        else
                echo "Network Settings" >>p1
                echo "SNMP Service, no 'public'" >>p2
                echo "snmpd service is enabled and Public community is not enabled in /etc/snmp/snmpd.conf" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.2" >>p12
        fi
else
                echo "Network Settings" >>p1
                echo "SNMP Service, no 'public'" >>p2
                echo "snmpd service is disabled" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.2" >>p12
fi

#IZ.1.5.9.18.3
systemctl is-enabled snmpd
if [ $? -eq 0 ]
then
        sk=`cat /etc/snmp/snmpd.conf |grep ^rocommunity |grep -i private |wc -l`
        if [ $sk -gt 0 ]
        then
                echo "Network Settings" >>p1
                echo "SNMP Service, no 'private'" >>p2
                echo "snmpd service is enabled and private community is enabled in /etc/snmp/snmpd.conf" >>p3
                echo "no" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.3" >>p12
        else
                echo "Network Settings" >>p1
                echo "SNMP Service, no 'private'" >>p2
                echo "snmpd service is enabled and private community is not enabled in /etc/snmp/snmpd.conf" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.3" >>p12
        fi
else
                echo "Network Settings" >>p1
                echo "SNMP Service, no 'private'" >>p2
                echo "snmpd service is disabled" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.18.3" >>p12
fi




#IZ.1.5.9.24.1.1
if [ "$(rpm -q ftp)" != "package ftp is not installed" ] || [ "$(rpm -q vsftpd)" != "package vsftpd is not installed" ]
then
systemctl is-enabled vsftpd
 if [ $? -eq 0 ] ; then
                systemctl disable vsftpd
                echo "Network Settings" >>p1
                echo "vsftpd service must be disabled" >>p2
                echo "vsftpd service is not  disabled" >> p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.24.1.1" >>p12
        else
                echo "Network Settings" >>p1
                echo "vsftpd service must be disabled." >>p2
                echo "vsftpd service is  disabled." >> p3
                echo "yes" >>p4
                echo "IZ.1.5.9.24.1.1" >>p12
        fi
else
        echo "Network Settings" >>p1
        echo "vsftpd service must be disabled" >>p2
        echo "vsftpd package is not installed" >> p3
        echo "yes" >>p4

        echo "IZ.1.5.9.24.1.1" >>p12
fi

#IZ.1.5.9.24.1.2
if [ -f /etc/vsftpd/vsftpd.conf ] || [ -f /etc/vsftpd/user_list ]
then
 if [ "$(stat --format %a /etc/vsftpd/vsftpd.conf)" == 600 ] && [ "$(stat --format %a /etc/vsftpd/user_list)" == 600 ]; then

                echo "Network Settings" >>p1
                echo "protect vsftpd control files if they exist" >>p2
                echo "/etc/vsftpd/vsftpd.conf and /etc/vsftpd/user_list have permission set as 600" >> p3
                echo "yes" >>p4

                echo "IZ.1.5.9.24.1.2" >>p12

        else
                chmod 600 /etc/vsftpd/vsftpd.conf
                chmod 600 /etc/vsftpd/user_list
                echo "Network Settings" >>p1
                echo "protect vsftpd control files if they exist" >>p2
                echo "/etc/vsftpd/vsftpd.conf and /etc/vsftpd/user_list do_not have permission set as 600" >> p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.24.1.2" >>p12


        fi
else
        echo "Network Settings" >>p1
        echo "protect vsftpd control files if they exist" >>p2
        echo "Files /etc/vsftpd/vsftpd.conf and /etc/vsftpd/user_list not exists" >> p3
        echo "yes" >>p4

        echo "IZ.1.5.9.24.1.2" >>p12

fi


#IZ.1.5.9.24.4.1;IZ.1.5.9.24.4.2 - updated
systemctl is-enabled vsftpd
if [ $? -eq 0 ];then
if [ -f /etc/vsftpd/vsftpd.conf ] ; then
flag=0
if [ -f /etc/vsftpd/vsftpd.conf ] ; then
        rsa_cert_file=`grep '^rsa_cert_file' /etc/vsftpd/vsftpd.conf |awk -F'=' '{print $2}'`
        rsa_private_key_file=`grep '^rsa_private_key_file' /etc/vsftpd/vsftpd.conf |awk -F'=' '{print $2}'`
        if [ "$rsa_cert_file" != '' ] && [ "$rsa_private_key_file" != '' ]; then
                if [ -f $rsa_cert_file ] && [ -f $rsa_cert_file ] ; then
                        sl1=`stat -c "%a" $rsa_cert_file`
                        sl2=`stat -c "%a" $rsa_private_key_file`
                        if [ $? -eq 0 ] && [ $sl1 == 600 ] && [ $sl2 == 600 ] ; then
                                grep -q '^ssl_enable\s*=\s*YES' /etc/vsftpd/vsftpd.conf
                                if [ $? -eq 0 ] ; then
                                        grep -q '^allow_anon_ssl\s*=\s*YES' /etc/vsftpd/vsftpd.conf
                                        if [ $? -eq 0 ] ; then
                                                grep -q '^force_local_data_ssl\s*=\s*YES' /etc/vsftpd/vsftpd.conf
                                                if [ $? -eq 0 ] ; then
                                                        grep -q '^force_local_logins_ssl\s*=\s*YES' /etc/vsftpd/vsftpd.conf
                                                        if [ $? -eq 0 ] ; then
                                                                grep -q '^ssl_sslv2\s*=\s*NO' /etc/vsftpd/vsftpd.conf
                                                                if [ $? -eq 0 ] ; then
                                                                        grep -q '^ssl_sslv3\s*=\s*NO' /etc/vsftpd/vsftpd.conf
                                                                        if [ $? -eq 0 ] ; then
                                                                                grep -q '^ssl_tlsv1\s*=\s*NO' /etc/vsftpd/vsftpd.conf
                                                                                if [ $? -eq 0 ] ; then
                                                                                        grep -q '^ssl_tlsv1_1\s*=\s*NO' /etc/vsftpd/vsftpd.conf
                                                                                        if [ $? -eq 0 ] ; then
                                                                                                grep -q '^ssl_tlsv1_2\s*=\s*YES' /etc/vsftpd/vsftpd.conf
                                                                                                if [ $? -eq 0 ] ; then
                                                                                                        flag=1
                                                                                                fi
                                                                                        fi
                                                                                fi
                                                                        fi
                                                                fi
                                                        fi
                                                fi
                                        fi
                                fi
                        fi
                fi
        fi
fi
if [ $flag == 1 ] ; then
        echo "Network Settings" >>p1
        echo "Configure vsftpd service where secure ftp is permitted" >>p2
        echo "secure ftp is permitted" >>p3
        echo "yes" >>p4
        echo "IZ.1.5.9.24.4.1:IZ.1.5.9.24.4.2" >>p12


else
        echo "Network Settings" >>p1
        echo "Configure vsftpd service where secure ftp is permitted" >>p2
        echo "secure ftp is not permitted" >>p3
        echo "no" >>p4
        echo "IZ.1.5.9.24.4.1:IZ.1.5.9.24.4.2" >>p12


fi
else
        echo "Network Settings" >>p1
        echo "Configure vsftpd service where anonymous ftp is permitted." >>p2
        echo "/etc/vsftpd/vsftpd.conf file does not exist" >>p3
        echo "Yes" >>p4
        echo "IZ.1.5.9.24.4.1:IZ.1.5.9.24.4.2" >>p12


fi
else
        echo "Network Settings" >>p1
        echo "Configure vsftpd service where anonymous ftp is permitted." >>p2
        echo "vsftpd service is not enabled" >>p3
        echo "yes" >>p4
        echo "IZ.1.5.9.24.4.1:IZ.1.5.9.24.4.2" >>p12

fi


#IZ.1.5.9.25
rpm -qa | grep nfs-utils
if [ $? -eq 0 ];then
        if [ "$NFS_USE" == "no" ];then
                yum remove -y nfs-utils
                echo "Network Settingss" >>p1
                echo "Network file system (nfs) settings" >>p2
                echo "nfs-utils package removed" >> p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.25" >>p12
        else
                echo "Network Settingss" >>p1
                echo "Network file system (nfs) settings" >>p2
                echo "nfs-utils package is installed as per agreed value in techspec" >> p3
                echo "yes" >>p4
                echo "IZ.1.5.9.25" >>p12
        fi
else
        echo "Network Settingss" >>p1
        echo "Network file system (nfs) settings" >>p2
        echo "nfs-utils package is not installed" >> p3
        echo "yes" >>p4
        echo "IZ.1.5.9.25" >>p12

fi


#IZ.1.5.9.24.3
rpm -q vsftpd
if [ $? -eq 0 ] ; then
	if [ $(cat /etc/vsftpd/vsftpd.conf |grep ^anonymous_enable |awk -F"=" '{print $2}') == "YES" ];then
		sk=` cat /etc/vsftpd/vsftpd.conf | grep -v '^\s*#' |  grep 'userlist_deny'|awk -F= '{if($2=="NO") {print $2}'}`
		sk1=`cat /etc/vsftpd/vsftpd.conf | grep -v '^\s*#' | grep 'userlist_enable'|awk -F= '{if($2=="YES") {print $2}'}`
		sk2=`cat /etc/vsftpd/user_list| grep -v '^\s*#' |grep -w ftp`
		sk3=`cat /etc/vsftpd/user_list | grep -v '^\s*#' |grep -w anonymous`
			if [ "$sk" == "NO" ] && [ "$sk1" == "YES" ] && [ "$sk2" == "ftp" ] && [ "$sk3" == "anonymous" ]
			then
						echo "Network Settings" >>p1
						echo "Configure vsftpd service where anonymous ftp is permitted." >>p2
						echo "vsftpd service where anonymous ftp is permitted." >> p3
						echo "yes" >>p4
						echo "IZ.1.5.9.24.3" >>p12
			else
						sed -i 's/^userlist_deny=.*/userlist_deny=NO/g' /etc/vsftpd/vsftpd.conf
						sed -i 's/^userlist_enable=.*/userlist_enable=YES/g' /etc/vsftpd/vsftpd.conf
						echo "ftp" >/etc/vsftpd/user_list
						echo "anonymous" >>/etc/vsftpd/user_list
						echo "Network Settings" >>p1
						echo "Configure vsftpd service where anonymous ftp is permitted" >>p2
						echo "vsftpd service where anonymous ftp is not  permitted" >> p3
						echo "Modified" >>p4
						echo "IZ.1.5.9.24.3" >>p12
			fi
	else
		echo "Network Settings" >>p1
        echo "Configure vsftpd service where anonymous ftp is permitted" >>p2
        echo "anonymous ftp is disabled" >> p3
        echo "yes" >>p4
        echo "IZ.1.5.9.24.3" >>p12
	fi
else
        echo "Network Settings" >>p1
        echo "Configure vsftpd service where anonymous ftp is permitted" >>p2
        echo "vsftpd package not installed" >> p3
        echo "yes" >>p4
        echo "IZ.1.5.9.24.3" >>p12
fi

#IZ.1.5.9.26
for service in time-dgram time-stream
do
sk=`chkconfig --list 2>/dev/null |awk '{$1=$1};1' |grep ^$service |awk -F":" '{print $2}' |awk '{$1=$1};1'`
        if [ "$sk" == "on" ]
        then
                chkconfig time-dgram off
                chkconfig time-stream off
                echo "Network Settings" >>p1
                echo "Time network service" >>p2
                echo "$service setting is disabled in chkconfig" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.26" >>p12
        else
                echo "Network Settings" >>p1
                echo "Time network service" >>p2
                echo "$service setting is off in chkconfig" >>p3
                echo "yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.26" >>p12
        fi
done


#IZ.1.5.9.27 - updated
for service in tftp tftp.orig
do
sk=`chkconfig --list 2>/dev/null |awk '{$1=$1};1' |grep ^$service |awk -F":" '{print $2}' |awk '{$1=$1};1'`
        if [ "$sk" == "on" ]
        then
                chkconfig tftp off
                chkconfig tftp.orig off
                echo "Network Settings" >>p1
                echo "tftp service" >>p2
                echo "$service service is disabled in chkconfig" >>p3
                echo "IZ.1.5.9.27">>p12
                echo "Modified" >>p4

        else
                echo "Network Settings" >>p1
                echo "tftp service" >>p2
                echo "$service service is not enabled in chkconfig" >>p3
                echo "IZ.1.5.9.27">>p12
                echo "yes" >>p4

        fi
done

#IZ.1.5.9.28
rpm -qa |grep "xinetd"
if [ $? -eq 0 ]
then
for service in chargen-dgram chargen-stream daytime-dgram daytime-stream discard-dgram discard-stream echo-dgram echo-stream tcpmux-server time-dgram time-stream
do
        sk=`chkconfig --list 2>/dev/null |awk '{$1=$1};1' |grep ^$service |awk -F":" '{print $2}' |awk '{$1=$1};1'`
        if [ "$sk" == "off" ]
        then
                echo "Network Settings" >>p1
                echo "Ensure xinetd is not enabled" >>p2
                echo "Xinetd Service $service is disabled in chkconfig" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.28" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                chkconfig off $service
                echo "Network Settings" >>p1
                echo "Ensure xinetd is not enabled" >>p2
                echo "Xinetd Service $service is disabled in chkconfig" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.28" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
done
else
                echo "Network Settings" >>p1
                echo "Ensure xinetd is not enabled" >>p2
                echo "Xinetd package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.28" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.3
if [[ "$(rpm -q rusers-server)" != "package rusers-server is not installed" ]]
then
        systemctl is-enabled rstatd
        if [ $? -eq 0 ]
        then
                systemctl disable rstatd
                echo "Network Settings" >>p1
                echo "RSTATD" >>p2
                echo "RSTATD service is disabled" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.3" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                echo "Network Settings" >>p1
                echo "RSTATD" >>p2
                echo "RSTATD service is not enabled" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.3" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
else
                echo "Network Settings" >>p1
                echo "RSTATD" >>p2
                echo "rusers-server package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.3" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.4
if [[ "$(rpm -q tftp-server)" != "package tftp-server is not installed" ]]
then
        systemctl is-enabled tftp.socket
        if [ $? -eq 0 ]
        then
                systemctl disable tftp.socket
                echo "Network Settings" >>p1
                echo "TFTP" >>p2
                echo "tftp.socket is disabled" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.4" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                echo "Network Settings" >>p1
                echo "TFTP" >>p2
                echo "tftp.socket is not enabled" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.4" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
else
                echo "Network Settings" >>p1
                echo "TFTP" >>p2
                echo "tftp-server package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.4" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.6
if [[ "$(rpm -q rusers-server)" != "package rusers-server is not installed" ]]
then
        systemctl is-enabled rusersd
        if [ $? -eq 0 ]
        then
                systemctl disable rusersd
                echo "Network Settings" >>p1
                echo "RUSERSD" >>p2
                echo "rusersd service is disabled" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.6" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                echo "Network Settings" >>p1
                echo "RUSERSD" >>p2
                echo "rusersd service is not enabled" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.6" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
else
                echo "Network Settings" >>p1
                echo "RUSERSD" >>p2
                echo "rusers-server package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.6" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.10
if [[ "$(rpm -q finger-server)" != "package finger-server is not installed" ]]
then
        systemctl is-enabled finger
        if [ $? -eq 0 ]
        then
                systemctl disable finger
                echo "Network Settings" >>p1
                echo "FINGER" >>p2
                echo "finger service is disabled" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.10" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                echo "Network Settings" >>p1
                echo "FINGER" >>p2
                echo "finger service is not enabled" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.10" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
else
                echo "Network Settings" >>p1
                echo "FINGER" >>p2
                echo "finger-server-server package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.10" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.11
if [[ "$(rpm -q tcpspray)" != "package tcpspray is not installed" ]]
then
                yum remove -y tcpspray
                echo "Network Settings" >>p1
                echo "SPRAYD" >>p2
                echo "tcpspray package is removed" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.11" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
else
                echo "Network Settings" >>p1
                echo "SPRAYD" >>p2
                echo "tcpspray package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.11" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.12
if [[ "$(rpm -q pcfnsd)" != "package pcfnsd is not installed" ]]
then
                yum remove -y pcnfsd
                echo "Network Settings" >>p1
                echo "PCNFSD" >>p2
                echo "pcfnsd package is removed" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.12" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
else
                echo "Network Settings" >>p1
                echo "PCNFSD" >>p2
                echo "pcfnsd package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.12" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi

#IZ.1.5.9.14
if [[ "$(rpm -q rwho)" != "package rwho is not installed" ]]
then
        systemctl is-enabled rwhod
        if [ $? -eq 0 ]
        then
                systemctl disable rwhod
                echo "Network Settings" >>p1
                echo "RWHO" >>p2
                echo "rwhod service is disabled" >>p3
                echo "Modified" >>p4
                echo "IZ.1.5.9.14" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        else
                echo "Network Settings" >>p1
                echo "RWHO" >>p2
                echo "rwhod service is not enabled" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.14" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
        fi
else
                echo "Network Settings" >>p1
                echo "RWHO" >>p2
                echo "rwho package is not installed" >>p3
                echo "yes" >>p4
                echo "IZ.1.5.9.14" >>p12
                echo "$c" >>p5
                echo "$z" >>p6
fi


#IZ.1.5.9.29 - updated
systemctl is-enabled avahi-daemon
if [ $? -ne 0 ] ; then
        echo "Network Settings" >>p1
        echo "avahi service" >>p2
        echo "avahi service is not running" >>p3
        echo "IZ.1.5.9.29">>p12
        echo "yes" >>p4
else
        systemctl disable avahi-daemon
        echo "Network Settings" >>p1
        echo "avahi service" >>p2
        echo "avahi service is disabled" >>p3
        echo "IZ.1.5.9.29">>p12
        echo "Modified" >>p4
fi

#IZ.1.5.9.30
systemctl is-enabled slapd
if [ $? -ne 0 ]
then
        echo "Network Settings" >>p1
        echo "Ensure LDAP server is not enabled" >>p2
        echo "LDAP server daemon slapd is disabled" >>p3
        echo "yes" >>p4
        echo "$c" >>p5
        echo "$z" >>p6
        echo "IZ.1.5.9.30" >>p12
else
        if [ "$LDAP_USE" == "no" ];then
                systemctl disable slapd
        echo "Network Settings" >>p1
        echo "Ensure LDAP server is not enabled" >>p2
        echo "LDAP server daemon slapd is disabled" >>p3
        echo "Modified" >>p4
        echo "IZ.1.5.9.30" >>p12
        else
                echo "Network Settings" >>p1
        echo "Ensure LDAP server is not enabled" >>p2
        echo "LDAP server daemon is enabled. Please check for exception." >>p3
        echo "Manual_Check_Required" >>p4
        echo "IZ.1.5.9.30" >>p12
        fi
fi


#IZ.1.5.9.35 - updated
systemctl is-enabled cups
if [ $? -ne 0 ] ; then
        echo "Network Settings" >>p1
        echo "cups service" >>p2
        echo "cups service is not running" >>p3
        echo "IZ.1.5.9.35">>p12
        echo "yes" >>p4
else
        systemctl disable cups
        echo "Network Settings" >>p1
        echo "cups service" >>p2
        echo "cups service is disabled" >>p3
        echo "IZ.1.5.9.35">>p12
        echo "Modified" >>p4
fi

#IZ.1.5.9.39 - updated
systemctl is-enabled smb
if [ $? -ne 0 ] ; then
        echo "Network Settings" >>p1
        echo "samba service" >>p2
        echo "samba service is not running" >>p3
        echo "IZ.1.5.9.39">>p12
        echo "yes" >>p4
else
        if [ "$SAMBA_USE" == "no" ];then
                systemctl disable smb
                echo "Network Settings" >>p1
                echo "samba service" >>p2
                echo "samba service is disabled" >>p3
                echo "IZ.1.5.9.39">>p12
                echo "Modified" >>p4
        else
                echo "Network Settings" >>p1
                echo "samba service" >>p2
                echo "samba service is running. Please check for exception" >>p3
                echo "IZ.1.5.9.39">>p12
                echo "Manual_Check_Required" >>p4
        fi
fi

#IZ.1.5.12.4
if [ "$(rpm -q postfix)" == "package postfix is not installed" ] && [ "$(rpm -q sendmail)" == "package sendmail is not installed" ]
then
                echo "Network Settings" >>p1
                echo "Ensure mail transfer agent is configured for local-only mode" >>p2
                echo "Postfix or Sendmail is not installed " >>p3
                echo "yes" >>p4
                echo "IZ.1.5.12.4" >>p12
else

        if [ "$(grep '^[^#]*inet_interfaces' /etc/postfix/main.cf |awk '{print $2}')" == "loopback-only" ]
        then
                        echo "Network Settings" >>p1
                        echo "Ensure mail transfer agent is configured for local-only mode" >>p2
                        echo "MTA is not listening on any non-loopback address" >>p3
                        echo "yes" >>p4
                        echo "IZ.1.5.12.4" >>p12
        else
                        sed -i 's/^[^#]*inet_interfaces.*/inet_interfaces loopback-only/' /etc/postfix/main.cf
                        systemctl restart postfix
                        echo "Network Settings" >>p1
                        echo "Postfix or Sendmail" >>p2
                        echo "MTA is listening on loopback address" >>p3
                        echo "Modified" >>p4
                        echo "IZ.1.5.12.4" >>p12
        fi
fi


#IZ.1.5.9.39
rpm -qa | grep -i smb| wc -l
if [ $? -eq 0 ]
then
                echo "Network Settings" >>p1
                echo "Samba" >>p2
                echo "Samba is not installed " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.39" >>p12
        else
                echo "Network Settings" >>p1
                echo "Samba" >>p2
                echo "Samba is installed, Manual_Check_Required" >>p3
                echo "No" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.39" >>p12
fi





#IZ.1.5.12.4
str=$(rpm -qa | grep -i postfix| wc -l)
str1=$(rpm -qa | grep -i sendmail| wc -l)
if [ $str -eq 0 ] && [ $str1 -eq 0 ]
then
                echo "Network Settings" >>p1
                echo "Postfix or Sendmail" >>p2
                echo "Postfix or Sendmail is not installed " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.12.4" >>p12
        else
                echo "Network Settings" >>p1
                echo "Postfix or Sendmail" >>p2
                echo "Postfix or Sendmail is installed, Manual_Check_Required" >>p3
                echo "No" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.12.4" >>p12
fi





#IZ.1.5.9.32
str=$(rpm -qa | grep -i squid | wc -l)
if [ $str -eq 0 ]
then
                echo "Network Settings" >>p1
                echo "HTTP Proxy" >>p2
                echo "HTTP proxy is Disabled " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.32" >>p12
else
        if [ "$SQUID_PROXY_USE" == "no" ];then
                systemctl disable squid
                echo "Network Settings" >>p1
                echo "HTTP Proxy" >>p2
                echo "HTTP proxy squid is disabled" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.32" >>p12
        else
                echo "Network Settings" >>p1
                echo "HTTP Proxy" >>p2
                echo "HTTP proxy squid is enabled. Please check for exception" >>p3
                echo "Manual_Check_Required" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.32" >>p12
        fi
fi

#IZ.1.5.9.36 - updated
systemctl is-enabled dhcpd
if [ $? -ne 0 ] ; then
        echo "Network Settings" >>p1
        echo "dhcp service" >>p2
        echo "dhcp service is not running" >>p3
        echo "IZ.1.5.9.36">>p12
        echo "yes" >>p4
else
        systemctl disable dhcpd
        echo "Network Settings" >>p1
        echo "dhcp service" >>p2
        echo "dhcp service is disabled" >>p3
        echo "IZ.1.5.9.36">>p12
        echo "Modified" >>p4
fi




#IZ.1.5.9.31
systemctl is-enabled dovecot
if [ $? -ne 0 ]
then
                echo "Network Settings" >>p1
                echo "Ensure IMAP and POP3 server is not enabled" >>p2
                echo "IMAP and POP3 Service is Disabled " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.31" >>p12
        else
                systemctl disable dovecot
                echo "Network Settings" >>p1
                echo "IMAP and POP" >>p2
                echo "IMAP and POP3 Service dovecot is disabled" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.31" >>p12
fi


#IZ.1.5.9.32
systemctl is-enabled squid
if [ $? -ne 0 ]
then
                echo "Network Settings" >>p1
                echo "HTTP Proxy" >>p2
                echo "HTTP proxy is Disabled " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.32" >>p12
        else
                echo "Network Settings" >>p1
                echo "HTTP Proxy" >>p2
                echo "HTTP proxy is enabled" >>p3
                echo "No" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.32" >>p12
fi

#IZ.1.5.9.33
systemctl is-enabled ntalk
if [ $? -ne 0 ]
then
                echo "Network Settings" >>p1
                echo "Ensure talk server is not enabled" >>p2
                echo "ntalk server is disabled " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.33" >>p12
        else
                systemctl disable ntalk
                echo "Network Settings" >>p1
                echo "Ensure talk server is not enabled" >>p2
                echo "ntalk server is disabled" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.33" >>p12
fi

#IZ.1.5.9.34:Rsync Service
systemctl is-enabled rsyncd
if [ $? -eq 0 ]
then
                systemctl disable rsyncd
                echo "Network Settings" >>p1
                echo "Rsync" >>p2
                echo "Rsync is disabled" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.34" >>p12
else
                echo "Network Settings" >>p1
                echo "Rsync" >>p2
                echo "Rsync-is Disabled" >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.34" >>p12
fi

#IZ.1.5.9.38
systemctl is-enabled httpd
if [ $? -ne 0 ]
then
                echo "Network Settings" >>p1
                echo "HTTP" >>p2
                echo "HTTP service is not running " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.38" >>p12
        else
                if [ "$HTTP_USE" == "no" ];then
                        systemctl disable httpd
                        echo "Network Settings" >>p1
                        echo "HTTP" >>p2
                        echo "HTTP service is disabled" >>p3
                        echo "Modified" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                        echo "IZ.1.5.9.38" >>p12
                else
                        echo "Network Settings" >>p1
                        echo "HTTP" >>p2
                        echo "HTTP service is running. Please check exception" >>p3
                        echo "Manual_Check_Required" >>p4
                        echo "$c" >>p5
                        echo "$z" >>p6
                        echo "IZ.1.5.9.38" >>p12
                fi

fi

#IZ.1.5.9.41
rpm -q talk
if [ $? -ne 0 ]
then
                echo "Network Settings" >>p1
                echo "Talk" >>p2
                echo "Talk Package is not installed " >>p3
                echo "Yes" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.41" >>p12
        else
                yum remove -y talk
                echo "Network Settings" >>p1
                echo "Talk" >>p2
                echo "Talk Package is removed" >>p3
                echo "Modified" >>p4
                echo "$c" >>p5
                echo "$z" >>p6
                echo "IZ.1.5.9.41" >>p12
fi


#IZ.1.5.9.37 - updated
systemctl is-enabled named
if [ $? -ne 0 ] ; then
        echo "Network Settings" >>p1
        echo "dns service" >>p2
        echo "dns service is not running" >>p3
        echo "IZ.1.5.9.37">>p12
        echo "yes" >>p4
else
        if [ "$DNS_SERVER_USE" ] == [ "no" ];then
                systemctl disable named
                echo "Network Settings" >>p1
                echo "dns service" >>p2
                echo "dns service named is disabled" >>p3
                echo "IZ.1.5.9.37">>p12
                echo "Modified" >>p4
        else
                echo "Network Settings" >>p1
                echo "dns service" >>p2
                echo "dns service named is running. Please check for exception" >>p3
                echo "IZ.1.5.9.37">>p12
                echo "Manual_Check_Required" >>p4
        fi
fi

#IZ.1.5.9.23.1
rpm -q telnet-server
if [ $? -eq 0 ]
then
	if [ "$TELNET_SERVER_USE" == "no" ];then
		yum remove telnet-server -y
		echo "Network Settings" >>p1
		echo "Ensure telnet-server is not installed" >>p2
		echo "telnet-server package is installed" >>p3
		echo "Modified" >>p4
		echo "IZ.1.5.9.23.1" >>p12
	else
		echo "Network Settings" >>p1
		echo "Ensure telnet-server is not installed" >>p2
		echo "telnet-server package is required" >>p3
		echo "yes" >>p4
		echo "IZ.1.5.9.23.1" >>p12
	fi
else
		echo "Network Settings" >>p1
		echo "Ensure telnet-server is not installed" >>p2
		echo "telnet-server package is not installed" >>p3
		echo "yes" >>p4
		echo "IZ.1.5.9.23.1" >>p12
fi

#IZ.1.5.9.23.2
rpm -q telnet
if [ $? -eq 0 ]
then
	if [ "$TELNET_USE" == "no" ];then
		yum remove telnet -y
		echo "Network Settings" >>p1
		echo "Ensure telnet is not installed" >>p2
		echo "telnet package is installed" >>p3
		echo "Modified" >>p4
		echo "IZ.1.5.9.23.2" >>p12
	else
		echo "Network Settings" >>p1
		echo "Ensure telnet is not installed" >>p2
		echo "telnet package required" >>p3
		echo "yes" >>p4
		echo "IZ.1.5.9.23.2" >>p12
	fi
else
		echo "Network Settings" >>p1
		echo "Ensure telnet is not installed" >>p2
		echo "telnet package is not installed" >>p3
		echo "yes" >>p4
		echo "IZ.1.5.9.23.2" >>p12
fi
