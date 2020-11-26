#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:dakang824/dakang824.github.io.git
else
  msg='来自github actions的自动部署'
  githubUrl=https://dakang824:${GITHUB_TOKEN}@github.com/dakang824/dakang824.github.io.git
  git config --global user.name "yukang"
  git config --global user.email "18790336164@163.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github


# # 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:dakang824/dakang824.github.io.git master

cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist