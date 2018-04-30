testping()
{
	echo "{start testing $2 ping}" >> ${dir}/$logfilename
	ping -c 5 $1 | tee -a ${dir}/$logfilename
	echo -e "\n\n"
	echo "{end testing}" >> ${dir}/$logfilename
}

gotoping()
{
	echo "===開始測試跳板ping===">>${dir}/$logfilename
	next
	testping speedtest.tokyo.linode.com Linode日本
	testping hnd-jp-ping.vultr.com Vultr日本
	testping 192.157.214.6 Budgetvm洛杉磯
	testping downloadtest.kdatacenter.com kdatacenter韓國SK
	testping 210.92.18.1 星光韓國KT
	echo "===跳板ping測試結束===">>${dir}/$logfilename
}
