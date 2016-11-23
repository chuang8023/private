<?php
return array(
    // 数据库连接取第一个key下配置
    'servers'  => array(
        'default' => array(
            'name'     => 'localhost',
            'host'     => '127.0.0.1',
            'port'     => 3306,
            'dbname'   => 'templateRelease',
            'user'     => 'saas_kawawa',
            'password' => 'hVxsR7VFYRKZsbNJ'
        ),
	 'mongodb' => array(
            'name'     => 'localhost',
            'host'     => 'localhost',
            'port'     => 27017,
            'dbname'   => 'templateRelease',
            'user'     => 'feature',
            'password' => 'LBc8SQaA8zoJK1IWMUHDiSwN4'
        ),
    ),
    'charset' => 'utf8',
    'default' => 'default', //默认数据库
    'master_slave_enable' => false,
    'table_preg' => "/`?(ent_\w+|sys_\w+)[`?|\s?]/iU", // 考虑没有加``符号的sql
    'model_path' => MODPATH.'dao'
);
