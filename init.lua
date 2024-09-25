
-- utility

function bufdir()
	return vim.fn.expand("%:p:h")
end

function git_dir()
	local dir = vim.fn.system(
		string.format("git -C %s rev-parse --show-toplevel 2>/dev/null || echo .",
		bufdir())
	)
	return string.gsub(dir, "\n", "")
end

-- general config

--vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.backspace = "2"
vim.opt.belloff = "all"
vim.opt.completeopt = { "longest", "menuone" }
vim.opt.copyindent = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = { ["tab"] = "» ", ["space"] = "·" }
vim.o.backup = false
vim.opt.expandtab = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.preserveindent = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.shiftwidth = 4
vim.opt.showcmd  = true
--vim.opt.showtabline = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 0
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 100
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true
vim.opt.wildignorecase = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- general binds

vim.keymap.set("n", "<c-h>", "<c-w>h", { ["silent"] = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { ["silent"] = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { ["silent"] = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { ["silent"] = true })
vim.keymap.set("n", "<Esc>h", "<c-w><s-h>", { ["silent"] = true })
vim.keymap.set("n", "<Esc>j", "<c-w><s-j>", { ["silent"] = true })
vim.keymap.set("n", "<Esc>k", "<c-w><s-k>", { ["silent"] = true })
vim.keymap.set("n", "<Esc>l", "<c-w><s-l>", { ["silent"] = true })
vim.keymap.set("n", "<leader>n", "<c-w><s-t>", { ["silent"] = true })
vim.keymap.set("n", "<leader>o", "<c-w>o", { ["silent"] = true })
vim.keymap.set("n", "<leader>s", "<c-w>s", { ["silent"] = true })
vim.keymap.set("n", "<leader>v", "<c-w>v", { ["silent"] = true })
vim.keymap.set("n", "<leader>q", ":quit<cr>", { ["silent"] = true })
vim.keymap.set("n", "<tab>", ":tabnext<cr>", { ["silent"] = true })
vim.keymap.set("n", "<s-tab>", ":tabprevious<cr>", { ["silent"] = true })
vim.keymap.set("n", "<bs>", ":tabmove -1<cr>", { ["silent"] = true })
vim.keymap.set("n", "<leader>nh", ":nohlsearch<cr>", { ["silent"] = true })
vim.keymap.set("n", "<leader>ct", ":terminal<cr>", { ["silent"] = true })
vim.keymap.set("n", "<leader>cd", function()
	vim.cmd.cd(bufdir())
	print(vim.cmd.pwd())
end)

-- plugins

require("packer").startup(function(use)

	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		["tag"] = '0.1.2',
		["config"] = function()
			require("telescope").setup({
				["defaults"] = {
					["borderchars"] = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
				},
			})
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', function()
				if not pcall(builtin.git_files, { ["cwd"] = git_dir() }) then
					builtin.find_files()
				end
			end)
			vim.keymap.set('n', '<leader>fc', builtin.find_files)
			vim.keymap.set('n', '<leader>fa', builtin.find_files)
			vim.keymap.set('n', '<leader>fg', function()
				builtin.live_grep({ ["cwd"] = git_dir() })
			end)
			vim.keymap.set('n', '<leader>fd', builtin.live_grep)
			vim.keymap.set('n', '<leader>fb', builtin.buffers)
			vim.keymap.set('n', '<leader>fj', builtin.jumplist)
		end,
	})
	
	use({ "nvim-tree/nvim-web-devicons" })

	use({
		"jiaoshijie/undotree",
		["requires"] = {
			"nvim-lua/plenary.nvim",
		},
		["config"] = function()
			local undotree = require('undotree')
			undotree.setup({
				["float_diff"] = true,
				["layout"] = "left_bottom",
				["position"] = "left",
				["ignore_filetype"] = {
					'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt',
					'spectre_panel', 'tsplayground'
				},
				["window"] = {
					["winblend"] = 30,
				},
				["keymaps"] = {
					['j'] = "move_next",
					['k'] = "move_prev",
					['gj'] = "move2parent",
					['J'] = "move_change_next",
					['K'] = "move_change_prev",
					['<cr>'] = "action_enter",
					['p'] = "enter_diffbuf",
					['q'] = "quit",
				},
			})
			vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })
		end,
	})

	use({
		"neoclide/coc.nvim",
		["branch"] = "release",
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		["branch"] = "v3.x",
		["requires"] = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		["config"] = function()
			require("neo-tree").setup({
				enable_git_status = false,
					["event_handlers"] = {
					{
						["event"] = "file_opened",
						["handler"] = function()
							require("neo-tree.command").execute({ ["action"] = "close" })
						end,
					},
				},
				["window"] = {
					["position"] = "float",
					["mappings"] = {
						['Y'] = function(state)
							local node = state.tree:get_node()
							local filepath = node:get_id()
							local filename = node.name
							local modify = vim.fn.fnamemodify

							local results = {
								filepath,
								modify(filepath, ':.'),
								modify(filepath, ':~'),
								filename,
								modify(filename, ':r'),
								modify(filename, ':e'),
							}

							local i = vim.fn.inputlist({
								'Choose to copy to clipboard:',
								'1. Absolute path: ' .. results[1],
								'2. Path relative to CWD: ' .. results[2],
								'3. Path relative to HOME: ' .. results[3],
								'4. Filename: ' .. results[4],
								'5. Filename without extension: ' .. results[5],
								'6. Extension of the filename: ' .. results[6],
							})

							if i > 0 then
								local result = results[i]
								if not result then return print('Invalid choice: ' .. i) end
								vim.fn.setreg('"', result)
								vim.notify('Copied: ' .. result)
							end
						end
					}
				},
			})
			vim.keymap.set("n", "<leader>tt", function()
				require("neo-tree.command").execute({
					["reveal"] = true,
					["position"] = "float",
				})
			end)
			--[[
			vim.api.nvim_create_autocmd('BufLeave', {
				["callback"] = function(ev)
					require("neo-tree.command").execute({ ["action"] = "close" })
				end,
			})
			--]]
		end,
	})

	use("nvim-lua/plenary.nvim")

	use({
		"projekt0n/github-nvim-theme",
		["config"] = function()
			require('github-theme').setup()
			vim.cmd.colorscheme("github_dark_high_contrast")
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		["config"] = function()
			local show_filename = function(str, ctx)
				local path = vim.fn.expand("%:p")
				if type(path) ~= "string" or #path < 1 then
					path = "[new]"
				end
				local leave_space_for = 1
				local hide_below = 5
				local max_width = vim.fn.winwidth(ctx.tabnr) - leave_space_for
				if max_width < hide_below then
					return ""
				end
				if #path <= max_width then
					return path
				end
				return "<"..path:sub(#path - max_width)
			end
			require("lualine").setup({
				["options"] = {
					["theme"] = "github_dark_high_contrast",
				},
				["sections"] = {
					["lualine_a"] = {{
						"filename",
						["fmt"] = show_filename
					}},
					["lualine_b"] = {},
					["lualine_c"] = {},
					["lualine_x"] = {},
					["lualine_y"] = {},
					["lualine_z"] = {},
				},
				["inactive_sections"] = {
					["lualine_a"] = {{
						"filename",
						["fmt"] = show_filename
					}},
					["lualine_b"] = {},
					["lualine_c"] = {},
					["lualine_x"] = {},
					["lualine_y"] = {},
					["lualine_z"] = {},
				},
				["inactive_winbar"] = {},
				["winbar"] = {},
				["tabline"] = {
					["lualine_a"] = { "mode" },
					["lualine_b"] = { "branch", "diff", "diagnostics" },
					["lualine_c"] = { "encoding", "fileformat", "filetype" },
					["lualine_x"] = { "progress" },
					["lualine_y"] = { "location" },
					["lualine_z"] = { "tabs" },
				},
			})
		end,
	})

	use({
		"tpope/vim-fugitive",
		["config"] = function()
			vim.keymap.set("n", "<leader>gs", ":Git<cr>", { ["silent"] = true })
			vim.keymap.set("n", "<leader>gl", ":Git log --oneline<cr>", { ["silent"] = true })
			vim.keymap.set("n", "<leader>gL", ":Git log --oneline %<cr>", { ["silent"] = true })
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { ["silent"] = true })
			vim.keymap.set("n", "<leader>gg", ":Git grep ")
			vim.keymap.set("n", "<leader>gG", ":Git grep -in ")
			vim.keymap.set("n", "<leader>gw", "yw:Git grep <c-f>p<cr>", { ["silent"] = true })
			vim.keymap.set("n", "<leader>gW", "yw:Git grep -in <c-f>p<cr>", { ["silent"] = true })
			vim.keymap.set("n", "<leader>ge", ":Gedit<cr>", { ["silent"] = true })
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		["requires"] = {
			"nvim-lua/plenary.nvim",
		},
		["tag"] = "v0.9.0",
		["config"] = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "]c", function()
				require("gitsigns").nav_hunk("next")
			end)
			vim.keymap.set("n", "[c", function()
				require("gitsigns").nav_hunk("prev")
			end)
		end,
	})

	use({
		"chrisgrieser/nvim-early-retirement",
		["config"] = function ()
			require("early-retirement").setup({})
		end,
	})

	use({
		"ojroques/nvim-osc52",
		["config"] = function()
			require('osc52').setup({
				["max_length"] = 0,
				["silent"] = false,
				["trim"] = false,
				["tmux_passthrough"] = true,
			})
			local function copy(lines, _)
				require('osc52').copy(table.concat(lines, '\n'))
			end
			local function paste()
				return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
			end
			vim.g.clipboard = {
				["name"] =  "osc52",
				["copy"] =  { ['+'] = copy, ['*'] = copy },
				["paste"] = { ['+'] = paste, ['*'] = paste },
			}
		end
	})

end)

