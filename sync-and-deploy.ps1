# BluetoothSpace Wiki 一键发布（方案 V0.3 附录 E.4 步骤 5-9）
# 前置：内容已通过 `kb publish <note>` 生成到 Vault 的 Publish/Wiki/
param([string]$Message = "publish: 内容更新 $(Get-Date -Format 'yyyy-MM-dd HH:mm')")

$ErrorActionPreference = 'Stop'
$Wiki = 'D:\03.person\gws\KnowledgeBase\Publish\Wiki'
$Assets = 'D:\03.person\gws\KnowledgeBase\Publish\Assets'
$Site = $PSScriptRoot

# 1. 同步公开母稿与资产
Get-ChildItem "$Site\content" -Exclude '.gitkeep','index.md' | Remove-Item -Recurse -Force
Copy-Item "$Wiki\*" "$Site\content\" -Recurse -Force -ErrorAction SilentlyContinue
if (Test-Path $Assets) {
    New-Item -ItemType Directory -Force -Path "$Site\content\assets" | Out-Null
    Copy-Item "$Assets\*" "$Site\content\assets\" -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. 本地构建（构建失败则不提交）
Set-Location $Site
npx quartz build
if ($LASTEXITCODE -ne 0) { throw "Quartz 构建失败，已中止发布" }

# 3. 提交并推送（GitHub Actions 自动部署到 gh-pages）
git add content
git commit -m $Message
git push origin main
Write-Host "已推送。GitHub Actions 将自动部署到 https://bluetoothspace.com"
