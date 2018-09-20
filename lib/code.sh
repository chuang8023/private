function PullCodeOrg (){
	cd $OrgPath 
	local _OrgBranch=`git branch | grep "*" | awk '{print $2}'`
	echo "pulling the org code....."
	git checkout .
	git pull --rebase origin ${_OrgBranch} 1>/dev/null 2>/tmp/rundeck_orgcode_errinfo
	if [[ $? == 0 ]]; then
	        ChangePullOwn
	        echo ""
        	echo "${_OrgBranch} pull the new code is OK !"
       	 	cd - 1>/dev/null 2>&1
	else
   		 echo ""
    	         echo "${_OrgBranch} pull the new code is Fail !"
	         echo "---------------------------------------------"
                 cat /tmp/rundeck_code_errinfo
	         exit 1
	fi
	cd $ProjPath
	./deploy/syncConfig
}



function PullCode {
echo ""
echo "$BranchName pulling the new code ..."
cd $ProjPath
git checkout .
git pull --rebase origin $BranchName 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
    ChangePullOwn
    echo ""
    echo "$BranchName pull the new code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$BranchName pull the new code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
cd - 1>/dev/null 2>&1
}

function ChangePullOwn {
#ChangeFile=(`git diff $CommitID | grep "diff --git a" | awk '{print $4}' | cut -c 3-`)
#for (( i=0;i<${#ChangeFile[*]};i++ ))
#do
#    chown $runuser:$runuser ${ChangeFile[i]} 2>/dev/null
#done
#chown -R $runuser:$runuser .git
find . -user root -exec chown $runuser:$runuser {} \;
}

function RollbackCode () {
local _CommitID=$1

if [[ $_CommitID != "" ]]; then
    echo ""
    echo "$BranchName rollbacking code to $_CommitID ..."
    cd $ProjPath
    git reset --hard $_CommitID 1>/dev/null 2>/tmp/rundeck_code_errinfo
    if [[ $? == 0 ]]; then
        echo ""
        echo "$BranchName rollback code is OK !"
        echo "Now commit id is $_CommitID"
        cd - 1>/dev/null 2>&1
    else
        echo ""
        echo "$BranchName rollback code is Fail !"
        echo "Now commit id is $_CommitID"
        echo "----------------------------------------------"
        cat /tmp/rundeck_code_errinfo
        exit 1
    fi
else
    echo ""
    echo "Commit_ID is empty !"
    exit 1
fi
}

function UpdateVendor {
   function ExecUpdateVendor {
 	IsSocket=`cat $ProjConfPath/app.php|grep is_socket|awk -F "=>" '{print $2}'|sed 's/,.*//'|grep true|sed 's/ //'`
        [[ $IsSocket == true ]] && StopWebsocket
        echo ""
        echo "Updating vendor ..."
	~/bin/composer.phar update
         if [[ $? == 0 ]]; then
                ChangePullOwn
                echo ""
                echo "Update vendor is OK !"
                [[ $IsSocket == true ]] && StartWebsocket
                RestartResque
         else
                echo ""
                echo "Update vendor is fail !"
                exit 1
         fi
		 }	
cd $ProjPath
if [ -e vendor/version ];then
	Lastet_Vendor=`cat script/vendor|sed -n 2p|awk -F "=" '{print $2}'`
	Server_Vendor=`cat vendor/version`
	if [[ $Lastet_Vendor = $Server_Vendor ]] ;then

		 echo "" && echo "Not need to update vendor !" 
	else
	        ExecUpdateVendor
	fi
else
     ExecUpdateVendor
fi
cd - 1>/dev/null 2>&1
}


function BackVendor {
	cd  $ProjPath	
	local _Date=`date +%Y-%m-%d`
	echo "当前目录为：$PWD"
	echo "开始备份vendor....."	
	cp -r vendor /home/anyuankeji/vendor_${_Date}
        [ $? -eq 0 ] && echo "备份vendor包成功！！"
}
