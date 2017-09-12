<?php
return array(
    // 数据库连接取第一个key下配置
    'servers'  => array(
        'default' => array(
            'name'     => 'localhost',
            'host'     => '127.0.0.1',
            'port'     => 3306,
            'dbname'   => 'master',
            'user'     => 'master',
            'password' => 'pZdxysqJX4bK4VrB'
        ),
	'sysdb' => [
            'name' => 'localhost',
            'host' => '127.0.0.1',
            'port' => 3306,
            'dbname'   => 'master',
            'user'     => 'master',
            'password' => 'pZdxysqJX4bK4VrB'
        ],
	 'mongodb' => array(
            'name'     => 'localhost',
            'host'     => 'localhost',
            'port'     => 27017,
            'dbname'   => 'master',
            'user'     => 'master',
            'password' => 'L9jD7srDBdS7Nfob'
        ),
    ),
    'charset' => 'utf8',
    'default' => 'default', //默认数据库
    'split_enable' => true,
    'master_slave_enable' => false,
    'table_preg' => "/`?(ent_\w+|sys_\w+)[`?|\s?]/iU", // 考虑没有加``符号的sql
    'model_path' => MODPATH.'dao'
);
