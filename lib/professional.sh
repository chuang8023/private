#!/bin/bash
function ProfessnalResque {
ProfessnalResque=$Param3
Main
cd $ProjPath
case $ProfessnalResque
 in 
  CatProfessnalResqueStatus) 
  php ./deploy/othersaas/getQueueStateProfessional.php
  ;;
  ResetProfessnalResque)
  php  ./deploy/othersaas/addQueueRedisCacheProfessional.php
esac
}
