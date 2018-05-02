#!/bin/bash
localCmd=$@
localPath=$(pwd)
remotePath=${localPath/$SSHFS_DEPOT/$REMOTE_DEPOT}
remoteCmd=${localCmd/$SSHFS_DEPOT/$REMOTE_DEPOT}

echo $@
echo $remoteCmd
echo $remotePath

ssh -Y -C athomas@192.168.0.208 "source ~/.profile && cd $remotePath && $@"
