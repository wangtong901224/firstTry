#!/bin/bash
sckey='SCT227039T75JQ4c5X0Qew9RSmwuoMh6Zf'
cookie='_ga=GA1.2.79981967.1711701586; _ga_CZFVKMNT9J=GS1.1.1716166742.3.1.1716166757.0.0.0; koa:sess=eyJ1c2VySWQiOjQxNzE3NiwiX2V4cGlyZSI6MTc0OTYwODg3ODQzMCwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=ZFADJzoxNxDhGJoQVreRyo0YYGU'
referer='https://glados.rocks/api/user/checkin'
origin='https://glados.rocks'
useragent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36'
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
