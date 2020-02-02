#!/bin/bash

### 定义一个函数检查变量是否已经定义过
function DEFINE_ONCE()
{
	local var_name="$1"
	local var_value="$2"
	if [ "${!var_name}" == "$var_value" ]
	then
		return 1
	else
		export "$var_name"="$var_value"
		return 0
	fi
}
export -f DEFINE_ONCE

### 导出$CUSTOM_EXPORTED变量，当作标记来防止重复source
DEFINE_ONCE "CUSTOM_EXPORTED" "true" || return

################ 自定义环境变量开始 ################

### svn19
source /opt/rh/sclo-subversion19/enable

### git218
source /opt/rh/rh-git218/enable

### devtoolset-8
source /opt/rh/devtoolset-8/enable

### llvm-toolset-7.0
source /opt/rh/llvm-toolset-7.0/enable

### distcc
export DISTCC_VERSION=0
export DISTCC_LOG="/var/tmp/distcc.${LOGNAME}.log"

### cmake-3.16.2
cmake_home=/opt/cmake-3.16.2-Linux-x86_64
export PATH=$cmake_home/bin${PATH:+:${PATH}}
export MANPATH=$cmake_home/man${MANPATH:+:${MANPATH}}

### protobuf
protobuf_home=/opt/protobuf/3.11.2
export PATH=$protobuf_home/bin${PATH:+:${PATH}}
export C_INCLUDE_PATH=$protobuf_home/include${C_INCLUDE_PATH:+:${C_INCLUDE_PATH}}
export CPLUS_INCLUDE_PATH=$protobuf_home/include${CPLUS_INCLUDE_PATH:+:${CPLUS_INCLUDE_PATH}}
export LIBRARY_PATH=$protobuf_home/lib${LIBRARY_PATH:+:${LIBRARY_PATH}}
export LD_LIBRARY_PATH=$protobuf_home/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PKG_CONFIG_PATH=$protobuf_home/lib/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}

################ 自定义环境变量结束 ################

### MANPATH后缀一个:，以防止屏蔽系统man路径
export MANPATH=${MANPATH:+${MANPATH}:}

return
