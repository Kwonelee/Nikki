#!/bin/sh
# iStore终极卸载脚本 v3.2
do_unistore() {
    echo "Starting iStore professional uninstallation..."

    # 1. 安全卸载quickstart插件（安全增强）
    if opkg list-installed | grep -q 'luci-app-quickstart'; then
        echo "检测到quickstart插件，开始卸载..."
        is-opkg remove luci-app-quickstart --force-removal-of-dependent-packages 2>/dev/null || {
            echo "Quickstart卸载失败，尝试强制模式..."
            is-opkg remove luci-app-quickstart --force-depends --force-removal-of-essential-packages 2>/dev/null
        }
    else
        echo "未检测到quickstart插件，跳过卸载"
    fi

    # 2. 检查并处理luci-compat依赖（交互式确认）
    if opkg list-installed | grep -q 'luci-compat'; then
        if ! opkg list-installed | grep -q 'luci-app-dockerman'; then
            echo "检测到luci-compat依赖，是否移除？(y/N)"
            read -r response
            case "$response" in
                [yY][eE][sS]|[yY]) 
                    echo "正在移除luci-compat..."
                    opkg remove --force-removal-of-dependent-packages luci-compat >/dev/null 2>&1
                    ;;
                *)
                    echo "保留luci-compat依赖"
                    ;;
            esac
        else
            echo "检测到luci-app-dockerman，保留luci-compat依赖"
        fi
    else
        echo "未检测到luci-compat，跳过处理"
    fi

    # 3. 完整移除iStore核心组件（带状态检查）
    for pkg in luci-app-store luci-lib-taskd xterm; do
        if opkg list-installed | grep -q "$pkg"; then
            echo "正在移除 $pkg ..."
            opkg remove --force-removal-of-dependent-packages "$pkg" >/dev/null 2>&1
        fi
    done

    # 4. 深度清理残留文件（多维度验证）
    rm -rf /etc/config/quickstart* 2>/dev/null
    rm -rf /etc/config/istore* 2>/dev/null
    rm -rf /usr/lib/lua/luci/controller/store 2>/dev/null
    rm -rf /usr/share/luci/menu_store 2>/dev/null
    rm -rf /www/luci-static/istore 2>/dev/null
    rm -rf /usr/share/xterm 2>/dev/null  # 新增xterm配置清理

    # 5. 系统文件修复（精准定位修改）
    sed -i '/istore.istoreos.com/d' /etc/opkg/compatfeeds.conf 2>/dev/null
    sed -i '/istore.istoreos.com/d' /usr/lib/lua/luci/cbi.lua 2>/dev/null

    # 6. 清理备份配置（版本兼容处理）
    rm -f /etc/config/istore.opkg-dist 2>/dev/null
    rm -f /etc/config/istore.bak 2>/dev/null

    echo "iStore卸载完成！建议执行以下验证命令："
    echo "opkg list-installed | grep -E 'taskd|xterm|compat'  # 应无输出"
    echo "grep -r 'istore.istoreos.com' /etc /usr/lib/lua  # 应无匹配结果"
}

do_unistore
