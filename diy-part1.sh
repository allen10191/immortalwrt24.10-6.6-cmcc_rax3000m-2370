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
# adguardhome 核心包由 immortalwrt/packages feed 的 net/adguardhome 提供（v0.107.57），无需单独 feed
# luci-app-adguardhome 换用 sirpdboy 维护版（luci.mk 新版架构，兼容 24.10；原 rufengsuixing 为老 lua 版，24.10 下菜单不显示）
git clone --depth 1 https://github.com/sirpdboy/luci-app-adguardhome.git package/adguardhome-luci
cp -r package/adguardhome-luci/luci-app-adguardhome package/luci-app-adguardhome
rm -rf package/adguardhome-luci
# lucky 主包 + luci 前端（取自 kenzok8/openwrt-packages，sparse 只拉需要的目录，避免全量克隆大仓库）
git clone --depth 1 --filter=blob:none --sparse https://github.com/kenzok8/openwrt-packages.git package/kenzok8-lucky
cd package/kenzok8-lucky
git sparse-checkout set luci-app-lucky
mv luci-app-lucky/lucky ../lucky
mv luci-app-lucky/luci-app-lucky ../luci-app-lucky
cd ../..
rm -rf package/kenzok8-lucky
git clone https://github.com/sbwml/luci-app-openlist2 package/openlist

# OpenAppFilter luci 前端（作者 destan19 原版，依赖官方 feed 的 kmod-oaf + appfilter 主包）
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/openappfilter-src
cp -r package/openappfilter-src/luci-app-oaf package/luci-app-oaf
rm -rf package/openappfilter-src
