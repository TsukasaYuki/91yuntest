bandwidth()
{
	#獲得相關數據
	wget --no-check-certificate https://raw.githubusercontent.com/91yun/speedtest-cli/master/speedtest_cli.py 1>/dev/null 2>&1
	bd=`python speedtest_cli.py --share`
	#apt install speedtest-cli
	#bd=`speedtest-cli --server 12990 --share`
        #bd=`speedtest-cli --share --server 18445`
        #bd=`speedtest-cli --share --server 4505`
        #bd=`speedtest-cli --share --server 8099`
        #bd=`speedtest-cli --share`
        download=`echo "$bd" | awk -F ':' '/Download/{print $2}'`
        upload=`echo "$bd" | awk -F ':' '/Upload/{print $2}'`
        hostby=`echo "$bd" | grep 'Hosted'`
        rm -rf speedtest.py

	#顯示在屏幕上
	next
	echo "$hostby"
	echo "下載   : $download"
	echo "上傳   : $upload"


	#寫入日誌文件
	echo "===開始測試頻寬===">>${dir}/$logfilename
	echo "$bd">>${dir}/$logfilename
	echo -e "===頻寬測試結束==\n\n">>${dir}/$logfilename
}
