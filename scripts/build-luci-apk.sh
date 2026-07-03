#!/bin/bash
# 用法: build-luci-apk.sh <apk二进制路径> <version> <输出目录> <签名私钥pem路径>
set -euo pipefail

APK_BIN="$1"
VERSION="$2"
OUTDIR="$3"
SIGN_KEY="$4"
PKG_NAME="luci-app-miaomiaowu"
SRC="luci-app-miaomiaowu"

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

ROOT="$WORK/root"
mkdir -p "$ROOT"
cp -r "$SRC/root/." "$ROOT/"
mkdir -p "$ROOT/www/luci-static"
cp -r "$SRC/htdocs/luci-static/." "$ROOT/www/luci-static/"
mkdir -p "$ROOT/lib/apk/packages"

# ---- 文件清单：必须最后生成，否则会把自己也列进去 ----
(cd "$ROOT" && find . -type f,l -printf '/%P\n') > "$ROOT/lib/apk/packages/${PKG_NAME}.list"

# ---- post-install：装完自动清 LuCI 缓存 + reload rpcd，网页刷新一下就能看到新菜单和权限 ----
POSTINSTALL="$WORK/post-install"
cat > "$POSTINSTALL" <<'POSTINSTALL_EOF'
#!/bin/sh
[ -n "$IPKG_INSTROOT" ] && exit 0

# 清理 LuCI 索引/模块缓存，让新菜单立即显示，不用等重启
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/

# 重新加载 rpcd，让新装的 acl.d/*.json 立即生效
# （不这么做的话，在 miaomiaowu 之后装本包时，ACL 权限要等下次
#  rpcd 重启/路由器重启才会被识别，网页上可能会短暂出现权限相关报错）
[ -x /etc/init.d/rpcd ] && /etc/init.d/rpcd reload >/dev/null 2>&1

exit 0
POSTINSTALL_EOF
chmod 0755 "$POSTINSTALL"

mkdir -p "$OUTDIR"
OUT="$OUTDIR/${PKG_NAME}_${VERSION}_all.apk"

fakeroot "$APK_BIN" mkpkg \
  --info "name:$PKG_NAME" \
  --info "version:$VERSION" \
  --info "description:LuCI support for 妙妙屋 (miaomiaowu)" \
  --info "arch:noarch" \
  --info "license:MIT" \
  --info "origin:$PKG_NAME" \
  --info "maintainer:第十六夜月" \
  --info "depends:luci-base miaomiaowu" \
  --script "post-install:$POSTINSTALL" \
  --files "$ROOT" \
  --output "$OUT" \
  --sign "$SIGN_KEY"

echo "生成: $OUT"
