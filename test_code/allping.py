#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import re
import json
import sys, getopt
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')

opts, args = getopt.getopt(sys.argv[1:], "l:i:")
logfilename="91yuntest.log"
ip=''
for op, value in opts:
	if op == "-l":
		logfilename=value
	elif op == "-i":
		ip=value

def getip(iphtml):
	searchip=re.search("<a [^>]*>([^<]*)</a>",iphtml)
	if searchip:
		return searchip.group(1)
	else:
		return iphtml



def allping(gethtml):
	f="===all ping start===\n"
	f=f+"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s"%("id","ping的地點","IP","IP所在地","丟包率","MIX","MAX","延遲","TTL")+"\n"
	result=re.finditer(r"<script>parent\.call_ping\(([^<]*)\);<\/script>",gethtml)
	for r in result:
		js=json.loads(r.group(1))
		f=f+"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s"%(js["id"],js["name"],js["ip"],js["ip_area"],js["loss"],js["rtt_min"],js["rtt_max"],js["rtt_avg"],js["ttl"])+"\n"

	f=f+"===all ping end===\n\n"
	return f

def showping(gethtml):
	f="===ping show===\n"
	f=f+"%s\t%s\t%s\t%s\t%s\t%s\t%s\n"%("線路","節點數目","最快節點","延遲","最慢節點","延遲","平均延遲")+"\n"
	print("%-10s%-24s\t%-10s%-24s\t%-10s%-10s\n"%("線路","最快節點","延遲","最慢節點","延遲","平均延遲"))
	result=re.finditer(r"<script>parent\.summary_ping\(([^<]*)\)<\/script>",gethtml)
	for r in result:
		js=json.loads(r.group(1))
		for key in js:
			f=f+"%s\t%s\t%s\t%sms\t%s\t%sms\t%sms"%(key,js[key]["count"],js[key]["min_name"],js[key]["min_speed"],js[key]["max_name"],js[key]["max_speed"],js[key]["avg"])+"\n"
			print("%-10s%-24s\t%-10s%-24s\t%-10s%-10s\n"%(key.encode('utf-8'),js[key]["min_name"].encode('utf-8'),js[key]["min_speed"].encode('utf-8'),js[key]["max_name"].encode('utf-8'),js[key]["max_speed"].encode('utf-8'),js[key]["avg"].encode('utf-8')))
			
	f=f+"===ping show end===\n\n"
	return f






text=requests.get("http://www.ipip.net/ping.php?a=send&host="+ip+"&area=china",verify=False)
content=text.text
c="===開始進行全國PING測試===\n"
c=c+allping(content)
c=c+showping(content)
c=c+"===進行全國PING測試結束===\n"
with open(logfilename,"a+") as file:
	file.write(c)



