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
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Kenzok8's Packages & Dependency
#mkdir temp_packages
#git clone https://github.com/kenzok8/small.git temp_packages/ && mv temp_packages/* package/ && rm -rf temp_packages && mkdir temp_packages
#git clone https://github.com/kenzok8/openwrt-packages.git temp_packages/ && mv temp_packages/* package/ && rm -rf temp_packages
#git clone https://github.com/kenzok8/small.git
#git clone https://github.com/kenzok8/openwrt-packages.git
#git clone --no-checkout https://github.com/kenzok8/small.git tmp/package/ && mv tmp/.git . && rmdir tmp && git reset --hard HEAD
#git clone --no-checkout https://github.com/kenzok8/openwrt-packages.git tmp/package/ && mv tmp/.git . && rmdir tmp && git reset --hard HEAD
#popd

# Add Coolsnowwolf's Packages
#git clone https://github.com/coolsnowwolf/lede.git

# Add Garypang13's Packages
#git clone https://github.com/garypang13/openwrt-packages.git

# Add other packages
#git clone https://github.com/rufengsuixing/luci-app-onliner.git # Add luci-app-onliner
#git clone https://github.com/tindy2013/openwrt-subconverter.git # Add subconverter
#git clone https://github.com/zcy85611/Openwrt-Package.git # Add luci-udptools
#git clone https://github.com/destan19/OpenAppFilter.git # Add OpenAppFilter

# Add luci-theme-argon
#git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
#rm -rf ../lean/luci-theme-argon

# Add luci-theme-argon-18.06_sed
#sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile

# 取消bootstrap为默认主题 & Add luci-theme-edge
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
git clone https://github.com/kenzok78/luci-theme-edge.git package/lean/luci-theme-edge
rm -rf package/lean/luci-theme-argon

# Mod zzz-default-settings & Modify the version number & Delete default password
#pushd package/lean/default-settings/files
#sed -i '/http/d' zzz-default-settings
#export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
#sed -i "s/OpenWrt /Redmi-AC2100 build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" zzz-default-settings
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" zzz-default-settings
#popd

# Delete default password & Custom settings
cp -f package/litte/commit/default-settings package/lean/default-settings/files/zzz-default-settings
cp -f package/litte/commit/banner package/base-files/files/etc/banner
cp -f package/litte/commit/Leandiffconfig .config && make defconfig
git pull && ./scripts/feeds update -a
./scripts/feeds install -a
sed -i "s/OpenWrt /Redmi-AC2100 build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" zzz-default-settings
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
#popd
