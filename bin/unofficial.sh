#!/usr/bin/env bash

#
# Get Unofficial Docs URL-List
#

# 创建临时环境
TMP_PATH=$(mktemp -d)

# 删除旧 URL 列表
rm -rf ../unofficial*.txt

# 克隆仓库
#
# 截止 2021-09-18，此方法中包含的文档数量相比下面的方法少 3 个。
# 分别为 ARM_A64_ISA、ARM_AArch32_ISA、ARM_System_Register。
#git clone --depth=1 git@github.com:Kapeli/Dash-User-Contributions.git "$TMP_PATH/Dash-User-Contributions"

# 下载离线引索
#
# 有 5 个节点可用，分别为 sanfrancisco、london、newyork、tokyo、frankfurt。
curl -L "http://london.kapeli.com/feeds/zzz/user_contributed/build/index.json" -o "$TMP_PATH/duc-london.json"

# 过滤出文档名和文档压缩包名
cat "$TMP_PATH/duc-london.json" | grep '^    "' | cut -d'"' -f2 > "$TMP_PATH/docs_name.txt"
cat "$TMP_PATH/duc-london.json" | grep '^      "archive' | cut -d'"' -f4 > "$TMP_PATH/docs_archive.txt"

# 遍历并拼接 URL
if [[ $(cat "$TMP_PATH/docs_name.txt" | wc -l) == $(cat "$TMP_PATH/docs_archive.txt" | wc -l) ]]; then
    COMMON_URL="kapeli.com/feeds/zzz/user_contributed/build"
    for ((i=1; i<=$(cat "$TMP_PATH/docs_name.txt" | wc -l); i ++)) {
        DOCS_NAME=$(cat "$TMP_PATH/docs_name.txt" | sed -n "$i p")
        DOCS_ARCHIVE=$(cat "$TMP_PATH/docs_archive.txt" | sed -n "$i p")

        echo -e "http://sanfrancisco.$COMMON_URL/$DOCS_NAME/$DOCS_ARCHIVE" >> "../unofficial-sanfrancisco.txt"
        echo -e "http://london.$COMMON_URL/$DOCS_NAME/$DOCS_ARCHIVE"       >> "../unofficial-london.txt"
        echo -e "http://newyork.$COMMON_URL/$DOCS_NAME/$DOCS_ARCHIVE"      >> "../unofficial-newyork.txt"
        echo -e "http://tokyo.$COMMON_URL/$DOCS_NAME/$DOCS_ARCHIVE"        >> "../unofficial-tokyo.txt"
        echo -e "http://frankfurt.$COMMON_URL/$DOCS_NAME/$DOCS_ARCHIVE"    >> "../unofficial-frankfurt.txt"
        echo -e "http://$COMMON_URL/$DOCS_NAME/$DOCS_ARCHIVE"              >> "../unofficial.txt"
    }
fi

# 销毁临时环境
rm -rf "$TMP_PATH"
