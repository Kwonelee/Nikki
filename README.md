# Nikki
自用的一些配置，没啥好东西

## Install 
https://github.com/nikkinikki-org/OpenWrt-nikki
1. Add Feed
```
# only needs to be run once
curl -s -L https://github.com/nikkinikki-org/OpenWrt-nikki/raw/refs/heads/main/feed.sh | ash
```
2. Install
```
# you can install from shell or `Software` menu in LuCI
# for opkg
opkg install nikki
opkg install luci-app-nikki
opkg install luci-i18n-nikki-zh-cn
```


## Rules
https://github.com/MetaCubeX/meta-rules-dat/tree/meta/geo/geosite


## 安装 iStore/ 网络向导 / 首页
1. 在软件包那里先手动安装 
`luci-i18n-samba4-zh-cn`  `script-utils`
2. 安装iStore商店(ARM64 & x86-64通用)
```
wget -qO imm.sh https://cafe.cpolar.top/wkdaily/zero3/raw/branch/main/zero3/imm.sh && chmod +x imm.sh && ./imm.sh
```
3. 安装网络向导和首页(ARM64 & x86-64通用)
```
is-opkg install luci-i18n-quickstart-zh-cn
```
