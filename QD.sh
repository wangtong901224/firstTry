#!/bin/bash
sckey='SCT227039T75JQ4c5X0Qew9RSmwuoMh6Zf'
cookie='koa:sess=eyJ1c2VySWQiOjQxNzE3NiwiX2V4cGlyZSI6MTc3NjMzMzgwNzkxOCwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=EABiYyhIbD50ea1iNWptarduLN4'
referer='https://glados.rocks/api/user/checkin'
origin='https://glados.rocks'
useragent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36'
authorization='12833298897138375142270069988788-864-1536'
echo '------------------sign------------------'
title=$(curl -H "cookie:$cookie" -H "referer:$referer" -H "origin:$origin" -H "user-agent:$useragent" -H "Authorization:$authorization" -H 'content-type:application/json;charset=UTF-8' -d '{"token": "glados.one"}' -X POST 'https://glados.one/api/user/checkin' | grep -Eo '"message":"[^"]*"')
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
