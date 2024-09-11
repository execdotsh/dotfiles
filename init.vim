" enable builtin goodies
syntax on
filetype plugin on
filetype indent plugin on

" general settings
set autochdir
set autoindent
set backspace=2
set belloff=all
set clipboard=
set completeopt=longest,menuone
set copyindent
set encoding=utf-8
set fileencoding=utf-8
set hlsearch
set ignorecase
set incsearch
set laststatus=2 
set list
set listchars=tab:»\ ,space:·
set nobackup
set noexpandtab
set noswapfile
set nowrap
set number
set preserveindent
set relativenumber
set scrolloff=7
set shiftwidth=4
set showcmd 
set showtabline=0
set smartcase
set smartindent
set smartindent
set smarttab
set softtabstop=0
set tabstop=4
set termguicolors
set updatetime=100
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" Reverse the lines of the whole file or a visually highlighted block.
	" :Rev is a shorter prefix you can use.
	" Adapted from http://tech.groups.yahoo.com/group/vim/message/34305
	" stolen from: https://superuser.com/questions/189947/how-do-i-reverse-selected-lines-order-in-vim
command! -nargs=0 -bar -range=% Reverse
	\       let save_mark_t = getpos("'t")
	\<bar>      <line2>kt
	\<bar>      exe "<line1>,<line2>g/^/m't"
	\<bar>  call setpos("'t", save_mark_t)

" gui settings
if has("gui_running")
	if has("gui_win32")
		set guifont=CaskaydiaCove_NFM:h10
		set renderoptions=type:directx
	else
		set guifont=CaskaydiaCove\ NF\ 10
	endif
	set guioptions=
endif

" nvim
if has('nvim')
	call plug#begin()
	Plug 'airblade/vim-gitgutter'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
	if !has("win32")
		Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	endif
	Plug 'projekt0n/github-nvim-theme'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'nvim-tree/nvim-tree.lua'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'tpope/vim-fugitive'
	Plug 'ojroques/nvim-osc52'
	Plug 'Asheq/close-buffers.vim'
	call plug#end()
	lua require('github-theme').setup({})
	colorscheme github_dark_high_contrast
	"" NvimTree
	lua require("nvim-tree").setup({
		\ 	on_attach = function(bufnr)
		\ 		local api = require('nvim-tree.api')
		\ 		
		\ 		local function opts(desc)
		\ 			return {
		\ 				desc = 'nvim-tree: ' .. desc,
		\ 				buffer = bufnr,
		\ 				noremap = true,
		\ 				silent = true,
		\ 				nowait = true,
		\ 			}
		\ 		end
		\ 		vim.keymap.set('n', '<C-]>',   api.tree.change_root_to_node,        opts('CD'))
		\ 		vim.keymap.set('n', '<C-r>',   api.fs.rename_sub,                   opts('Rename: Omit Filename'))
		\ 		vim.keymap.set('n', '<C-t>',   api.node.open.tab,                   opts('Open: New Tab'))
		\ 		vim.keymap.set('n', '<C-v>',   api.node.open.vertical,              opts('Open: Vertical Split'))
		\ 		vim.keymap.set('n', '<C-x>',   api.node.open.horizontal,            opts('Open: Horizontal Split'))
		\ 		vim.keymap.set('n', '<BS>',    api.node.navigate.parent_close,      opts('Close Directory'))
		\ 		vim.keymap.set('n', '<CR>',    api.node.open.edit,                  opts('Open'))
		\ 		vim.keymap.set('n', '>',       api.node.navigate.sibling.next,      opts('Next Sibling'))
		\ 		vim.keymap.set('n', '<',       api.node.navigate.sibling.prev,      opts('Previous Sibling'))
		\ 		vim.keymap.set('n', '.',       api.node.run.cmd,                    opts('Run Command'))
		\ 		vim.keymap.set('n', '-',       api.tree.change_root_to_parent,      opts('Up'))
		\ 		vim.keymap.set('n', 'a',       api.fs.create,                       opts('Create File Or Directory'))
		\ 		vim.keymap.set('n', 'bd',      api.marks.bulk.delete,               opts('Delete Bookmarked'))
		\ 		vim.keymap.set('n', 'bt',      api.marks.bulk.trash,                opts('Trash Bookmarked'))
		\ 		vim.keymap.set('n', 'bmv',     api.marks.bulk.move,                 opts('Move Bookmarked'))
		\ 		vim.keymap.set('n', 'B',       api.tree.toggle_no_buffer_filter,    opts('Toggle Filter: No Buffer'))
		\ 		vim.keymap.set('n', 'c',       api.fs.copy.node,                    opts('Copy'))
		\ 		vim.keymap.set('n', 'C',       api.tree.toggle_git_clean_filter,    opts('Toggle Filter: Git Clean'))
		\ 		vim.keymap.set('n', '[c',      api.node.navigate.git.prev,          opts('Prev Git'))
		\ 		vim.keymap.set('n', ']c',      api.node.navigate.git.next,          opts('Next Git'))
		\ 		vim.keymap.set('n', 'd',       api.fs.remove,                       opts('Delete'))
		\ 		vim.keymap.set('n', 'D',       api.fs.trash,                        opts('Trash'))
		\ 		vim.keymap.set('n', 'E',       api.tree.expand_all,                 opts('Expand All'))
		\ 		vim.keymap.set('n', 'e',       api.fs.rename_basename,              opts('Rename: Basename'))
		\ 		vim.keymap.set('n', ']e',      api.node.navigate.diagnostics.next,  opts('Next Diagnostic'))
		\ 		vim.keymap.set('n', '[e',      api.node.navigate.diagnostics.prev,  opts('Prev Diagnostic'))
		\ 		vim.keymap.set('n', 'F',       api.live_filter.clear,               opts('Live Filter: Clear'))
		\ 		vim.keymap.set('n', 'f',       api.live_filter.start,               opts('Live Filter: Start'))
		\ 		vim.keymap.set('n', 'g?',      api.tree.toggle_help,                opts('Help'))
		\ 		vim.keymap.set('n', 'gy',      api.fs.copy.absolute_path,           opts('Copy Absolute Path'))
		\ 		vim.keymap.set('n', 'ge',      api.fs.copy.basename,                opts('Copy Basename'))
		\ 		vim.keymap.set('n', 'H',       api.tree.toggle_hidden_filter,       opts('Toggle Filter: Dotfiles'))
		\ 		vim.keymap.set('n', 'I',       api.tree.toggle_gitignore_filter,    opts('Toggle Filter: Git Ignore'))
		\ 		vim.keymap.set('n', 'J',       api.node.navigate.sibling.last,      opts('Last Sibling'))
		\ 		vim.keymap.set('n', 'K',       api.node.navigate.sibling.first,     opts('First Sibling'))
		\ 		vim.keymap.set('n', 'L',       api.node.open.toggle_group_empty,    opts('Toggle Group Empty'))
		\ 		vim.keymap.set('n', 'M',       api.tree.toggle_no_bookmark_filter,  opts('Toggle Filter: No Bookmark'))
		\ 		vim.keymap.set('n', 'm',       api.marks.toggle,                    opts('Toggle Bookmark'))
		\ 		vim.keymap.set('n', 'o',       api.node.open.edit,                  opts('Open'))
		\ 		vim.keymap.set('n', 'O',       api.node.open.no_window_picker,      opts('Open: No Window Picker'))
		\ 		vim.keymap.set('n', 'p',       api.fs.paste,                        opts('Paste'))
		\ 		vim.keymap.set('n', 'P',       api.node.navigate.parent,            opts('Parent Directory'))
		\ 		vim.keymap.set('n', 'q',       api.tree.close,                      opts('Close'))
		\ 		vim.keymap.set('n', 'r',       api.fs.rename,                       opts('Rename'))
		\ 		vim.keymap.set('n', 'R',       api.tree.reload,                     opts('Refresh'))
		\ 		vim.keymap.set('n', 's',       api.node.run.system,                 opts('Run System'))
		\ 		vim.keymap.set('n', 'S',       api.tree.search_node,                opts('Search'))
		\ 		vim.keymap.set('n', 'u',       api.fs.rename_full,                  opts('Rename: Full Path'))
		\ 		vim.keymap.set('n', 'U',       api.tree.toggle_custom_filter,       opts('Toggle Filter: Hidden'))
		\ 		vim.keymap.set('n', 'W',       api.tree.collapse_all,               opts('Collapse'))
		\ 		vim.keymap.set('n', 'x',       api.fs.cut,                          opts('Cut'))
		\ 		vim.keymap.set('n', 'y',       api.fs.copy.filename,                opts('Copy Name'))
		\ 		vim.keymap.set('n', 'Y',       api.fs.copy.relative_path,           opts('Copy Relative Path'))
		\ 		vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
		\ 		vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
		\ 	end,
		\ 	view = {
		\ 		width = 50,
		\ 		side = "right",
		\ 	},
		\ })
	"" LuaLine
	lua local show_filename = function(str, ctx)
		\ 	local path = vim.fn.expand("%:p")
		\ 	if type(path) ~= "string" or #path < 1 then
		\ 		path = "[new]"
		\ 	end
		\ 	local leave_space_for = 1
		\ 	local hide_below = 5
		\ 	local max_width = vim.fn.winwidth(ctx.tabnr) - leave_space_for
		\ 	if max_width < hide_below then
		\ 		return ""
		\ 	end
		\ 	if #path <= max_width then
		\ 		return path
		\ 	end
		\ 	return "<"..path:sub(#path - max_width)
		\ end
		\ require("lualine").setup({
		\ 	options = {
		\ 		theme = "github_dark_high_contrast",
		\ 	},
		\ 	sections = {
		\ 		lualine_a = {{
		\ 			"filename",
		\ 			fmt = show_filename
		\ 		}},
		\ 		lualine_b = {},
		\ 		lualine_c = {},
		\ 		lualine_x = {},
		\ 		lualine_y = {},
		\ 		lualine_z = {},
		\ 	},
		\ 	inactive_sections = {
		\ 		lualine_a = {{
		\ 			"filename",
		\ 			fmt = show_filename
		\ 		}},
		\ 		lualine_b = {},
		\ 		lualine_c = {},
		\ 		lualine_x = {},
		\ 		lualine_y = {},
		\ 		lualine_z = {},
		\ 	},
		\ 	inactive_winbar = {},
		\ 	winbar = {},
		\ 	tabline = {
		\ 		lualine_a = {"mode"},
		\ 		lualine_b = {"branch", "diff", "diagnostics"},
		\ 		lualine_c = {"encoding", "fileformat", "filetype"},
		\ 		lualine_x = {"progress"},
		\ 		lualine_y = {"location"},
		\ 		lualine_z = {"tabs"},
		\ 	},
		\ })
	"" Telescope
	lua require("telescope").setup({
		\ 	defaults = {
		\ 		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
		\ 	},
		\ })
		\ function live_grep_git_dir()
		\ 	local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
		\ 	git_dir = string.gsub(git_dir, "\n", "")
		\ 	local opts = {
		\ 		cwd = git_dir,
		\ 	}
		\ 	require('telescope.builtin').live_grep(opts)
		\ end
	"" OSC52
	lua do
		\ 	require('osc52').setup({
		\ 		max_length = 0,
		\ 		silent = false,
		\ 		trim = false,
		\ 		tmux_passthrough = true,
		\ 	})
		\ 	local function copy(lines, _)
		\ 		require('osc52').copy(table.concat(lines, '\n'))
		\ 	end
		\ 	local function paste()
		\ 		return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
		\ 	end
		\ 	vim.g.clipboard = {
		\ 		name = 'osc52',
		\ 		copy = {['+'] = copy, ['*'] = copy},
		\ 		paste = {['+'] = paste, ['*'] = paste},
		\ 	}
		\ end
	"" disable netrw
	let g:loaded_netrw=1
	let g:loaded_netrwPlugin=1
	let g:netrw_banner=0
	autocmd TabLeave * NvimTreeClose
else
	call plug#begin()
	Plug 'catppuccin/vim', { 'as': 'catppuccin' }
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'Asheq/close-buffers.vim'
	call plug#end()
	colorscheme catppuccin_mocha
endif

" maps
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> <Esc>h <c-w><s-h>
nnoremap <silent> <Esc>j <c-w><s-j>
nnoremap <silent> <Esc>k <c-w><s-k>
nnoremap <silent> <Esc>l <c-w><s-l>
let mapleader=' '
let maplocalleader=' '
nnoremap <silent> <leader>t <c-w><s-t>
nnoremap <silent> <leader>o <c-w>o
nnoremap <silent> <leader>s <c-w>s
nnoremap <silent> <leader>v <c-w>v
nnoremap <silent> <leader>q :quit<cr>
nnoremap <silent> <leader>n :tabnew<cr>
nnoremap <silent> <tab> :tabnext<cr>
nnoremap <silent> <s-tab> :tabprevious<cr>
nnoremap <silent> <bs> :tabmove -1<cr>
nnoremap <silent> <leader>nh :nohlsearch<cr>
nnoremap <silent> <leader>ct :terminal<cr>
"" close-buffers
nnoremap <silent> <leader>d :Bdelete menu<CR>
"" fugitive
nnoremap <silent> <leader>gs :Git<cr>
nnoremap <silent> <leader>gl :Git log --oneline<cr>
nnoremap <silent> <leader>gL :Git log --oneline %<cr>
nnoremap <silent> <leader>gb :Git blame<cr>
nnoremap <leader>gg :Git grep 
nnoremap <leader>gG :Git grep -in 
nnoremap <silent> <leader>gw yw:Git grep <c-f>p<cr>
nnoremap <silent> <leader>gW yw:Git grep -in <c-f>p<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
"" NvimTree
nnoremap <silent> <leader>to :NvimTreeFocus<CR>
nnoremap <silent> <leader>tt :NvimTreeToggle<CR>
nnoremap <silent> <leader>tf :NvimTreeFindFile<CR>
"" Telescope
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <silent> <leader>fg :lua live_grep_git_dir()<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
"" COC
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gn <Plug>(coc-rename)

" file type settings
autocmd FileType python
	\ setlocal noexpandtab ts=4 sw=4
autocmd Filetype c,cpp
	\ syntax match Type /\<\w*_t\>/   |
	\ syntax match Macro /\<\w*_m\>/  |
	\ syntax match Define /\<\w*_d\>/ |
	\ setlocal cc=80
autocmd Filetype as,asm
	\ setlocal syntax=masm ts=10 sw=10
autocmd Filetype htm,html
	\ setlocal ts=2 sw=2
autocmd Filetype fugitive
	\ setlocal nonumber norelativenumber 

"" GitGutter
let g:gitgutter_max_signs = 2000

" force write
command W w !sudo tee %

" git WIP
command Wip   Git add --all | G commit -m 'WIP'
command Unwip Git reset HEAD~1
