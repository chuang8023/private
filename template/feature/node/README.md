# nginx配置

```
# 公共
location ~ ^/common {
    proxy_redirect off;
    proxy_set_header   Host   $host;
    proxy_set_header   X-Real-IP  $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   Accept-Encoding "gzip";
    proxy_pass http://nodepc;
}

# 应用中心
location ~ ^/appcenter(?!\/appsystem) {
    proxy_redirect off;
    proxy_set_header   Host   $host;
    proxy_set_header   X-Real-IP  $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   Accept-Encoding "gzip";
    proxy_pass http://nodepc;
}

## 通讯录
location ~ ^/organization(?!\/(contacts|manage)) {
    proxy_redirect off;
    proxy_set_header   Host   $host;
    proxy_set_header   X-Real-IP  $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   Accept-Encoding "gzip";
    proxy_pass http://nodepc;
}
```

# nginx白名单路由

* /appcenter 应用中心页面

* /appcenter/apps app列表

* /appcenter/setapp 新建app

* /appcenter/drag 拖拽应用

* /common/theme 切换主题

* /common/switchUser 切换用户

* /common/switchEnterprise 切换企业

* /common/clearOneHistory 删除一条搜索历史记录

* /common/clearAllHistory 删除所有搜索历史记录

* /common/addHistory 添加一条搜索历史记录/模块搜索

* /common/customer 客服接口
