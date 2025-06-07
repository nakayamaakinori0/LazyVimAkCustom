# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コードベースの概要

このリポジトリはLazyVimをベースとしたNeovim設定です。LazyVimのプラグインマネージャー（lazy.nvim）を使用して構築されています。

## アーキテクチャ

### 設定の構造
- `init.lua`: エントリーポイント。`config.lazy`を読み込む
- `lua/config/`: LazyVimの基本設定
  - `lazy.lua`: プラグインマネージャーの設定とプラグインの読み込み
  - `options.lua`: Vimのオプション設定（PHP LSPの設定など）
  - `keymaps.lua`: カスタムキーマップ
  - `autocmds.lua`: オートコマンド
- `lua/plugins/`: カスタムプラグイン設定

### プラグイン管理
LazyVimベースの設定で、プラグインは`lua/plugins/`ディレクトリ内の個別ファイルで管理されています。各ファイルは特定のプラグインまたは機能群を担当しています。

### 主要なカスタムプラグイン
- `telekasten.lua`: Telekasten (Zettelkasten) プラグイン設定
- `avante.lua`: AI支援プラグイン（Gemini/Claude/DeepSeek対応）
- `conform.lua`: コードフォーマッター設定
- `diffview.lua`: Git diff表示
- `scrollbar.lua`: スクロールバー表示
- `vim-bookmarks.lua`: ブックマーク機能

## フォーマット設定

### StyLua（Lua用）
- `stylua.toml`で設定
- インデント: スペース2つ
- 列幅: 120文字

### Conform.nvim
- `<leader>cf`でフォーマット実行
- 自動フォーマットは無効化
- 対応言語: Lua, JavaScript/TypeScript, Vue, Shell, Fish

## カスタムキーマップの主要な変更
- `jj`: インサートモードからノーマルモードへ
- `H`/`L`: 行の最初/最後へ移動
- `Tab`/`Shift-Tab`: バッファ間移動
- `<leader>tk`: Telekastenパネル表示
- `<leader>td`: 現在の日付挿入
- `<leader>gd`: Diffviewの切り替え
- `<leader>fp`: 相対ファイルパス をクリップボードにコピー

## 開発コマンド

このNeovim設定には特別なビルドやテストコマンドはありません。設定の変更後は`:source $MYVIMRC`または Neovim を再起動してください。

## LSP設定
- PHP: Intelephenseを使用（`vim.g.lazyvim_php_lsp = "intelephense"`）