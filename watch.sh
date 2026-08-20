#!/bin/bash
# 监听自游小村.html 变更，自动同步到 GitHub Pages
# 用法: ./watch.sh (后台运行，Ctrl+C 停止)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "👀 正在监听自游小村.html 的变更..."
echo "   修改文件后将自动提交并推送到 GitHub Pages"
echo "   按 Ctrl+C 停止监听"
echo ""

LAST_MTIME=$(stat -c %Y "自游小村.html" 2>/dev/null || stat -f %m "自游小村.html" 2>/dev/null)

while true; do
  sleep 3
  CURRENT_MTIME=$(stat -c %Y "自游小村.html" 2>/dev/null || stat -f %m "自游小村.html" 2>/dev/null)

  if [ "$CURRENT_MTIME" != "$LAST_MTIME" ]; then
    echo "🔄 检测到文件变更，正在同步..."
    cp 自游小村.html index.html
    git add index.html

    if ! git diff --cached --quiet; then
      git commit -m "auto: 更新游戏版本 $(date '+%Y-%m-%d %H:%M:%S')"
      git push
      echo "✅ 已自动更新！$(date '+%H:%M:%S')"
      echo "🔗 https://hevani126.github.io/pixel-island-game/"
    else
      echo "ℹ️  无实际代码变更，跳过。"
    fi

    LAST_MTIME=$CURRENT_MTIME
    echo ""
    echo "👀 继续监听中..."
  fi
done
