mtrback(){
	echo "===測試 [$2] 的回程路由===" | tee -a ${dir}/$logfilename
	mtr -r -c 10 $1 | tee -a ${dir}/$logfilename
	echo -e "\n\n"
	echo -e "===回程 [$2] 路由測試結束===\n\n" >> ${dir}/$logfilename

}

backtraceroute()
{
	next
	mtrback "14.215.116.1" "廣州電信（天翼雲）"
	mtrback "101.227.255.45" "上海電信（天翼雲）"
	mtrback "117.28.254.129" "廈門電信CN2"
	mtrback "113.207.32.65" "重慶聯通"
	mtrback "183.192.160.3" "上海移動"
        mtrback "220.133.25.1" "HiNET中華電信(家寬)"
        mtrback "60.199.206.249" "Taiwan Fixed Network 台灣固網"
	mtrback "61.20.36.131" "SeedNet 遠傳大寬頻"
	mtrback "219.84.215.125" "So-net"
	mtrback "203.217.97.21" "VeeTIME大台中數位有線"
	mtrback "163.24.238.5" "屏東縣教育網路中心"
	mtrback "203.72.153.100" "新北市教育網路中心"
}
