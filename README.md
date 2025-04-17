# Nikki
自用的一些配置，没啥好东西

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


## Rules
https://github.com/MetaCubeX/meta-rules-dat/tree/meta/geo/geosite


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

## Overlay 分区扩容 

1.手动扩容：
https://www.youtube.com/watch?v=YwbwzuXKNlg

2. 安装分区扩容 luci-app-partexp_all.ipk
```sh
# 一键安装 sirpdboy分区扩容 app
wget -O install.sh https://cafe.cpolar.top/wkdaily/OneKeyExpand/raw/branch/main/install.sh && chmod +x install.sh && ./install.sh

# 如果上述代码访问不到。可直接复制下面的内容。
opkg update
wget https://cafe.cpolar.top/wkdaily/OneKeyExpand/raw/branch/main/luci-app-partexp_all.ipk
opkg install luci-app-partexp_all.ipk 2>/dev/null
echo "安装成功"
```
