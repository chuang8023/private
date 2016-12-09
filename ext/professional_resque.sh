#!/bin/bash
. ../run.sh
Param1=$1
ProfessnalResque=$Param1
Main
cd $ProjPath
case ProfessnalResque
 in 
  CatProfessnalResqueStatus) 
  php ./deploy/othersaas/getQueueStateProfessional.php
  ;;
  ResetProfessnalResque)
  php  ./deploy/othersaas/addQueueRedisCacheProfessional.php
  ;;
 *)
esac
