<?php

require __DIR__ . '/aliyunAPI.php';

/*
 * API密钥、URL地址、主实例ID
 */
 $key = 'e7QcE1SfNze9eAuC';
 $secret = 'o8CLhEK6k3iyrjYPmL3TlTBBtK3I9y';
 $dbId = 'rds26h77108r3o8c4jwj';
 $host = 'https://rds.aliyuncs.com/';
 
 /*
  * RDS API文档地址 https://help.aliyun.com/document_detail/rds/OpenAPI-manual/RDS-OpenAPI-Invoke/rquest-structure.html?spm=5176.product8314883_rds.6.213.0gvWN2
  * 
  * 查看RDS实例详情
  * 请求参数:
  * 'Action' => 'DescribeDBInstanceAttribute';
  * 'DBInstanceId' => 'rds26h77108r3o8c4jwj';
  * 返回参数:
  * ExpireTime  //到期时间(需要+8小时才是北京时间),$obj['Items']['DBInstanceAttribute']['0']['ExpireTime']
  * TempDBInstanceId    //临时实例ID(如果存在临时实例),$obj['Items']['DBInstanceAttribute']['0']['TempDBInstanceId']
  * 
  * 创建临时实例
  * 请求参数:
  * 'Action' => 'CreateTempDBInstance';
  * 'DBInstanceId' => 'rds26h77108r3o8c4jwj';
  * 'BackupId' => '111044758';
  * 'RestoreTime' => '2011-06-11T16:00:00Z';
  * 返回参数:
  * TempDBInstanceId    //临时实例ID
  * 
  * 删除实例
  * 请求参数:
  * 'Action' => 'DeleteDBInstance';
  * 'DBInstanceId' => 'rds26h77108r3o8c4jwj';
  * 返回参数:
  * 无
  * 
  * 查看RDS备份列表
  * 请求参数:
  * 'Action' => 'DescribeBackups';
  * 'DBInstanceId' => 'rds26h77108r3o8c4jwj';
  * 'StartTime' => '2011-06-11T15:00Z';
  * 'EndTime' => '2011-06-11T15:00Z';
  * 返回参数:
  * BackupStatus    //备份状态:Success：完成备份；Failed：备份失败
  * BackupId    //备份ID
  */
 
function DescribeDBInstanceAttribute ($key, $secret, $host, $dbId, $format='JSON') {
    $getDBId = AliyunAPI(                                                    //调用AliyunAPI.php的AliyunAPI函数
    $key,
    $secret,
    $host,
    $format,
    array(
        'Action' => 'DescribeDBInstanceAttribute',
        'DBInstanceId' => $dbId,
    )
    );
    return $getDBId;
}

function DeleteDBInstance ($key, $secret, $host, $dbId, $format='JSON') {
    if (!preg_match("/^sub/i", $dbId)) {                                    //检测数据库ID是否以sub开头，如果不是拒绝执行删除操作并退出
        echo "要求删除一个非临时实例,默认拒绝!";
        exit(1);
    }
    $deleteResult = AliyunAPI(                                                //调用AliyunAPI.php的AliyunAPI函数
    $key,
    $secret,
    $host,
    $format,
    array(
        'Action' => 'DeleteDBInstance',
        'DBInstanceId' => $dbId,
    )
    );
    return $deleteResult;
}

function DescribeBackups ($key, $secret, $host, $dbId, $format='JSON') {
    $startTime = gmdate('Y-m-d\TH:i\Z',time() - 7 * 24 * 60 * 60);         //7天内
    $endTime = gmdate('Y-m-d\TH:i\Z');
    $getBackupId = AliyunAPI(                                                //调用AliyunAPI.php的AliyunAPI函数
    $key,
    $secret,
    $host,
    $format,
    array(
        'Action' => 'DescribeBackups',
        'DBInstanceId' => $dbId,
        'StartTime' => $startTime,
        'EndTime' => $endTime
    )
    );
    return $getBackupId;
}

function CreateTempDBInstance ($key, $secret, $host, $dbId, $format='JSON') {
    $getBackupId = DescribeBackups($key, $secret, $host, $dbId);
    $backupStatus = $getBackupId['Items']['Backup']['0']['BackupStatus'];
    if ($backupStatus == 'Success') {                                         //如果第一个备份状态不成功，则使用第二个备份
        $backupId = $getBackupId['Items']['Backup']['0']['BackupId'];
    } else {
        $backupId = $getBackupId['Items']['Backup']['1']['BackupId']; 
    }
    $getTempDBId = AliyunAPI(                                               //调用AliyunAPI.php的AliyunAPI函数
    $key,
    $secret,
    $host,
    $format,
    array(
        'Action' => 'CreateTempDBInstance',
        'DBInstanceId' => $dbId,
        'BackupId' => $backupId
    )
    );
    return $getTempDBId;
}

//------------------------------------------------------------------------------------------------------------------------
 
$getTempDBId = DescribeDBInstanceAttribute($key, $secret, $host, $dbId);
if (isset($getTempDBId['Items']['DBInstanceAttribute']['0']['TempDBInstanceId']) && !empty($getTempDBId['Items']['DBInstanceAttribute']['0']['TempDBInstanceId'])) {
    $tempDBId = $getTempDBId['Items']['DBInstanceAttribute']['0']['TempDBInstanceId'];
    $getTempDBExpireTime = DescribeDBInstanceAttribute($key, $secret, $host, $tempDBId);
    $tempDBExpireTime = $getTempDBExpireTime['Items']['DBInstanceAttribute']['0']['ExpireTime'];

    $surplus = strtotime($tempDBExpireTime) - strtotime(gmdate('Y-m-d\TH:i:s\Z'));

    if (($surplus < 12 * 60 * 60) && (gmdate('H') > 12 && gmdate('H') < 22)) {    //如果离过期时间不足12个小时，且在北京时间20点到第二天凌晨6点之间
        DeleteDBInstance($key, $secret, $host, $tempDBId);
        $getTempDBId = CreateTempDBInstance ($key, $secret, $host,$dbId);
        $tempDBId = $getTempDBId['TempDBInstanceId'];
        echo $tempDBId;
    }
} else {
    $getTempDBId = CreateTempDBInstance ($key, $secret, $host, $dbId);
    $tempDBId = $getTempDBId['TempDBInstanceId'];
    echo $tempDBId;
}


