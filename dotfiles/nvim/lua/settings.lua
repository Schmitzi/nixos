-- General Vim settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.tabstop = 4                -- Tab width
vim.opt.shiftwidth = 4             -- Indent width
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.smartindent = true         -- Auto-indent new lines
vim.opt.wrap = false               -- Disable line wrapping
vim.opt.termguicolors = true       -- Enable 24-bit RGB colors
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
vim.opt.scrolloff = 8              -- Keep 8 lines visible above/below cursor
vim.opt.signcolumn = "yes"         -- Always show sign column
vim.opt.updatetime = 50            -- Faster completion
vim.opt.timeoutlen = 300           -- Which-key delay
vim.opt.mouse = "a"                -- Enable mouse support
vim.opt.splitright = true          -- Vertical splits to the right
vim.opt.splitbelow = true          -- Horizontal splits below
vim.opt.ignorecase = true          -- Ignore case in search
vim.opt.smartcase = true           -- Unless uppercase used
vim.opt.cursorline = true          -- Highlight current line
vim.opt.undofile = true            -- Persistent undo
vim.opt.swapfile = false           -- No swap files
vim.opt.backup = false             -- No backup files

-- Diagnostic icons
local icons = { 
  Error = "✘ ", 
  Warn = "▲ ", 
  Hint = "⚑ ", 
  Info = "» " 
}

-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = false,           -- Disable inline diagnostic text
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.INFO] = icons.Info,
      [vim.diagnostic.severity.HINT] = icons.Hint,
    },
  },
  underline = true,               -- Enable underlining (red squiggly lines)
  update_in_insert = false,       -- Don't update diagnostics in insert mode
  severity_sort = true,           -- Sort diagnostics by severity
  float = {
    border = "rounded",           -- Nice looking borders for floating windows
    source = "always",            -- Always show source of diagnostic
    header = "",
    prefix = "",
  },
})

-- General keybindings (non-plugin specific)
local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save file
keymap("n", "<C-s>", ":w<CR>", { desc = "Save file" })
keymap("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Quit
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Select all
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })
