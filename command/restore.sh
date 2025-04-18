#!/bin/sh
# 定义颜色输出函数
red() { echo -e "\033[31m\033[01m[WARNING] $1\033[0m"; }
green() { echo -e "\033[32m\033[01m[INFO] $1\033[0m"; }
yellow() { echo -e "\033[33m\033[01m[NOTICE] $1\033[0m"; }
blue() { echo -e "\033[34m\033[01m[MESSAGE] $1\033[0m"; }
light_magenta() { echo -e "\033[95m\033[01m[NOTICE] $1\033[0m"; }
light_yellow() { echo -e "\033[93m\033[01m[NOTICE] $1\033[0m"; }

# 检查文件传输是否已安装
check_istoreos_style_installed() {
    # 检查luci-app-filetransfer的一些关键文件是否存在
    CHECK_FILES="/usr/lib/lua/luci/controller/filetransfer.lua
/usr/lib/lua/luci/view/filetransfer
/usr/lib/lua/luci/model/cbi/filetransfer"

    # 设置一个标记，用来表示文件是否找到
    FOUND=0

    for FILE in $CHECK_FILES; do
        if [ -e "$FILE" ]; then
            FOUND=1
            break
        fi
    done

    if [ $FOUND -eq 1 ]; then
        echo "luci-app-filetransfer is installed."
    else
        # 先恢复到一键iStoreOS风格化
        wget -O /tmp/restore.sh https://gitee.com/wukongdaily/gl_onescript/raw/master/restore.sh && sh /tmp/restore.sh 
    fi
}

# 恢复标准的iStoreOS
normal_restore() {
    mkdir -p /tmp/upload/restore

    # 优先检查当前目录是否存在 backup.tar.gz
    if [ -f "./backup.tar.gz" ] || [ -f "backup.tar.gz" ]; then
        tar -xzvf backup.tar.gz -C /tmp/upload/restore
    # 若当前目录无，则检查 /tmp/upload/ 目录
    elif [ -f "/tmp/upload/backup.tar.gz" ]; then
        tar -xzvf /tmp/upload/backup.tar.gz -C /tmp/upload/restore
    else
        red "错误：未找到 backup.tar.gz 文件。"
        red "请将文件放在当前目录或 /tmp/upload 目录后重试。"
        exit 1
    fi

    cd /tmp/upload/restore
    # 恢复 overlay
    tar -xzvf overlay_backup.tar.gz -C /
    green "恢复已完成, 系统正在重启....."
    reboot
}

restore() {
    model_info=$(cat /tmp/sysinfo/model)
    green "型号:$model_info"
    case "$model_info" in
    *2500* | *3000* | *6000*)
        check_istoreos_style_installed
        normal_restore
        ;;
    *)
        echo "Router name does not contain '3000', '6000', or '2500'."
        normal_restore
        ;;
    esac
}

restore
