<?php
return array(
    // 数据库连接取第一个key下配置
    'servers'  => array(
        'default' => array(
            'name'     => 'localhost',
            'host'     => 'MysqlHost',
            'port'     => 3306,
            'dbname'   => 'templateRelease',
            'user'     => 'MysqlUser',
            'password' => 'MysqlPass'
        ),
	 'mongodb' => array(
            'name'     => 'localhost',
            'host'     => 'MongoHost',
            'port'     => 27017,
            'dbname'   => 'templateRelease',
            'user'     => 'MongoUser',
            'password' => 'MongoPass'
        ),
    ),
    'charset' => 'utf8',
    'default' => 'default', //默认数据库
    'master_slave_enable' => false,
    'table_preg' => "/`?(ent_\w+|sys_\w+)[`?|\s?]/iU", // 考虑没有加``符号的sql
    'model_path' => MODPATH.'dao'
);
