return {
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		'numToStr/Comment.nvim',
		opts = {}
	},
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-repeat' },
  { 'tpope/vim-abolish' },
  { 'echasnovski/mini.pairs', version = '*' },
}
