#!/bin/bash
# 自动同步游戏更新到 GitHub Pages
# 用法: ./update.sh "更新说明（可选）"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 同步文件
cp 自游小村.html index.html

# 检查是否有变更
if git diff --quiet index.html 2>/dev/null && git diff --cached --quiet index.html 2>/dev/null; then
  echo "没有检测到变更，无需更新。"
  exit 0
fi

# 提交并推送
git add index.html
MSG="${1:-update: 更新游戏版本}"
git commit -m "$MSG"
git push

echo "✅ 已更新！GitHub Pages 将在 1-2 分钟内生效。"
echo "🔗 https://hevani126.github.io/pixel-island-game/"
