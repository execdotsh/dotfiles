
-- utility

--require('github-theme').setup()

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

local function is_unix()
	return vim.fn.has("unix") == 1
end

local function has_exec(exec)
	return vim.fn.executable(exec) == 1
end

local function has_env(env)
	return os.getenv(env) ~= nil
end

-- general config

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
vim.opt.backup = false
vim.opt.expandtab = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.preserveindent = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.shiftwidth = 4
vim.opt.showcmd  = true
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
if has_env("NVIMSH") then
	vim.opt.shell = os.getenv("NVIMSH")
end

-- ru lang
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.api.nvim_command("autocmd TermOpen * startinsert")               -- starts in insert mode
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")         -- no numbers
vim.api.nvim_command("autocmd TermOpen * setlocal norelativenumber") -- no relative numbers
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")   -- no sign column

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
vim.keymap.set("n", "<leader>w", ":write<cr>", { ["silent"] = true })
vim.keymap.set("n", "<leader>ц", ":write<cr>", { ["silent"] = true })
vim.keymap.set("n", "<leader>n", "<c-w>v<c-w><s-t>", { ["silent"] = true })
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

-- clip sync

if has_exec("clipc") then
	local host = "localhost"
	local port = 8086
	vim.g.clipboard = {
		name = 'clipd',
		copy = {
			["+"] = { "clipc", host, port, "--push" }
		},
		paste = {
			["+"] = { "clipc", host, port, "--pull" }
		}
	}
	vim.o.clipboard = "unnamedplus"
end

-- plugins

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
		require("telescope").setup({ defaults = { borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" } } })
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			if not pcall(builtin.git_files, { cwd = git_dir() }) then builtin.find_files() end
		end)
		vim.keymap.set("n", "<leader>fF", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", function() builtin.live_grep({ cwd = git_dir() }) end)
		vim.keymap.set("n", "<leader>fG", builtin.live_grep)
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>fj", builtin.jumplist)
	end },

	{ "nvim-tree/nvim-web-devicons" },

	{ "jiaoshijie/undotree", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
		require("undotree").setup({
			float_diff = true,
			layout = "left_bottom",
			position = "left",
			ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
			window = { winblend = 30 },
			keymaps = {
				j = "move_next", k = "move_prev", gj = "move2parent", J = "move_change_next", K = "move_change_prev",
				["<cr>"] = "action_enter", p = "enter_diffbuf", q = "quit"
			},
		})
		vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
	end },

	has_exec("node") and { "neoclide/coc.nvim", branch = "release" } or nil,

	{ "nvim-neo-tree/neo-tree.nvim", dependencies = {
		"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		config = function()
			require("neo-tree").setup({
				enable_git_status = false,
				event_handlers = {
					{
						event = "file_opened",
						handler = function() require("neo-tree.command").execute({ action = "close" }) end,
					}
				},
				window = {
					position = "float",
					mappings = {
						Y = function(state)
							local node = state.tree:get_node()
							local filepath, filename = node:get_id(), node.name
							local modify = vim.fn.fnamemodify
							local results = {
								filepath,
								modify(filepath, ":."),
								modify(filepath, ":~"),
								filename,
								modify(filename, ":r"),
								modify(filename, ":e"),
							}
							local i = vim.fn.inputlist({
								"Choose to copy to clipboard:",
								"1. Absolute path: " .. results[1],
								"2. Path relative to CWD: " .. results[2],
								"3. Path relative to HOME: " .. results[3],
								"4. Filename: " .. results[4],
								"5. Filename without extension: " .. results[5],
								"6. Extension of the filename: " .. results[6],
							})
							if i > 0 and results[i] then
								vim.fn.setreg('"', results[i])
								vim.notify("Copied: " .. results[i])
							end
						end,
					},
				},
			})
			vim.keymap.set("n", "<leader>tt", function()
				require("neo-tree.command").execute({ reveal = true, position = "float" })
			end)
		end
	},

	{ "olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			vim.cmd("colorscheme onedark_dark")
		end
	},

	{ "archibate/lualine-time" },

	{ "nvim-lualine/lualine.nvim", config = function()
		local show_filename = function(_, ctx)
			local path = vim.fn.expand("%:p")
			if #path < 1 then path = "[new]" end
			local max_width = vim.fn.winwidth(ctx.tabnr) - 1
			if max_width < 5 then return "" end
			return (#path <= max_width) and path or "<" .. path:sub(#path - max_width)
		end
		require("lualine").setup({
			sections = {
				lualine_a = { { "filename", fmt = show_filename } },
				lualine_b = {}, lualine_c = {},
				lualine_x = {}, lualine_y = {}, lualine_z = {},
			},
			inactive_sections = {
				lualine_a = { { "filename", fmt = show_filename } },
				lualine_b = {}, lualine_c = {},
				lualine_x = {}, lualine_y = {}, lualine_z = {},
			},
			tabline = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "encoding", "fileformat", "filetype" },
				lualine_x = { "cdate", "ctime" },
				lualine_y = { "progress", "location" },
				lualine_z = { "tabs" },
			},
		})
	end },

	has_exec("git") and {
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", ":Git<cr>", { silent = true })
			vim.keymap.set("n", "<leader>gl", ":Git log --oneline<cr>", { silent = true })
			vim.keymap.set("n", "<leader>gL", ":Git log --oneline %<cr>", { silent = true })
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { silent = true })
			vim.keymap.set("n", "<leader>gg", ":Git grep ")
			vim.keymap.set("n", "<leader>gG", ":Git grep -in ")
			vim.keymap.set("n", "<leader>gw", "yw:Git grep <c-f>p<cr>", { silent = true })
			vim.keymap.set("n", "<leader>gW", "yw:Git grep -in <c-f>p<cr>", { silent = true })
			vim.keymap.set("n", "<leader>ge", ":Gedit<cr>", { silent = true })
		end,
	} or nil,

	{
		"lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "]c", function() require("gitsigns").nav_hunk("next") end)
			vim.keymap.set("n", "[c", function() require("gitsigns").nav_hunk("prev") end)
		end
	},

	{ "chrisgrieser/nvim-early-retirement", config = function()
		require("early-retirement").setup({})
	end },

	{
		"0x00-ketsu/autosave.nvim",
		event = { "InsertLeave", "TextChanged" },
		config = function()
			require("autosave").setup({
				enabled = true,
				execution_message = {
					message = function() return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) end,
					dim = 0.18,
					cleaning_interval = 1250,
				},
				trigger_events = { "InsertLeave", "TextChanged" },
				condition = function(buf)
					return vim.bo[buf].modifiable and vim.bo[buf].buftype == ""
				end,
				debounce_delay = 1000, -- ms after typing stops
				write_all_buffers = false, -- set to true to save all buffers
			})
		end,
	},
})

