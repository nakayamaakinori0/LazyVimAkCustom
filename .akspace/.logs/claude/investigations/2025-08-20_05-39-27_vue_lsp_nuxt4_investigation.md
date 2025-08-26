# Vue LSP Nuxt4対応調査

## 調査日時
2025-08-20 05:39:27

## 概要
Nuxt4対応のためのVue Language Serverの設定調査

## 現在の状況

### インストール済みLSP (Mason)
- `vetur-vls`: 古いVue Language Server（Nuxt4非対応）
- `typescript-language-server`: TypeScript対応
- `intelephense`: PHP専用

### Mason利用可能パッケージ
- ✅ `vue-language-server`: 最新のVue Language Tools
- ❌ `volar`: 利用不可
- ❓ `vtsls`: チェック中にタイムアウト

### 現在のLSP設定
- `lua/plugins/code/mason-lspconfig.lua`: PHP (intelephense) のみ設定
- Vue専用のLSP設定なし

## 技術的制約の発見

### VSCode拡張機能 vs LSP サーバーの違い
- **VSCode拡張版vue-language-tools**: Nuxt4完全対応、最新機能利用可能
- **スタンドアロンLSPサーバー**: 機能制限あり、Nuxt4の一部機能に対応していない

### 検証結果
1. Mason経由の`vue-language-server`でもNuxt4の最新機能には不十分
2. VSCode拡張機能の高度な機能はVSCode専用APIに依存
3. Language Server Protocol経由では同等の機能を提供できない

## 最終結論

**Vim/NeovimでのNuxt4完全対応は現時点で技術的に不可能**

### 理由
- vue-language-toolsのVSCode拡張機能はVSCode専用アーキテクチャに依存
- スタンドアロンLSPサーバーは機能制限がある
- Nuxt4の最新機能を完全サポートするのはVSCode拡張版のみ

### 対応方針
**VSCodeでの開発に移行** - 開発効率とNuxt4完全対応を優先

### 今後の期待
vue-language-toolsチームによるスタンドアロンLSPサーバーの機能改善を待つ