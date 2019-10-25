#!/bin/bash

function readfile ()
{
#这里`为esc下面的按键符号
  for file in `ls $1`
  do
    #这里的-d表示是一个directory，即目录/子文件夹
    if [ -d $1"/"$file ]
    then
        #如果子文件夹则递归
        readfile $1"/"$file
    else
        #否则就能够读取该文件的地址
        filepath=$1"/"$file
        # 生成 yaml 格式的commit信息到指定文件
        echo "$filepath:" >> "$COMMITSFILE"
        git log --follow --pretty=format:'
    -
        hash: %H
        name: %cn
        email: %ce
        date: %ci
        datef: %cr
        message:
            %s
' --name-only --no-merges  "$filepath" | grep -v '^$' |grep -Ev "\.md" >> "$COMMITSFILE" || true
    
    fi
  done
}
#函数定义结束，这里用来运行函数
folder="./content"
COMMITSFILE="./data/commits.yaml"
mkdir -p "./data"
echo "# auto gen" > "$COMMITSFILE"
readfile $folder 