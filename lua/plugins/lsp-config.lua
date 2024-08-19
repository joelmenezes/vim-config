return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "jdtls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.jdtls.setup({
				cmd = {
					"jdtls",
					"--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
				},
				capabilities = capabilities,
				handlers = {
					["language/status"] = progress_handler,
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>gT", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, {})
		end,
	},
}
