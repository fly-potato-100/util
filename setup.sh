#! /bin/bash

### 获取脚本所在绝对目录
BASE_DIR=$(cd `dirname $0`; pwd)

### 拷贝文件
cp -fr $BASE_DIR/gitconfig ~/.gitconfig
cp -fr $BASE_DIR/gdbinit ~/.gdbinit
cp -fr $BASE_DIR/vimrc ~/.vimrc
cp -fr $BASE_DIR/bashrc ~/.bashrc

### 个别文件替换路径名
sed -i "s#@BASE_DIR@#$BASE_DIR#g" ~/.gdbinit

echo "---> setup succeeded"
