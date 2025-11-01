# ⚡ Quick Reference Cheatsheet

## Most Important Keybindings

### 🎯 Essential (Learn These First!)
```
Space           → Leader key (press before most commands)
Space + ?       → Show all keybindings (Which-Key)
Ctrl + \        → Toggle terminal
Ctrl + s        → Save file
```

### 🔍 Finding Things
```
<leader> f f    → Find files
<leader> f g    → Search in files (grep)
<leader> f b    → List open buffers
<leader> f r    → Recent files
<leader> e      → Toggle file explorer
```

### 📑 Buffers/Tabs
```
Tab             → Next buffer
Shift + Tab     → Previous buffer
<leader> x      → Close buffer
```

### 🧠 Code Intelligence
```
g d             → Go to definition
K               → Show documentation
<leader> c a    → Code actions
<leader> c r    → Rename
<leader> c f    → Format code
[ d / ] d       → Previous/Next diagnostic
```

### ✏️ Editing
```
g c c           → Comment/uncomment line
g c (visual)    → Comment selection
< / >           → Indent (in visual mode)
J / K (visual)  → Move lines up/down
```

### 🔄 Git
```
<leader> g s    → Stage hunk
<leader> g p    → Preview changes
<leader> g b    → Git blame
] c / [ c       → Next/Previous change
```

### 🪟 Windows
```
Ctrl + h/j/k/l  → Navigate windows
Ctrl + arrows   → Resize windows
```

### 🔧 Diagnostics
```
<leader> t t    → Toggle problems panel
<leader> c d    → Show diagnostic
```

## 💡 Pro Tips

1. **Press `Space` and wait 1 second** → See all available commands
2. **In file explorer, press `?`** → See all commands
3. **In Telescope, use `Ctrl+j/k`** → Navigate results
4. **Use `Ctrl+\` often** → Quick terminal access
5. **`:Git` command** → Interactive git interface

## 🎨 Visual Guide

```
┌─────────────────────────────────────────────┐
│  Bufferline (Tabs)                          │ ← Tab / Shift+Tab
├──────┬──────────────────────────────────────┤
│      │                                      │
│ File │  Your Code Here                      │
│ Tree │                                      │
│      │  Use Space+ff to find files          │ ← Telescope
│ Use  │  Use Space+fg to search text         │
│ <L>e │                                      │
│      │  LSP: gd for definition              │ ← LSP
│      │       K for docs                     │
│      │                                      │
├──────┴──────────────────────────────────────┤
│  Terminal (Ctrl+\)                          │ ← Toggleterm
├─────────────────────────────────────────────┤
│  Statusline (Git branch, mode, file info)   │ ← Lualine
└─────────────────────────────────────────────┘
```

## 🚀 Getting Started Workflow

1. **Open Neovim**: `nvim`
2. **Open file explorer**: `Space + e`
3. **Find a file**: `Space + f + f`
4. **Search in files**: `Space + f + g`
5. **Edit code**: Use LSP features (`gd`, `K`, etc.)
6. **Save**: `Ctrl + s`
7. **Git status**: `:Git`
8. **Open terminal**: `Ctrl + \`
9. **Close buffer**: `Space + x`

## 📝 Common Commands

```
:Mason          → Manage LSP servers
:Lazy           → Manage plugins
:checkhealth    → Check Neovim health
:help <topic>   → Get help on anything
:Git            → Git interface
```

---

**Remember**: The more you use it, the more muscle memory you build! 🎯
