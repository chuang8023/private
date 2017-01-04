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
  * CloneDBInstanceId    //临时实例ID(如果存在临时实例),$obj['Items']['DBInstanceAttribute']['0']['CloneDBInstanceId']
  * 
  * 创建临时实例
  * 请求参数:
  * 'Action' => 'CreateCloneDBInstance';
  * 'DBInstanceId' => 'rds26h77108r3o8c4jwj';
  * 'BackupId' => '111044758';
  * 'RestoreTime' => '2011-06-11T16:00:00Z';
  * 返回参数:
  * CloneDBInstanceId    //临时实例ID
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

function GetCloneDBId($dbInfo) {
    if (isset($dbInfo['Items']['DBInstanceAttribute']['0']['CloneDBInstanceId']) && !empty($dbInfo['Items']['DBInstanceAttribute']['0']['CloneDBInstanceId'])) {
    	$cloneDBId = $dbInfo['Items']['DBInstanceAttribute']['0']['CloneDBInstanceId'];
    } else {
        $cloneDBId = '';
    }
    return $cloneDBId;
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
    if (!preg_match("/^rm-/i", $dbId)) {                                    //检测数据库ID是否以sub开头，如果不是拒绝执行删除操作并退出
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

function CreateCloneDB($dbId) {
    $backupId = GetBackupId($dbId);
    $createResult = AliyunAPI(                                               //调用AliyunAPI.php的AliyunAPI函数
    $GLOBALS['key'],
    $GLOBALS['secret'],
    $GLOBALS['host'],
    $GLOBALS['format'],
        array(
            'Action' => 'CloneDBInstance',
            'DBInstanceId' => $dbId,
            'BackupId' => $backupId,
            'PayType' => 'Postpaid',
            'ClientToken' => 'ETnLKlblzczshOTUbOCziJZNwHlYBQ'
        )
    );
    if (isset($createResult['DBInstanceId']) && !empty($createResult['DBInstanceId'])) {
        $CloneDBId = $createResult['DBInstanceId'];
    } else {
        echo $createResult['Message'] . "\n";
        exit(1);
    }
    return $CloneDBId;
}

function CloneDBStatus($dbInfo) {
    if (isset($dbInfo['Items']['DBInstanceAttribute']['0']['DBInstanceStatus']) && !empty($dbInfo['Items']['DBInstanceAttribute']['0']['DBInstanceStatus'])) {
        $dbStatus = $dbInfo['Items']['DBInstanceAttribute']['0']['DBInstanceStatus'];
    } else {
        $dbStatus = '';
    }
    return $dbStatus;
}

//------------------------------------------------------------------------------------------------------------------------

function AutoManage($dbId) {
    $dbInfo = GetDBInfo($dbId);
    $cloneDBId = GetCloneDBId($dbInfo);
    if (!empty($cloneDBId)) {
        $cloneDBInfo = GetDBInfo($cloneDBId);
        $cloneDBExpireTime = GetDBExpireTime($cloneDBInfo);
        if (!empty($cloneDBExpireTime)) {
            $surplus = strtotime($cloneDBExpireTime) - strtotime(gmdate('Y-m-d\TH:i:s\Z'));
        } else {
            echo "Cannot get temp database expire time !\n";
            exit(1);
        }
        if (($surplus < 12 * 60 * 60) && (gmdate('H') > 12 && gmdate('H') < 22)) {    //如果离过期时间不足12个小时，且在北京时间20点到第二天凌晨6点之间
            DeleteDB($cloneDBId);
            $cloneDBId = CreateCloneDB($dbId);
            echo $cloneDBId . "\n";
        } else {
            echo $cloneDBId . "\n";
        }
    } else {
        $cloneDBId = CreateCloneDB($dbId);
        echo $cloneDBId . "\n";
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
        case 'showCloneDB':
            $dbInfo = GetDBInfo($dbId);
            $cloneDBId = GetCloneDBId($dbInfo);
            echo $cloneDBId . "\n";
            break;
        case 'expireTime':
            $dbInfo = GetDBInfo($dbId);
            $cloneDBId = GetCloneDBId($dbInfo);
            if (!empty($cloneDBId)) {
                $cloneDBInfo = GetDBInfo($cloneDBId);
                $cloneDBExpireTime = GetDBExpireTime($cloneDBInfo);
                echo gmdate('Y-m-d H:i:s', strtotime($cloneDBExpireTime) + 8 * 60 * 60) ."\n";
            } else {
                echo "Cannot get temp database instance ID !\n";
                exit(1);
            }
            break;
        case 'deleteCloneDB':
            $dbInfo = GetDBInfo($dbId);
            $cloneDBId = GetCloneDBId($dbInfo);
            if (!empty($cloneDBId)) {
                DeleteDB($cloneDBId);
                echo "Delete temp database is OK !\n";
            } else {
                echo "Cannot get temp database ID !\n";
                exit(1);
            }
            break;
        case 'createCloneDB':
            $cloneDBId = CreateCloneDB($dbId);
            echo $cloneDBId . "\n";
            break;
        case 'cloneDBStatus':
            $dbInfo = GetDBInfo($dbId);
            $cloneDBId = GetCloneDBId($dbInfo);
            if (!empty($cloneDBId)) {
                $temDBInfo = GetDBInfo($cloneDBId);
                $cloneDBStatus = CloneDBStatus($temDBInfo);
                echo $cloneDBStatus . "\n";
            } else {
                echo "Cannot get temp database status !\n";
                exit(1);
            }
            break;
        default :
            echo "Error argvs !\n";
            exit(1);
    }
} else {
    AutoManage($dbId);
}
