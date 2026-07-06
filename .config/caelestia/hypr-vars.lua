local scheme = require("scheme.current")

return {
    -- Applications
    browser                    = "zen-browser",
    editor                     = "nvim",
    fileExplorer               = "nautilus",

    -- Shadows
    shadowEnabled              = false,
    shadowRange                = 20,
    shadowRenderPower          = 3,
    shadowColour               = "rgba(" .. scheme.surface .. "d4)",

    -- Gaps
    windowGapsIn               = 0,
    windowGapsOut              = 2,
    singleWindowGapsOut        = 1,

    -- Window styling
    windowRounding             = 10,
    windowBorderSize           = 3,
    activeWindowBorderColour   = "rgba(" .. scheme.pink .. "ff)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",

    -- Cursor
    cursorTheme                = "Adwaita",
    cursorSize                 = 24,

    -- Workspace keybinds
    kbMoveWinToWs              = "SUPER + SHIFT",
    kbNextWs                   = "SUPER + bracketright",
    kbPrevWs                   = "SUPER + bracketleft",

    -- Window action keybinds
    kbWindowFullscreen         = "SUPER + ALT + F",
    kbWindowBorderedFullscreen = "SUPER + F",
    kbToggleWindowFloating     = "SUPER + Space",
    kbCloseWindow              = "SUPER + Backspace",

    -- Application keybinds
    kbTerminal                 = "SUPER + Return",
    kbBrowser                  = "SUPER + B",
    kbEditor                   = "SUPER + C",
    kbFileExplorer             = "SUPER + E",

    -- Locking
    kbLock                     = "CTRL + ALT + SUPER + L",
}
