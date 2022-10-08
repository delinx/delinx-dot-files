local config = {


	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		-- remotes = { -- easily add new remotes to track
		--	 ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--	 ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--	 ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme
	colorscheme = "gruvbox",

	-- Override highlight groups in any theme
	highlights = {
		-- duskfox = { -- a table of overrides
		--	 Normal = { bg = "#FFFAAA" },
		-- },
		default_theme = function(highlights) -- or a function that returns one
			local C = require "default_theme.colors"

			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
		gruvbox = {
			Normal = { bg = "none"},
			NonText = { bg = "none"},
			VirtColumn = { fg = "#1c1c1c", bg = "black"},
			SignColumn = {bg = "none"},
			TermCursor = {bg="black", fg="black"}
		 },
	},

	-- set vim options here (vim.<first_key>.<second_key> =	value)
	options = {
		opt = {
			relativenumber = true, -- sets vim.opt.relativenumber
			guifont = "RobotoNerd:h14",
			background = "dark",
			colorcolumn="80",
			textwidth=120,
			hlsearch=false,
			hidden=true,
			showmatch=true,
			ignorecase=true,
			incsearch=true,
			expandtab=true,
			shiftwidth=4,
			tabstop=4,
			softtabstop=4,
			autoindent=true,
			signcolumn="yes",
			spell=false,
			swapfile=false,
			backup=false,
			scrolloff=8,
			cmdheight=2,
			linespace=4,
		},
			
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			fzf_layout = {
				down="20%"
			},
			neovide_transparency = 0.8,
			neovide_floating_blur_amount_x = 2.0,
			neovide_floating_blur_amount_y = 2.0,
			neovide_no_idle=true,
			neovide_remember_window_size = false,
			-- neovide_profiler = true,
			neovide_cursor_animation_length=0.05,
			neovide_cursor_antialiasing=false,
			neovide_cursor_vfx_mode = "pixiedust",
			--neovide_cursor_vfx_mode = "pixiedustrandom",
			neovide_refresh_rate=240,

			neovide_cursor_vfx_particle_density=100.0,
			neovide_cursor_vfx_particle_speed=5.0,

			neovide_cursor_color_r = 178.0;
			neovide_cursor_color_g = 121.0;
			neovide_cursor_color_b = 224.0;

			neovide_cursor_vfx_color_r = 245.0;
			neovide_cursor_vfx_color_g = 95.0;
			neovide_cursor_vfx_color_b = 148.0;

			zig_fmt_autosave = 0;
		},
	},

	-- Default theme configuration
	default_theme = {
		diagnostics_style = { italic = true },
		-- Modify the color table
		colors = {
			fg = "#abb2bf",
			bg = "#000000",
			background_color = "#000000"
		},
		plugins = { -- enable or disable extra plugin highlighting
			aerial = true,
			beacon = false,
			bufferline = true,
			dashboard = true,
			highlighturl = true,
			hop = false,
			indent_blankline = true,
			lightspeed = false,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			vimwiki = false,
			["which-key"] = true,
			gruvbox = true,
		},
	},

	-- Disable AstroNvim ui features
	ui = {
		nui_input = true,
		telescope_select = true,
	},

	-- Configure plugins
	plugins = {
		-- Add plugins, the packer syntax without the "use"
		init = {
			-- You can disable default plugins as follows:
			-- ["goolord/alpha-nvim"] = { disable = true },

			-- You can also add new plugins here as well:
			-- { "andweeb/presence.nvim" },
			-- {
			--   "ray-x/lsp_signature.nvim",
			--   event = "BufRead",
			--   config = function()
			--     require("lsp_signature").setup()
			--   end,
			-- },
			{ "ellisonleao/gruvbox.nvim",
			    require("gruvbox").setup({
			    undercurl = true,
			    underline = true,
			    bold = true,
			    italic = false,
			    strikethrough = true,
			    invert_selection = false,
			    invert_signs = false,
			    invert_tabline = false,
			    invert_intend_guides = false,
			    inverse = true, -- invert background for search, diffs, statuslines and errors
			    contrast = "hard", -- can be "hard", "soft" or empty string
			    overrides = {

			    },
			    })
			},
			{ "lukas-reineke/virt-column.nvim",
			    require("virt-column").setup({ char = "░"})
			},
			{
				"ibhagwan/fzf-lua"
			},
			{
				"ThePrimeagen/harpoon"
			},
			{
				"ziglang/zig.vim"
			},
			{
				"github/copilot.vim"
			},
			{
				"mfussenegger/nvim-lint"
			},
			{
				"adigitoleo/vim-mellow"
			}
		},
		-- All other entries override the setup() call for default plugins
		treesitter = {
			ensure_installed = { "lua" },
		},
		["nvim-lsp-installer"] = {
			ensure_installed = { "sumneko_lua" },
		},
		packer = {
			compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
		},
	},

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = {},
		-- Extend filetypes
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	-- Modify which-key registration
	["which-key"] = {
		-- Add bindings
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
			  -- second key is the prefix, <leader> prefixes
			  ["<leader>"] = {
			    -- which-key registration table for normal mode, leader prefix
			    -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
			  },
			},
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without lsp-installer
		servers = {
			-- "pyright"
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
			  -- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the server on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the lsp installer server-registration function
		-- server_registration = function(server, opts)
		--	 require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			-- example for addings schemas to yamlls
			-- yamlls = {
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
			--
		},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			["<C-s>"] = { ":w!<cr>", desc = "Save File" },
			["<A-k>"] = { "mz:m-2<CR>`z==" },
			["<A-j>"] = { "mz:m+<CR>`z==" },
			["<leader>z"] = {"<cmd>FZF<CR>", desc = "FZF" },
			["<Tab>"] = {">>_", desc = ">>"},
			["<S-Tab>"] = {"<<_", desc = "<<"},
			["<leader>fC"] = {"<cmd>:%s/^\\(\\s*\\).*\\zs{\\s*$/\\r\\1{/<CR>", desc = "Dumb Format C"},
			["<leader>fR"] = {"<cmd>:%! rustfmt<CR>", desc = "Format Rust"},

			["<C-k>"] = { "<cmd>:!cd %:h/..; rusty-man <cword><cr>", desc = "Save File" },

			-- harpoon
			["<leader>hm"] = {"<cmd>lua require(\"harpoon.mark\").add_file()<CR>", desc = "Add to Harpoon"},
			["<leader>hh"] = {"<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<CR>", desc = "Harpoon menu"},
			["<leader>hn"] = {"<cmd>lua require(\"harpoon.ui\").nav_next()<CR>", desc = "Harpoon next page"},
			["<leader>hp"] = {"<cmd>lua require(\"harpoon.ui\").nav_prev()<CR>", desc = "Harpoon prev page"},
			["<leader>ht"] = {"<cmd>Telescope harpoon marks<CR>", desc = "Harpoon in Telescope"},
			["<leader>1"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(1)<CR>", desc = "Page 1 of Hapoon"},
			["<leader>2"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(2)<CR>", desc = "Page 2 of Hapoon"},
			["<leader>3"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(3)<CR>", desc = "Page 3 of Hapoon"},
			["<leader>4"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(4)<CR>", desc = "Page 4 of Hapoon"},
			["<leader>5"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(5)<CR>", desc = "Page 5 of Hapoon"},
			["<leader>6"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(6)<CR>", desc = "Page 6 of Hapoon"},
			["<leader>7"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(7)<CR>", desc = "Page 7 of Hapoon"},
			["<leader>8"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(8)<CR>", desc = "Page 8 of Hapoon"},
			["<leader>9"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(9)<CR>", desc = "Page 9 of Hapoon"},
			["<leader>0"] = {"<cmd>:lua require(\"harpoon.ui\").nav_file(10)<CR>", desc = "Page 10 of Hapoon"},

			["gh"] = { "<cmd>:lua SwitchBetweenFiles()<CR>" },

			["frr"] = { "<cmd>:!rustfmt %<CR>" },
			["frc"] = { "<cmd>:!rustfmt +nightly %<CR>" }
		},
		i = {
			["<A-j>"] = { "<Esc>:m+<CR>==gi" },
			["<A-k>"] = { "<Esc>:m-2<CR>==gi" },
		},
		v = {
			["<A-j>"] = { ":m'>+<CR>gv=`<my`>mzgv`yo`z" },
			["<A-k>"] = { ":m'<-2<CR>gv=`>my`<mzgv`yo`z" },
			["<Tab>"] = {">gv", desc = ">>"},
			["<S-Tab>"] = {"<gv", desc = "<<"},
		},
		t = {
			["<esc>"] = {"<C-c>"},
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},

	-- This function is run last
	-- good place to configuring augroups/autocommands and custom filetypes
	polish = function()
		-- Set key binding
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		vim.g.gui_font_default_size = 14
		vim.g.gui_font_size = vim.g.gui_font_default_size
		vim.g.gui_font_face = "RobotoNerd"

		ResetGuiFont()

		local opts = { noremap = true, silent = true }
		vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(1)  end, opts)
		vim.keymap.set({'n', 'i'}, "<C-=>", function() ResizeGuiFont(-1) end, opts)

		-- Set up custom filetypes
		-- vim.filetype.add {
		--	 extension = {
		--	   foo = "fooscript",
		--	 },
		--	 filename = {
		--	   ["Foofile"] = "fooscript",
		--	 },
		--	 pattern = {
		--	   ["~/%.config/foo/.*"] = "fooscript",
		--	 },
		-- }
	end,
}

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
	if vim.g.gui_font_size + delta > 0 then
  		vim.g.gui_font_size = vim.g.gui_font_size + delta
	end
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

SwitchBetweenFiles = function ()
	--	vim.cmd("e %<.hpp")
	file = vim.api.nvim_buf_get_name(0)
	file = MySplit(file,".")[2]
	if (file == "cpp") then
		vim.cmd("e %<.hpp")
	end
	if (file == "hpp") then
		vim.cmd("e %<.cpp")
	end
end

MySplit = function(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

ResetGuiFont()



return config

