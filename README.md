妙妙屋（miaomiaowu）- OpenWrt

«妙妙屋 OpenWrt / ImmortalWrt 软件包»

📖 项目介绍

妙妙屋（miaomiaowu）是一款现代化的代理订阅管理平台，支持多种订阅协议解析、节点管理、规则管理及配置转换，可与 Mihomo、Sing-box、Clash 等生态配合使用，为不同客户端生成对应配置。

本仓库提供妙妙屋在 OpenWrt / ImmortalWrt 平台上的安装包及软件源，支持传统 IPK（opkg） 与新版 APK（apk） 两种软件包格式。

✨ 特性

- 📦 同时提供 IPK 与 APK 软件包
- 🚀 一键安装脚本
- 🔄 自动识别设备架构
- 🌍 Cloudflare Pages 软件源
- 🔐 软件包签名验证
- ⚡ GitHub Actions 自动构建与发布
- 📱 支持 OpenWrt 与 ImmortalWrt

📥 一键安装

wget -O - https://miaomiaowu-openwrt.445568.xyz/install.sh | ash

安装脚本会自动：

- 检测系统架构
- 配置妙妙屋软件源
- 更新软件包列表
- 安装妙妙屋应用

🌐 软件源

https://miaomiaowu-openwrt.445568.xyz/

支持自动识别不同 CPU 架构并使用对应的软件仓库。

📦 支持的软件包

- miaomiaowu
- luci-app-miaomiaowu

后续版本将持续同步上游更新，并第一时间提供最新的软件包。

❤️ 致谢

感谢妙妙屋项目原作者及所有贡献者。

本仓库仅负责 OpenWrt / ImmortalWrt 平台的软件包构建、软件源维护及自动发布，不修改项目原有功能。

📄 License

软件包版权归原项目作者所有。

本仓库中的构建脚本、自动发布流程及软件源维护脚本遵循对应许可证，具体请参考仓库 License。
