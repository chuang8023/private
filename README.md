#  run.sh 流程说明 #

#### 命令列表
* update
* showPullLog
* rollback
* resqueStat
* restartResque
* showMigrate
* migrate
* closeMinAssets
* openMinAssets
* rgulp
* rebuild_org_tree
* rebuild_to_redis
* backupDB
* showBranch
* gco
* cleanUserChatToken
* stash
* stashpop
* gst
* tempDBStatus
* tempDBExpireTime
* createTempDB
* deleteTempDB
* showTempDBUrl
* autoTempDB
* updateVendor
* autoMigrate
* stopwebsocket
* startwebsocket
* catphplog
* catresquelog


---

### update

modifyDBurl **检查DB host 是否正确**
GetPullLog  **获取git Commit id**
PullCode   **git checkout branch**
BackupDB   **检查 migrations diff,  并mysqldump 备份**
EchoPullLog  **纪录发布日志到LOG**
UpdateVendor **更新vendor包，需重启 StopWebsocket **
Migrate "all" **检查 Migrate，有时进行Migrate操作  **
Rgulp  **检查是否压缩资源，并压缩**
RestartResque **停止队列，重启队列**


### showPullLog

ShowPullLog **显示最近10条项目发布纪录时间**

### rollback

RollbackCode **切换代码库到指定 Commit**
RollbackDB **还原数据库，删除老的倒入备份的**
Migrate **Migrate代码**
Rgulp **检查是否压缩资源，并压缩**
Resque

### resqueStat

ResqueStat **resque 状态**


###showMigrate

ShowMigrate **显示最新的30条 migrate 信息**

### migrate

Migrate **执行指定一条migrate, 先down 在 up**

### rgulp

 Rgulp "-f" **资源编辑压缩，开启minAssets**
 
### backupDB

BackupDB "-f" **备份当前commint 数据库**


###cleanUserChatToken

CleanUserChatToken "$_DBHost"  **清空 sys_user_chat_token 内容**

### catphplog

CatPHPLog **tail 500 PHPlog**

### catresquelog

CatResqueLog **CatResqueLog reque 具体项 log **
