#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sudo apt install libfuse-dev
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 移除 feeds.conf 中无在线镜像的 feed（passwall），避免其被写入固件 opkg 源 distfeeds.conf
# （ImmortalWrt 24.10 会把所有启用的 feed 生成 opkg 仓库，passwall 无预编译镜像，刷机后 opkg update 必报 404）
sed -i '/passwall/d' feeds.conf
