local wezterm = require("wezterm")

-- 共通設定
local config = {

    -- 全体設定
    scrollback_lines = 10000, -- コマンド履歴の最大行数
    enable_wayland = false, -- X11 を利用しているので
    warn_about_missing_glyphs = false, -- フォントについての警告を表示しない
    -- enable_scroll_bar = true, -- スクロールバーを表示する
    -- 端まで描写されないときは Ctrl + Shift + r で設定ファイルをリロードすると直る

    -- 外観設定
    color_scheme = "Gruvbox dark, medium (base16)", -- テーマ( AyuDark (Gogh), MonokaiDark (Gogh) )
    font = wezterm.font("HackGen Console NF", { weight = "Regular", stretch = "Normal", italic = false }), -- フォント
    font_size = 13.0, -- フォントサイズ
    adjust_window_size_when_changing_font_size = false, -- フォントサイズ変更時にウィンドウサイズも変更されないようにする
    hide_tab_bar_if_only_one_tab = true, -- タブが1つのときはタブバーを隠す
    initial_cols = 185, -- 列数
    initial_rows = 50, --行数
    default_cursor_style = "SteadyBar", -- カーソルの形を点滅しないバーにする (点滅は GPU へ負荷がかかる)

    -- マルチプレクサ
    -- tmux でも同様だがマルチプレクサを利用すると TUI ファイルマネージャーでプレビューが使えない
    --[[unix_domains = {
        {
	    name = "unix",
	},
    },
    default_gui_startup_args = { "connect", "unix" },]]

    -- キーバインド設定 (最小限にする)
    -- disable_default_key_bindings = true,
    leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }, -- Ctrl + s をリーダーキーとして設定する
    keys = {

	-- 検索
	{ key = "/", mods = "LEADER", action = wezterm.action({ Search = { CaseInSensitiveString = "" } }) },

	-- ペイン
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{ key = "p", mods = "LEADER", action = wezterm.action.PaneSelect },
	{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "h", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "j", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "k", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "l", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "q", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

	-- タブ
	{ key = "t", mods = "LEADER", action = wezterm.action({ ShowLauncherArgs = { flags = "LAUNCH_MENU_ITEMS|DOMAINS" } }), },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "q", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },

	-- コピーモード
	{ key = "v", mods = "LEADER|SHIFT", action = wezterm.action.ActivateCopyMode },
        { key = "y", mods = "LEADER|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
        { key = "p", mods = "LEADER|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

    },
}

return config
