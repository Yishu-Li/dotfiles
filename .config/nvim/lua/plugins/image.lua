return {
  "3rd/image.nvim",
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    window_overlap_clear_enabled = true,
    integrations = {
      markdown = {
        only_render_image_at_cursor = true,
        only_render_image_at_cursor_mode = "popup",
      },
    },
    -- Recommended by molten-nvim
    max_width = 100, -- tweak to preference
    max_height = 12, -- ^
    max_height_window_percentage = math.huge, -- this is necessary for a good experience
    max_width_window_percentage = math.huge,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  },
}
