#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo $(Color_Text "$1" "31")
}

Echo_Green()
{
  echo $(Color_Text "$1" "32")
}

Echo_Yellow()
{
  echo -n $(Color_Text "$1" "33")
}

Echo_Blue()
{
  echo $(Color_Text "$1" "34")
}

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}


echo "伺服器供應商（host provider）[default:Enter]"
read hostp
echo "開始測試中，會需要點時間，請稍後"


_included_benchmarks=""
upfile="y"


#取參數
while getopts "i:u" opt; do
    case $opt in
        i) _included_benchmarks=$OPTARG;;
		u) upfile="n";;
    esac
done

#預設參數
if [ "$_included_benchmarks" == "" ]; then
	_included_benchmarks="io,bandwidth,download,traceroute,backtraceroute,allping"
fi

_included_benchmarks="systeminfo,"${_included_benchmarks}

#預先安裝依賴，如果有進行benchtest就會多安裝些東西
bt="benchtest"
if [[ $_included_benchmarks == *$bt* ]]
then
    apt-get >/dev/null 2>&1
	[ $? -le '1' ] && ( apt-get update | apt-get -y install curl mtr-tiny virt-what python python-pip perl automake autoconf time make gcc gdb )
	yum >/dev/null 2>&1
	[ $? -le '1' ] && yum -y install which epel-release sed curl mtr virt-what python python-pip make gcc gcc-c++ gdbautomake autoconf time perl-Time-HiRes perl
else
    apt-get >/dev/null 2>&1
	[ $? -le '1' ] && ( apt-get update | apt-get -y install curl mtr-tiny virt-what python python-pip )
	yum >/dev/null 2>&1
	[ $? -le '1' ] && yum -y install which epel-release sed curl mtr virt-what python python-pip
fi
pip install requests

#要用到的變數
backtime=`date +%Y%m%d`
logfilename="91yuntest.log"
dir=`pwd`
IP=$(curl -s myip.ipip.net | awk -F ' ' '{print $2}' | awk -F '：' '{print $2}')
echo "====開始紀錄測試資訊====">${dir}/$logfilename

#建立測試資料夾
mkdir -p 91yuntest
cd 91yuntest

clear

#取得測試的參數值
arr=(${_included_benchmarks//,/ })    

#下載執行對應的代碼
for i in ${arr[@]}    
do 
	wget -q --no-check-certificate https://raw.githubusercontent.com/91yun/91yuntest/master/test_code/${i}.sh
    . ${dir}/91yuntest/${i}.sh
	eval ${i}
done    


#上传文件
updatefile()
{
	resultstr=$(curl -s -T ${dir}/$logfilename "http://logfileupload.91yuntest.com/logfileupload.php")
	echo -e $resultstr | tee -a ${dir}/$logfilename
}

if [[ $upfile == "y" ]]
then
	updatefile
else
	echo "測試結束，詳細日誌請查看 91yuntest.log"
fi
#刪除資料夾
rm -rf ${dir}/91yuntest
