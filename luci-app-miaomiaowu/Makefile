include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-miaomiaowu

# 跟 miaomiaowu 后端 Makefile 同一个思路：编译时直接从你自己发布的
# Packages 索引里动态取这个包当前真实发布的版本号，不用每次手动改。
# 这个包本身是 arch:all，但索引文件是按具体架构目录发的，随便用
# ARCH_PACKAGES 对应的那份就行，里面同样有 luci-app-miaomiaowu 这条记录
# （build-ipk-repo.sh 打包时会把这个包一起拷进每个架构目录）。
PKG_VERSION:=$(strip $(shell wget -qO- "https://miaomiaowu-openwrt.445568.xyz/openwrt-ipk/$(ARCH_PACKAGES)/Packages" 2>/dev/null | \
	awk '/^Package: luci-app-miaomiaowu$$/{f=1;next} f&&/^Version:/{print $$2;exit} /^$$/{f=0}'))
ifeq ($(PKG_VERSION),)
  # 取不到就给个明显能看出问题的假值，让编译在后面报错，而不是
  # 悄悄用一个错误的版本号把包发出去
  PKG_VERSION:=0.0.0-VERSION-FETCH-FAILED
endif
PKG_RELEASE:=1

PKG_MAINTAINER:=第十六夜月
PKG_LICENSE:=MIT

LUCI_TITLE:=LuCI support for miaomiaowu (妙妙屋)
LUCI_DEPENDS:=+miaomiaowu

# luci.mk 会自动把这个 Makefile 同级目录下的 ./root 和 ./htdocs
# 原样装进最终 ipk，不用写 Build/Prepare、不用下载、不用写 Package/install。
# 这正好对应你仓库里已有的 luci-app-miaomiaowu/root 和 luci-app-miaomiaowu/htdocs。
include $(TOPDIR)/feeds/luci/luci.mk

ifeq ($(PKG_VERSION),0.0.0-VERSION-FETCH-FAILED)
  # 之前 substore 那次踩过坑：luci.mk 这种 arch:all 包会跳过
  # Build/Prepare 阶段，写在那里的检查根本不会被执行到。这里改成用
  # Make 的 $(error) 在解析 Makefile 的当下就直接报错终止，保证真的生效。
  $(error 没能从 https://miaomiaowu-openwrt.445568.xyz/openwrt-ipk/$(ARCH_PACKAGES)/Packages 取到版本号，请检查该 URL 是否能访问，以及 Packages 里是不是真有 luci-app-miaomiaowu 这个条目)
endif

$(eval $(call BuildPackage,luci-app-miaomiaowu))
