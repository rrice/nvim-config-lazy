return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"lua",
				"javascript",
				"c",
				"c_sharp",
				"cpp",
				"css",
				"go",
				"gomod",
				"gosum",
				"html",
				"jsdoc",
				"make",
				"markdown",
				"markdown_inline",
				"proto",
				"csv",
				"commonlisp",
				"scheme",
				"sql",
				"toml",
				"typescript",
				"embedded_template",
				"xml",
				"yaml",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			-- EJS
			vim.filetype.add({
				extension = {
					ejs = "ejs",
				},
			})
			vim.treesitter.language.register("html", "ejs")
			vim.treesitter.language.register("javascript", "ejs")
			vim.treesitter.language.register("embedded_template", "ejs")
		end,
	},
}
