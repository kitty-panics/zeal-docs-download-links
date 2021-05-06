#!/usr/bin/env bash

#
# Get official docs
#

# 创建临时环境
SET_TMP_PATH=$(mktemp -d)

# 克隆仓库
git clone --depth=1 git@github.com:Kapeli/feeds.git "$SET_TMP_PATH/feeds"

# 过滤出文档名字
SET_DATE=$(date +'%Y-%m-%d')
ls "$SET_TMP_PATH/feeds" | cat | sed '/README.md/d' | while read -r DOCS
do
    # 输出下载链接
    grep "sanfrancisco" "$SET_TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g' | sed 's/<\/url>$//g' >> ../official-sanfrancisco-$SET_DATE.txt
    grep "london"       "$SET_TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g' | sed 's/<\/url>$//g' >> ../official-london-$SET_DATE.txt
    grep "newyork"      "$SET_TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g' | sed 's/<\/url>$//g' >> ../official-newyork-$SET_DATE.txt
    grep "tokyo"        "$SET_TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g' | sed 's/<\/url>$//g' >> ../official-tokyo-$SET_DATE.txt
    grep "frankfurt"    "$SET_TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g' | sed 's/<\/url>$//g' >> ../official-frankfurt-$SET_DATE.txt
done

# 销毁临时环境
rm -rf "$SET_TMP_PATH"
