#!/bin/bash
#纳新测试
OLD_IFS=$IFS
Result=0
CHANGE_ROOT=/home/last/.entrance/linux_root
ROOT=/

#########################################
# 1st question.
Test_String=$( tail -1 $CHANGE_ROOT/etc/inittab |cut -d ':' -f 2 )
if [ "$Test_String" == "5" ];then
		echo "Question 1 is right."
	else
		echo "Question 1 is false."
		Result=1
fi

#########################################
# 2nd question.
for Test_String in $( cat $CHANGE_ROOT/etc/resolv.conf | grep nameserver | cut -d ' ' -f 2 )
do
	if [ "$Test_String" == "202.117.128.2" ];then
		Que2_Result=0
		break
	else
		Que2_Result=1
	fi
done
if [ "$Que2_Result" == "0" ];then
	echo "Question 2 is right"
else
	echo "Question 2 is false"
	Result=1
fi

#########################################
# 3rd question.
Test_String=$( cat $CHANGE_ROOT/etc/passwd |grep last )
if [ "$Test_String" == "last:x:502:502::/home/last:/bin/bash" ];then
	echo "Question 3 is right"
else
	echo "Questiong 3 is false"
	Result=1
fi

#########################################
# 4th question
#check the /etc/passwd file
Test_String=$( cat $CHANGE_ROOT/etc/passwd |grep lili )
if [ "$Test_String" == "lili:x:6000:6000::/home/lili:/bin/bash" ];then
		Que4_Result=0
else
		Que4_Result=1
fi

#check the /etc/shadow file
cat $CHANGE_ROOT/etc/shadow |grep lili
if [ "$?" == "0" ];then
		Que4_Result=0
else
		Que4_Result=1
fi

Test_String=$( cat $CHANGE_ROOT/etc/shadow |grep lili | awk -F':' '{print NF-1}' )
if [ "$Test_String" == "8" ];then
		Que4_Result=0
else
		Que4_Result=1
fi

#check the /etc/group file
Test_String=$( cat $CHANGE_ROOT/etc/group |grep lili | cut -c 1-12 )
if [ "$Test_String" == "lili:x:6000:" ];then
                Que4_Result=0
else
                Que4_Result=1
fi      
cat $CHANGE_ROOT/etc/group |grep lili |grep root |grep last
if [ "$?" == "0" ];then
                Que4_Result=0
		
else
                Que4_Result=1
fi

#print information
if [ "$Que4_Result" == 0 ];then
	echo "Question 4 is right"
else
	echo "Question 4 is false"
	Result=1
fi

#########################################
# 5th question
if [ "$( cat $CHANGE_ROOT/proc/sys/net/ipv4/icmp_echo_ignore_all )" == "1" ];then
                Que5_Result=0
else
                Que5_Result=1
fi

if [ "$( cat $CHANGE_ROOT/etc/sysctl.conf |grep net.ipv4.icmp_echo_ignore_all |cut -d ' ' -f 3 )" == "1" ];then
                Que5_Result=0
else
                Que5_Result=1
fi


#print information
if [ "$Que5_Result" == 0 ];then
	echo "Question 5 is right"
else
	echo "Question 5 is false"
	Result=1
fi

#########################################
# 6th question
if [ "$( cat $CHANGE_ROOT/etc/fstab | grep "rhel-server-6.3-x86_64.iso" | cut -f 1 )" == "$CHANGE_ROOT/home/last/rhel-server-6.3-x86_64.iso" ] && [ "$( cat $CHANGE_ROOT/etc/fstab | grep "rhel-server-6.3-x86_64.iso" | cut -f 3 | cut -d ' ' -f 1-2 )" == "iso9660 loop" ];then
	echo "Question 6 is right"
else
	echo "Question 6 is false"
	Result=1
fi

#########################################
# 7th question
if [ "$( cat $CHANGE_ROOT/boot/grub/grub.conf |grep default |cut -d '=' -f 2 )" == "1" ];then
	echo "Question 7 is right"
else
	echo "Question 7 is false"
	Result=1
fi
