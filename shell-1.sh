#!/bin/bash
ps_out=`ps -ef | grep $1 | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "$1")
if [[ "$result" != "" ]];then
    echo "Running"
else
    echo "Not Running"
fi

# crontab -e
# 0 04,12,21 * * * /bin/bash /home/mysh/monitorprocess.sh
# 每天晚上4点，中午12点,晚上21点检测
# 0 4,12 * * * 
# 分 时 日 月 周


#!/bin/sh
ps -fe|grep processString |grep -v grep
if [ $? -ne 0 ]
then
echo "start process....."
else
echo "runing....."
fi
#####
# processString 表示进程特征字符串，能够查询到唯一进程的特征字符串
# 0表示存在的
# $? -ne 0 不存在，$? -eq 0 存在

crontab -el

	#statements

#!/bin/sh
while true;do
    count=`ps -ef|grep http|grep -v grep`
    if [ "$?" != "0" ];then
		echo    ">>>>no httpd,run it"
		service httpd start
		else
		echo ">>>>httpd is runing..."
	fi
	sleep 5
done



#!/bin/bash
date=`date +%Y%m%d_%-H:%-M:%S`
while :
do
    sleep 30
    pid=`ps -ef|grep apache-tomcat-6.0.35|grep -v grep|awk '{print $2}'`
    if [ -z "$pid" ];
    then    
        /tomcat/apache-tomcat-6.0.35/bin/startup.sh &
        echo "$date 未检测到tomcat进程,现在启动tomcat..." >>log.txt 
    fi
done
