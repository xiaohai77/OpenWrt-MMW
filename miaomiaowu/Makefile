include $(TOPDIR)/rules.mk

PKG_NAME:=miaomiaowu
# TODO: 和 build-ipk.sh 里传的 VERSION 保持一致
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

# 注意: 这里必须用 $(ARCH_PACKAGES)，不能用 $(PKGARCH)。
# $(PKGARCH) 是 include/package-defaults.mk 里根据 $(ARCH_PACKAGES) 派生出来的，
# 而这个派生动作发生在下面 `include $(INCLUDE_DIR)/package.mk` 之后。
# PKG_SOURCE_URL / PKG_SOURCE 用的是 `:=`（立即展开），在这两行执行的那一刻
# $(PKGARCH) 还没被定义，会被当场求值成空字符串，并且这个空值不会再更新。
# 而 $(ARCH_PACKAGES) 在最上面 include rules.mk 时就已经根据目标平台
# （比如 aarch64_cortex-a53）赋好值了，所以这里改用它。
PKG_SOURCE_URL:=https://miaomiaowu-openwrt.445568.xyz/openwrt-ipk/$(ARCH_PACKAGES)
PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION)_$(ARCH_PACKAGES).ipk
PKG_SOURCE_PROTO:=default
# 建议尽快换成真实 sha256，先用 skip 跑通流程
# 提醒: PKG_HASH:=skip 会导致下载到损坏/404 页面之类的文件时也不会报错，
# 而是把垃圾数据一路传到后面 tar 解压才崩溃（不好定位问题）。
# 等流程跑通后，建议执行一次
#   make package/feeds/miaomiaowu/miaomiaowu/download V=s
# 然后对 dl/ 目录里下载到的文件算 sha256，把真实值填进来。
PKG_HASH:=skip

PKG_MAINTAINER:=第十六夜月
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/miaomiaowu
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Clash 配置订阅管理工具 (妙妙屋后端)
  DEPENDS:=+libc
endef

define Package/miaomiaowu/description
  miaomiaowu 后端服务，配合 luci-app-miaomiaowu 使用
endef

# 直接复用 CI 已经打好、签过名的 ipk，不在编固件时重新交叉编译 Go
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	tar -xzf $(DL_DIR)/$(PKG_SOURCE) -O ./data.tar.gz | tar -xzC $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/miaomiaowu/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/mmw $(1)/usr/bin/mmw

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/miaomiaowu.init $(1)/etc/init.d/miaomiaowu

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/miaomiaowu.config $(1)/etc/config/miaomiaowu
endef

$(eval $(call BuildPackage,miaomiaowu))
