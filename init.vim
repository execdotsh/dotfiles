" enable builtin goodies
syntax on
filetype plugin on
filetype indent plugin on

" plugin manager
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'Asheq/close-buffers.vim'
call plug#end()

" general settings
set autochdir
set autoindent
set backspace=2
set belloff=all
set clipboard+=unnamedplus
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
if has("gui_running")
	if has("gui_win32")
		set guifont=CaskaydiaCove_NFM:h10
		set renderoptions=type:directx
	else
		set guifont=CaskaydiaCove\ NF\ 10
	endif
	set guioptions=
endif

" theme
lua require("catppuccin").setup({
	\		transparent_background = false,
	\		term_colors = true,
	\	})
colorscheme catppuccin-mocha

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
nnoremap <silent> <leader>nh :nohlsearch<cr>
nnoremap <silent> <leader>ct :terminal<cr>
"" close-buffers
nnoremap <silent> <leader>d :Bdelete menu<CR>
"" fugitive
nnoremap <silent> <leader>gs :Git<cr>
nnoremap <silent> <leader>gl :Git log<cr>
nnoremap <leader>gg :Git grep 
nnoremap <leader>gG :Git grep -in 
nnoremap <silent> <leader>gw yw:Git grep <c-f>p<cr>
nnoremap <silent> <leader>gW yw:Git grep -in <c-f>p<cr>
"" NvimTree
nnoremap <silent> <leader>to :NvimTreeFocus<CR>
nnoremap <silent> <leader>tt :NvimTreeToggle<CR>
nnoremap <silent> <leader>tf :NvimTreeFindFile<CR>
"" Telescope
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
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

" plugins / maps and config
"" NvimTree
lua require("nvim-tree").setup({
	\ 	view = {
	\ 		width = 50,
	\ 		side = "right",
	\ 	},
	\ })
"" LuaLine
lua require("lualine").setup({
	\ options = {
	\ 		theme = "catppuccin",
	\ 		disabled_filetypes = { "NvimTree" },
	\ 	},
	\ 	sections = {
	\ 		lualine_a = {"mode"},
	\ 		lualine_b = {"branch", "diff", "diagnostics"},
	\ 		lualine_c = {},
	\ 		lualine_x = {"encoding", "fileformat", "filetype"},
	\ 		lualine_y = {"progress"},
	\ 		lualine_z = {"location"}
	\ 	},
	\ 	inactive_winbar = {
	\ 		lualine_a = {"%F"},
	\ 		lualine_b = {},
	\ 		lualine_c = {},
	\ 		lualine_x = {},
	\ 		lualine_y = {},
	\ 		lualine_z = {},
	\ 	},
	\ 	winbar = {
	\ 		lualine_a = {"%F"},
	\ 		lualine_b = {},
	\ 		lualine_c = {},
	\ 		lualine_x = {},
	\ 		lualine_y = {},
	\ 		lualine_z = {"tabs"},
	\ 	},
	\ })
"" Telescope
lua require("telescope").setup({
	\ 	defaults = {
	\ 		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
	\ 	},
	\ })
"" netrw
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let g:netrw_banner=0
"" GitGutter
let g:gitgutter_max_signs = 2000

"force write
command W w !sudo tee %

