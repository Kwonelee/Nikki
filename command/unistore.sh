#!/bin/sh
# 强制卸载iStore增强版脚本
do_unistore() {
    echo "Starting iStore force uninstallation..."

    # 1. 强制移除所有相关包（含残留依赖）装了 dockerman 就不要移除 luci-compat
    #opkg remove --force-removal-of-dependent-packages luci-app-store luci-lib-taskd luci-lib-xterm luci-compat >/dev/null 2>&1
    opkg remove --force-removal-of-dependent-packages luci-app-store luci-lib-taskd luci-lib-xterm >/dev/null 2>&1

    # 2. 清理所有配置痕迹（含修改过的文件）
    rm -f /etc/config/istore* 2>/dev/null      # 删除主配置文件及备份
    rm -rf /usr/lib/lua/luci/controller/store 2>/dev/null
    rm -rf /usr/share/luci/menu_store 2>/dev/null
    rm -rf /www/luci-static/istore 2>/dev/null

    # 3. 修复被篡改的系统文件
    sed -i '/istore.istoreos.com/d' /etc/opkg/compatfeeds.conf 2>/dev/null
    sed -i '/istore.istoreos.com/d' /usr/lib/lua/luci/cbi.lua 2>/dev/null

    # 4. 清理安装残留
    rm -f /tmp/is-opkg 2>/dev/null
    rm -f /etc/config/istore.opkg-dist 2>/dev/null  # 删除安装时的备份配置

    # 5. 修复软件源配置
    sed -i '/istore.istoreos.com/d' /etc/opkg/customfeeds.conf 2>/dev/null

    echo "iStore卸载完成！建议执行以下验证命令："
    echo "opkg list-installed | grep -E 'taskd|xterm|compat'  # 应无输出"
    echo "grep -r 'istore.istoreos.com' /etc /usr/lib/lua  # 应无匹配结果"
}

do_unistore
