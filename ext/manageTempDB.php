<?php

require __DIR__ . '/aliyunAPI.php';

/*
 * API密钥、URL地址、主实例ID
 */
 $key = 'e7QcE1SfNze9eAuC';
 $secret = 'o8CLhEK6k3iyrjYPmL3TlTBBtK3I9y';
 $host = 'https://rds.aliyuncs.com/';
 $format = 'JSON';          //请勿随意修改
 
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
 
function GetDBInfo($dbId) {
    $dbInfo = AliyunAPI(                                                    //调用AliyunAPI.php的AliyunAPI函数
    $GLOBALS['key'],
    $GLOBALS['secret'],
    $GLOBALS['host'],
    $GLOBALS['format'],
        array(
            'Action' => 'DescribeDBInstanceAttribute',
            'DBInstanceId' => $dbId,
        )
    );
    return $dbInfo;
}

function GetTempDBId($dbInfo) {
    if (isset($dbInfo['Items']['DBInstanceAttribute']['0']['TempDBInstanceId']) && !empty($dbInfo['Items']['DBInstanceAttribute']['0']['TempDBInstanceId'])) {
    	$tempDBId = $dbInfo['Items']['DBInstanceAttribute']['0']['TempDBInstanceId'];
    } else {
        $tempDBId = '';
    }
    return $tempDBId;
}

function GetDBExpireTime($dbInfo) {
    if (isset($dbInfo['Items']['DBInstanceAttribute']['0']['ExpireTime']) && !empty($dbInfo['Items']['DBInstanceAttribute']['0']['ExpireTime'])) {
        $dbExpireTime = $dbInfo['Items']['DBInstanceAttribute']['0']['ExpireTime'];
    } else {
        $dbExpireTime = '';
    }
    return $dbExpireTime;
}

function DeleteDB($dbId) {
    if (!preg_match("/^sub/i", $dbId)) {                                    //检测数据库ID是否以sub开头，如果不是拒绝执行删除操作并退出
        echo "要求删除一个非临时实例,默认拒绝!";
        exit(1);
    }
    $deleteResult = AliyunAPI(                                                //调用AliyunAPI.php的AliyunAPI函数
    $GLOBALS['key'],
    $GLOBALS['secret'],
    $GLOBALS['host'],
    $GLOBALS['format'],
        array(
            'Action' => 'DeleteDBInstance',
            'DBInstanceId' => $dbId,
        )
    );
    return $deleteResult;
}

function GetBackupId($dbId) {
    $startTime = gmdate('Y-m-d\TH:i\Z',time() - 7 * 24 * 60 * 60);         //7天内
    $endTime = gmdate('Y-m-d\TH:i\Z');
    $backupResult = AliyunAPI(                                                //调用AliyunAPI.php的AliyunAPI函数
    $GLOBALS['key'],
    $GLOBALS['secret'],
    $GLOBALS['host'],
    $GLOBALS['format'],
        array(
            'Action' => 'DescribeBackups',
            'DBInstanceId' => $dbId,
            'StartTime' => $startTime,
            'EndTime' => $endTime
        )
    );
    $backupStatus = $backupResult['Items']['Backup']['0']['BackupStatus'];
    if ($backupStatus == 'Success') {                                         //如果第一个备份状态不成功，则使用第二个备份
        $backupId = $backupResult['Items']['Backup']['0']['BackupId'];
    } else {
        $backupId = $backupResult['Items']['Backup']['1']['BackupId']; 
    }
    return $backupId;
}

function CreateTempDB($dbId) {
    $backupId = GetBackupId($dbId);
    $createResult = AliyunAPI(                                               //调用AliyunAPI.php的AliyunAPI函数
    $GLOBALS['key'],
    $GLOBALS['secret'],
    $GLOBALS['host'],
    $GLOBALS['format'],
        array(
            'Action' => 'CreateTempDBInstance',
            'DBInstanceId' => $dbId,
            'BackupId' => $backupId
        )
    );
    if (isset($createResult['TempDBInstanceId']) && !empty($createResult['TempDBInstanceId'])) {
        $tempDBId = $createResult['TempDBInstanceId'];
    } else {
        echo $createResult['Message'] . "\n";
        exit(1);
    }
    return $tempDBId;
}

//------------------------------------------------------------------------------------------------------------------------

function AutoManage($dbId) {
    $dbInfo = GetDBInfo($dbId);
    $tempDBId = GetTempDBId($dbInfo);
    if (!empty($tempDBId)) {
        $tempDBInfo = GetDBInfo($tempDBId);
        $tempDBExpireTime = GetDBExpireTime($tempDBInfo);
        if (!empty($tempDBExpireTime)) {
            $surplus = strtotime($tempDBExpireTime) - strtotime(gmdate('Y-m-d\TH:i:s\Z'));
        } else {
            echo "Cannot get temp database expire time !\n";
            exit(1);
        }
        if (($surplus < 12 * 60 * 60) && (gmdate('H') > 12 && gmdate('H') < 22)) {    //如果离过期时间不足12个小时，且在北京时间20点到第二天凌晨6点之间
            DeleteDB($tempDBId);
            $tempDBId = CreateTempDB($dbId);
            echo $tempDBId . "\n";
        }
    } else {
        $tempDBId = CreateTempDB($dbId);
        echo $tempDBId . "\n";
    }
}

if (isset($argv['1']) && !empty($argv['1'])) {
    $dbId = $argv['1'];
} else {
    echo "Error argvs !\n";
    exit(1);
}

if (isset($argv['2']) && !empty($argv['2'])) {
    switch ($argv['2']) {
        case 'expireTime':
            $dbInfo = GetDBInfo($dbId);
            $tempDBId = GetTempDBId($dbInfo);
            if (!empty($tempDBId)) {
                $tempDBInfo = GetDBInfo($tempDBId);
                $tempDBExpireTime = GetDBExpireTime($tempDBInfo);
                echo gmdate('Y-m-d H:i:s', strtotime($tempDBExpireTime) + 8 * 60 * 60) ."\n";
            } else {
                echo "Cannot get temp database instance ID !\n";
                exit(1);
            }
            break;
        case 'deleteTempDB':
            $dbInfo = GetDBInfo($dbId);
            $tempDBId = GetTempDBId($dbInfo);
            if (!empty($tempDBId)) {
                DeleteDB($tempDBId);
                echo "Delete temp database is OK !\n";
            } else {
                echo "Cannot get temp database ID !\n";
                exit(1);
            }
            break;
        case 'createTempDB':
            $tempDBId = CreateTempDB($dbId);
            echo $tempDBId . "\n";
            break;
        default :
            echo "Error argvs !\n";
            exit(1);
    }
} else {
    AutoManage($dbId);
}