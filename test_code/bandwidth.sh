bandwidth()
{
	apt install speedtest-cli
	bd=`speedtest-cli --share --server 4505
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
