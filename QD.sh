#!/bin/bash
sckey='SCT227039T75JQ4c5X0Qew9RSmwuoMh6Zf'
cookie='koa:sess=eyJ1c2VySWQiOjQxNzE3NiwiX2V4cGlyZSI6MTcyMzM1NjgyMTY4MSwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=lHysRFZ5bDml4MwnvmcCxjfh3q8; _gid=GA1.2.1535417043.1697703952; Cookie=enabled; Cookie.sig=lbtpENsrE0x6riM8PFTvoh9nepc; _ga=GA1.1.1033166729.1693981759; _ga_CZFVKMNT9J=GS1.1.1697703951.3.1.1697705517.0.0.0'
referer='https://glados.one/console/checkin'
origin='https://glados.one'
useragent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36 Edg/98.0.1108.56'
echo '------------------sign------------------'
title=$(curl -H "cookie:$cookie" -H "referer:$referer" -H "origin:$origin" -H "user-agent:$useragent" -H 'content-type:application/json;charset=UTF-8' -d '{"token": "glados.one"}' -X POST 'https://glados.one/api/user/checkin' | grep -Eo '"message":"[^"]*"')
echo $title
title=$(echo ${title#*:} | sed 's/\"//g')
echo '-----------------status-----------------'
time=$(curl -H "cookie:$cookie" -H "referer:$referer" -H "origin:$origin" -H "user-agent:$useragent" -X GET 'https://glados.one/api/user/status' | grep -Eo '"leftDays":"[^"]*"')
echo $time
time=$(echo ${time#*:} | sed 's/\"//g')
time=${time%%.*}
param='{"text":"'$title'","desp":"Days Remaining '$time'"}'
echo $param
curl -X POST "https://sctapi.ftqq.com/$sckey.send" -H "Content-Type: application/json;charset=utf-8" -d "$param"