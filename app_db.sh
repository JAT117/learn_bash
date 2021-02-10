#!/bin/bash

#openstack server list --all --project cbam -c Name -Networks | grep "..-app.." > app_ip.txt

#| CAM195-app1                                                      | CAM_FE=192.168.2.5; CAM_OAM=10.52.249.104                      |
#| CAM195-app2                                                      | CAM_FE=192.168.2.6; CAM_OAM=10.52.249.105                      |

#openstack server list --all --project cbam -c Name -Networks | grep "..-db.."  > db_ip.txt


#| CAM195-db1                                                       | CAM_FE=192.168.2.7; CAM_OAM=10.52.249.106; CAM_BE=192.168.3.7 |
#| CAM195-db3                                                       | CAM_FE=192.168.2.9; CAM_OAM=10.52.249.108; CAM_BE=192.168.3.9 |
#| CAM195-db2                                                       | CAM_FE=192.168.2.8; CAM_OAM=10.52.249.107; CAM_BE=192.168.3.8 |


if [-f app_ip.txt]

sed 's//' app_ip.txt

while IFS= read line || [[- $line]]; do
  echo "$line"
done < app_ip.txt

$app1_ip =
$app2_ip =


for n in {1..2}
do
if [ $n -eq 1 ]; then
        echo "ssh -i <ssh key>.pem cam@<app1_ip>"
		app_check "$cam@$app1_ip"
elif [ $n -eq 2 ];then
        echo "ssh -i <ssh key>.pem cam@<app2_ip>"
		app_check "$cam@$app1_ip"
app_check() {
read SSHCBAM
$SSHCBAM  /bin/bash << EOF
	echo -e "systemctl status cam-reconfigure.service"
	#systemctl status cam-reconfigure.service

	echo -e "DNS Verification"
	#dig google.com

	echo -e "NTP Verification"
	#ntpq -pn

	echo -e "systemctl status cam-operability-distribution.service"
	#systemctl status cam-operability-distribution.service

	echo -e "sudo systemctl status cam-component-catalog.service"
	#sudo systemctl status cam-component-catalog.service

	echo -e "sudo systemctl status cam-component-alma.service"
	#sudo systemctl status cam-component-alma.service

	echo -e "sudo systemctl status cam-scheduler.service"
	#sudo systemctl status cam-scheduler.service

	echo -e "sudo systemctl status cps"
	#sudo systemctl status cps

	exit
EOF
}
if
fi
done

if [-f db_ip.txt]


$db1_ip =
$db2_ip =
$db3_ip =

for n in {1..3}
do

if [ $n -eq 1 ]; then
        echo "ssh -i <ssh key>.pem cam@<db1_ip>"
		db_check db1_ip
elif [ $n -eq 2 ];then
        echo "ssh -i <ssh key>.pem cam@<db2_ip>"
		db_check db1_ip
elif [ $n -eq 3 ];then
        echo "ssh -i <ssh key>.pem cam@<db3_ip>"
		db_check db1_ip

db_check(){
	read SSHCAM
$SSHCBAM  /bin/bash << EOF

echo -e "sudo systemctl status etcd"
#sudo systemctl status etcd

echo -e "sudo systemctl status mariadb"
#sudo systemctl status mariadb

echo -e "sudo systemctl status mongod"
#sudo systemctl status mongod

echo -e "sudo systemctl status rabbitmq-server"
#sudo systemctl status rabbitmq-server

exit
EOF
}

fi
fi
done
