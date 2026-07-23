---
title: Hello Wiki——发布链路测试页
tags:
- meta
created: 2026-07-23
updated: 2026-07-23
---

# Hello Wiki

这是个人知识库 B 阶段发布链路的测试页面。

若你在浏览器里看到本页，说明以下管线全部工作正常：

```text
Obsidian 正式区 → kb publish（门禁+隐私扫描）→ Publish/Wiki → Quartz 构建 → 静态站点
```

- 本页由 `kb publish` 生成公开母稿，内部元数据（confidentiality 等）已剥离；
- 内部链接（如 架构方案）会被转换为纯文本；
- 私有内容永远不会进入公开仓库——发布区与私人 Vault 物理隔离。
