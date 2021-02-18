if [-f app_ip.txt];then

app1_ip=`sed  -n '/app1/p' app.txt | grep -Po 'CAM_OAM=\K[^ ]+' | tr -d ';'` 
app2_ip=`sed  -n '/app2/p' dpp.txt | grep -Po 'CAM_OAM=\K[^ ]+' | tr -d ';'`

app1="ssh -i CAM195_key.pem cam@"$app2_ip
app2="ssh -i CAM195_key.pem cam@"$app2_ip


for n in {1..2}
do
if [ $n -eq 1 ]; then
        echo "ssh -i <ssh key>.pem cbam@<app1_ip>"
		app_check $app1
elif [ $n -eq 2 ];then
        echo "ssh -i <ssh key>.pem cbam@<app2_ip>"
		app_check $app2
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
fi
fi
done
