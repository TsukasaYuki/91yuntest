bandwidth()
{
	#獲得相關數據
	apt install speedtest-cli
	#wget --no-check-certificate https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 1>/dev/null 2>&1
        #bd=`python speedtest.py --share --server 7456`
        bd=`speedtest-cli --share --server 7456`
        download=`echo "$bd" | awk -F ':' '/Download/{print $2}'`
        upload=`echo "$bd" | awk -F ':' '/Upload/{print $2}'`
        hostby=`echo "$bd" | grep 'Hosted'`
        rm -rf speedtest.py

	#顯示在屏幕上
	next
	echo "$hostby"
	echo "上傳   : $download"
	echo "下載   : $upload"


	#寫入日誌文件
	echo "===開始測試帶寬===">>${dir}/$logfilename
	echo "$bd">>${dir}/$logfilename
	echo -e "===帶寬測試結束==\n\n">>${dir}/$logfilename
}
