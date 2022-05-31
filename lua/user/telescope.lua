local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

local actions = telescope.actions

telescope.setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    layout_config = {
      horizontal = { width = 0.99 }
      -- other layout configuration here
    },
    layout_strategy = "horizontal",
    mappings = {}
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
})
