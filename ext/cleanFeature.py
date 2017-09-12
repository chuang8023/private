#!/usr/bin/env python
# -*- coding: utf-8 -*-

import urllib2, cookielib, json, os, time

projInfoPath = '/root/scripts/rundeck/config/projinfo'
featureWhiteList = '/root/scripts/rundeck/config/featureWhiteList'

loginUrl = 'https://safirst.coding.net/api/v2/account/login'
#mrUrl = 'https://safirst.coding.net/api/user/Safirst/project/qycloud/git/merges?status=open&creator=&merger=&reviewer=&sort=updated_at&label=&q=&page=1'
mrUrl = 'https://safirst.coding.net/api/user/Safirst/project/qycloud/git/merges?status=open'
data = 'account=18013905342%40163.com&password=a8b5af7ca8e727ae402f07ca9d4f63f9964f0abd&remember_me=false&j_captcha='
try:
    opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookielib.CookieJar()))
    opener.addheaders = [('User-Agent', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 UBrowser/5.6.10551.6 Safari/537.36')]
    opener.open(loginUrl, data)
    op = opener.open(mrUrl)
    data = json.loads(op.read())
    opener.close()

    check = data['data']['list'][0]['srcBranch']
except:
    with open(logPath, 'a') as f:
        f.write(time.strftime("%Y/%m/%d/%H:%M:%S", time.gmtime())+ ' - [Error] - Cannot get branch list !'+ '\n')
else:
    try:
        featureList = []
        deployFeature = []
        whiteList = []

        for i in data['data']['list']:
            featureList.append(unicode.encode(i['srcBranch']))

        for line in open(projInfoPath):
            deployFeature.append(str(line).split('|')[0])

        for line in open(featureWhiteList):
            whiteList.append(line.strip('\n'))

        needClean = list(set(deployFeature).difference(set(featureList)).difference(set(whiteList)))
    except:
        with open(logPath, 'a') as f:
            f.write(time.strftime("%Y/%m/%d/%H:%M:%S", time.gmtime())+ ' - [Error] - Cannot get branch information !'+ '\n')
    else:
        for i in needClean:
            os.system('/root/scripts/rundeck/ext/deployBranch_feature.sh delete '+ i)

