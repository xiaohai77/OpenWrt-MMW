include $(TOPDIR)/rules.mk

PKG_NAME:=miaomiaowu
# TODO: 和 build-ipk.sh 里传的 VERSION 保持一致
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

# $(PKGARCH) 就是 opkg Architecture 字段的值(aarch64_cortex-a53 之类)，
# 正好和 build-ipk-repo.sh 生成的 openwrt-ipk/<arch>/ 目录名一致
PKG_SOURCE_URL:=https://miaomiaowu-openwrt.445568.xyz/openwrt-ipk/$(PKGARCH)
PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION)_$(PKGARCH).ipk
PKG_SOURCE_PROTO:=default
# 建议换成真实 sha256，先用 skip 跑通流程
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
