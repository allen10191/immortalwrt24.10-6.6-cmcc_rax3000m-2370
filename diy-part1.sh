#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# passwall 官方源已迁移至 Openwrt-Passwall 组织（旧地址 xiaorouji/openwrt-passwall 已失效）
# 按官方 README 要求，将 passwall 两个 feed 插入 feeds.conf.default 顶部
sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '2i src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall.git;main' feeds.conf.default
echo 'src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome' >>feeds.conf.default
# adguardhome 核心包由 immortalwrt/packages feed 的 net/adguardhome 提供，无需单独 feed
# （原 rufengsuixing/openwrt-adguardhome 仓库已删除）
git clone https://github.com/sbwml/luci-app-openlist2 package/openlist
