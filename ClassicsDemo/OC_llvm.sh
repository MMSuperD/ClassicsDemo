#!/bin/bash

if [[ $# -lt 1 ]]; then
    
    # 这里表示没有参数
    exit;

fi

param=$1

# OC 转化为 LLVM 代码
clang -emit-llvm -S $param
