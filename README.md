# Nikki
自用的一些配置，没啥好东西

yaml 配置文件抄袭自：
### refined-fish 
### https://github.com/refined-fish/clash_rule_fish

真是好东西啊～感谢他！

## Install 
https://github.com/nikkinikki-org/OpenWrt-nikki
1. Prepare curl
```sh
opkg update
opkg install curl
```

3. Add Feed
```sh
# only needs to be run once
# https://gh-proxy.com/https://github.com/nikkinikki-org/OpenWrt-nikki/raw/refs/heads/main/feed.sh

curl -s -L https://github.com/nikkinikki-org/OpenWrt-nikki/raw/refs/heads/main/feed.sh | ash
```

2. Install
```sh
# you can install from shell or `Software` menu in LuCI
# for opkg
opkg install nikki
opkg install luci-app-nikki
opkg install luci-i18n-nikki-zh-cn
```

## Auto Update
在'系统'->'计划任务' 中添加:
```sh
15 0 * * * opkg update && opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade
```
每天晚上 0:15 升级可以升级的所有插件


## Rules
[https://github.com/MetaCubeX/meta-rules-dat/tree/meta/geo/geosite](https://github.com/MetaCubeX/meta-rules-dat/tree/meta/geo-lite/geosite/classical)

[https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash)

## 安装 iStore/ 网络向导 / 首页
1. 在软件包那里先手动安装 
`luci-i18n-samba4-zh-cn`  `script-utils`
2. 安装iStore商店(ARM64 & x86-64通用)
```sh
wget -qO imm.sh https://cafe.cpolar.top/wkdaily/zero3/raw/branch/main/zero3/imm.sh && chmod +x imm.sh && ./imm.sh
```
3. 安装网络向导和首页(ARM64 & x86-64通用)
```sh
is-opkg install luci-i18n-quickstart-zh-cn
```
4. 卸载 iStore
```
wget -qO unistore.sh https://raw.githubusercontent.com/imken/Nikki/refs/heads/main/command/unistore.sh  && chmod +x unistore.sh && ./unistore.sh
```


## Overlay 分区扩容 

1. 手动扩容：
https://www.youtube.com/watch?v=YwbwzuXKNlg

2. 安装sirpdboy的luci-app-partexp分区扩容
https://github.com/sirpdboy/luci-app-partexp
下载ipk后安装

## Backup & Restore
修改自 https://github.com/wukongdaily/OpenBackRestore

1. 下载脚本
```sh
wget -O backup.sh https://raw.githubusercontent.com/imken/Nikki/refs/heads/main/command/backup.sh
```

2. 执行备份
```sh
# 备份到 /opt/backup
sh backup.run /opt/backup
```

3. 恢复备份
```sh
# 将备份档案提前上传到 /tmp/upload/ 或者放在 restore.run 的同一目录(修改了原版)
wget -O restore.sh https://raw.githubusercontent.com/imken/Nikki/refs/heads/main/command/restore.sh && chmod +x restore.sh && sh restore.sh
```

## 安装 1Panel
https://github.com/hubhike/1Panel_openwrt

## 图标库
https://icon-sets.iconify.design/
