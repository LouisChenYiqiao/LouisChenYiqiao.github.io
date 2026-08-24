# LouisQiao · 个人主页

这是我的个人主页源码仓库，通过 GitHub Pages 发布。

- 线上地址：<https://louischenyiqiao.github.io>
- 仓库地址：<https://github.com/LouisChenYiqiao/LouisChenYiqiao.github.io>

## 目录结构

```
.
├── index.html          # 网站首页（单一页面，含导航/关于/工作/联系四个区块）
├── assets/
│   ├── css/
│   │   └── style.css   # 全站样式表
│   └── images/         # 图片素材（个人照片、favicon 等）
├── docs/               # 维护文档
│   └── 维护说明.md
└── README.md
```

## 技术栈

- 纯手写 HTML + CSS，无任何第三方框架或构建工具依赖。
- 响应式设计，适配桌面与移动端。
- 部署在 GitHub Pages。

## 本地预览

无需任何依赖，直接打开 `index.html` 即可；或启动一个本地静态服务器：

```bash
python3 -m http.server 8000
```

然后访问 <http://localhost:8000>。

## 更新与部署

1. 修改 `index.html` 或 `assets/` 下的文件。
2. 提交并推送到 `main` 分支：

```bash
git add -A
git commit -m "更新内容"
git push
```

3. GitHub Pages 会自动从 `main` 分支根目录重新发布网站。

详细说明见 [`docs/维护说明.md`](docs/维护说明.md)。
