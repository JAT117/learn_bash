#!/bin/bash

#openstack server list --all --project cbam -c Name -Networks | grep "..-app.." > app_ip.txt

#| CBAM195-app1                                                      | CBAM_FE=192.168.2.5; CBAM_OAM=10.52.249.104                      |
#| CBAM195-app2                                                      | CBAM_FE=192.168.2.6; CBAM_OAM=10.52.249.105                      |

#openstack server list --all --project cbam -c Name -Networks | grep "..-db.."  > db_ip.txt


#| CBAM195-db1                                                       | CBAM_FE=192.168.2.7; CBAM_OAM=10.52.249.106; CBAM_BE=192.168.3.7 |
#| CBAM195-db3                                                       | CBAM_FE=192.168.2.9; CBAM_OAM=10.52.249.108; CBAM_BE=192.168.3.9 |
#| CBAM195-db2                                                       | CBAM_FE=192.168.2.8; CBAM_OAM=10.52.249.107; CBAM_BE=192.168.3.8 |


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
        echo "ssh -i <ssh key>.pem cbam@<app1_ip>"
		app_check "$cbam@$app1_ip"
elif [ $n -eq 2 ];then
        echo "ssh -i <ssh key>.pem cbam@<app2_ip>"
		app_check "$cbam@$app1_ip"
app_check() {
read SSHCBAM
$SSHCBAM  /bin/bash << EOF
	echo -e "systemctl status cbam-reconfigure.service"
	#systemctl status cbam-reconfigure.service

	echo -e "DNS Verification"
	#dig google.com

	echo -e "NTP Verification"
	#ntpq -pn

	echo -e "systemctl status cbam-operability-distribution.service"
	#systemctl status cbam-operability-distribution.service

	echo -e "sudo systemctl status cbam-component-catalog.service"
	#sudo systemctl status cbam-component-catalog.service

	echo -e "sudo systemctl status cbam-component-alma.service"
	#sudo systemctl status cbam-component-alma.service

	echo -e "sudo systemctl status cbam-scheduler.service"
	#sudo systemctl status cbam-scheduler.service

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
        echo "ssh -i <ssh key>.pem cbam@<db1_ip>"
		db_check db1_ip
elif [ $n -eq 2 ];then
        echo "ssh -i <ssh key>.pem cbam@<db2_ip>"
		db_check db1_ip
elif [ $n -eq 3 ];then
        echo "ssh -i <ssh key>.pem cbam@<db3_ip>"
		db_check db1_ip

db_check(){
	read SSHCBAM
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
