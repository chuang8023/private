<?php

return [

    'application_name' => 'AYSaaS-templateRelease',

    'sys_name' => '安元科技',

    'is_debug' => false,

    'is_accrual' => true,

    'skip_identity' => true,

    'root_domain' => 'feature.templateRelease.aysaas.com:TWebPort1',

    'www_domain' => 'www.feature.templateRelease.aysaas.com:TWebPort1',

    'static_domain' => 'static.feature.templateRelease.aysaas.com:TWebPort2',

    'fileio_domain' => 'fileio.feature.templateRelease.aysaas.com:TWebPort3',

    'update_domain' => 'update.master.aysaas.com:7777',

    'socket_domain' => 'ws://www.master.aysaas.com:3232',

    'preview_domain' => 'dp.qycloud.com.cn/op/view.aspx?src=',//https://view.officeapps.live.com/op/view.aspx?src=

    'resque_sync' => false,

    'is_notice' => true,

    'notice_email' => [
        '1125851000@qq.com' // 因邮件发送问题，队列提醒暂不起作用
    ],

    'is_solor' => true,

    'resque_timeout' => 240, //队列超时提醒时间

    'useGa' => false, //是否启用GoogleAnalytics

    'useBw' => false, //是否启用服务器监控

    'gaAccount' => '', //GoogleAnalytics跟踪帐号(测试可以用：UA-54849734-1)

    'menu_obj' => [
        '/api/message/menu' => '站内短信',
        '/api/store/menu' => '文档管理'
    ],


    'errorLog'  => true,

    'errorReport' => false,

    'migration_init_version' => '20120822094445', //初始化版本

    'migration_initdata_version' => '20120822110225', //初始化数据版本

    'migration_limit_version' => '', //从这个版本开始

    'migration_checkTplTable' => true,    //是否检查企业与模版表的差异

    'open_menu_permission' => true, //是否开启新版菜单权限配置功能

    'open_admin_config' => true, //config模块管理员工具

    'is_project' => false,

    'is_check' => true,

    'useSSL' => false, //是否启用ssl认证

    'is_chat_onLine' => false,   //是否开启启聊线上环境

    'arrearage_disable' => true, //欠费企业是否停用

    'is_gis' => false, //是否开启GIS服务

    'gisUrl' => 'http://10.0.0.189:8080/AYKJ.GISDevelop/AYKJ.GISDevelopTestPage.html',

    'is_socket' => false, //是否开启websocket

    'is_socket_debug' => false,

    'is_badjs' => false, //是否开启badjs上报

    'baidu_mapkey' => 'cMURp5Iy4EFGdGslu4VofGsVUj6zyZ2j',

];
