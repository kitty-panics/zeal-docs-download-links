#!/usr/bin/env bash

#
# Get Official Docs URL-List
#

# 创建临时环境
TMP_PATH=$(mktemp -d)

# 删除旧 URL 列表
rm -rf ../official-*.txt

# 克隆文档描速文件的仓库
git clone --depth=1 git@github.com:Kapeli/feeds.git "$TMP_PATH/feeds"

# 过滤出文档名字
ls "$TMP_PATH/feeds" | cat | sed '/README.md/d' | while read -r DOCS
do
    # 输出新 URL 列表
    grep "sanfrancisco" "$TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g;s/<\/url>$//g' >> ../official-sanfrancisco.txt
    grep "london"       "$TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g;s/<\/url>$//g' >> ../official-london.txt
    grep "newyork"      "$TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g;s/<\/url>$//g' >> ../official-newyork.txt
    grep "tokyo"        "$TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g;s/<\/url>$//g' >> ../official-tokyo.txt
    grep "frankfurt"    "$TMP_PATH/feeds/$DOCS" | sed 's/^    <url>//g;s/<\/url>$//g' >> ../official-frankfurt.txt
done

# 销毁临时环境
rm -rf "$TMP_PATH"
