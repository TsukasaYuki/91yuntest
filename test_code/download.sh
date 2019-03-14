speed_test() {
    speedtest=$(wget -4O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    ipaddress=$(ping -c1 -n `awk -F'/' '{print $3}' <<< $1` | awk -F'[()]' '{print $2;exit}')
    nodeName=$2
    if   [ "${#nodeName}" -lt "8" ]; then
        echo -e "$2\t\t\t\t$ipaddress\t\t$speedtest" | tee -a ${dir}/$logfilename
    elif [ "${#nodeName}" -lt "13" ]; then
        echo -e "$2\t\t\t$ipaddress\t\t$speedtest" | tee -a ${dir}/$logfilename
    elif [ "${#nodeName}" -lt "24" ]; then
        echo -e "$2\t\t$ipaddress\t\t$speedtest" | tee -a ${dir}/$logfilename
    elif [ "${#nodeName}" -ge "24" ]; then
        echo -e "$2\t$ipaddress\t\t$speedtest" | tee -a ${dir}/$logfilename
    fi
}
download()
{
	echo "===開始測試下載速度===">>${dir}/$logfilename
	next
	echo "===star ipv4 download===">>${dir}/$logfilename
	echo -e "Node Name\t\t\tIPv4 address\t\tDownload Speed" | tee -a ${dir}/$logfilename
    speed_test 'http://cachefly.cachefly.net/10mb.test' 'CacheFly'
    speed_test 'http://speedtest.dal05.softlayer.com/downloads/test10.zip' 'Softlayer, Dallas, TX'
    speed_test 'http://speedtest.sea01.softlayer.com/downloads/test10.zip' 'Softlayer, Seattle, WA'
    speed_test 'http://speedtest.fra02.softlayer.com/downloads/test10.zip' 'Softlayer, Frankfurt, DE'
    speed_test 'http://speedtest.sng01.softlayer.com/downloads/test10.zip' 'Softlayer, Singapore, SG'
    speed_test 'http://speedtest.hkg02.softlayer.com/downloads/test10.zip' 'Softlayer, HongKong, CN'
    speed_test 'http://speedtest-nyc1.digitalocean.com/10mb.test' 'DigitalOcean, New York, US'
    speed_test 'http://speedtest-ams2.digitalocean.com/10mb.test' 'DigitalOcean, Amsterdam, NL'
    speed_test 'http://speedtest-sfo1.digitalocean.com/10mb.test' 'DigitalOcean, San Francisco, CA'
    speed_test 'http://speedtest-sgp1.digitalocean.com/10mb.test' 'DigitalOcean, Singapore, SG'
    speed_test 'http://speedtest-lon1.digitalocean.com/10mb.test' 'DigitalOcean, London, UK'
    speed_test 'http://speedtest-fra1.digitalocean.com/10mb.test' 'DigitalOcean, Frankfurt, DE'
    speed_test 'http://speedtest-tor1.digitalocean.com/10mb.test' 'DigitalOcean, Toronto, Canada'
    speed_test 'http://speedtest-blr1.digitalocean.com/10mb.test' 'DigitalOcean, Tamil Nadu, IN'
    speed_test 'http://http.speed.hinet.net/test_010m.zip' 'HiNET, Taiwan            '
    speed_test 'http://speed.anet.net.tw/10M.zip' 'Taiwan Fixed Network, Taiwan'
    speed_test 'http://speed.vee.com.tw/10mb.bin' 'VeeTIME Corp, Taiwan'
	echo -e "===end ipv4 download===\n\n">>${dir}/$logfilename
}
