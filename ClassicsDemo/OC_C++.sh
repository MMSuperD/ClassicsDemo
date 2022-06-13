#!/bin/bash

if [[ $# -lt 1 ]]; then
    
    # 这里表示没有参数
    exit;

fi

param=$1

xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc $param
