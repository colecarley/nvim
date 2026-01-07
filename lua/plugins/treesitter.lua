return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                ensure_installed = {
                    "typescript",
                    "css",
                    "javascript",
                    "svelte",
                    "cpp",
                    "c",
                    "markdown",
                    "markdown_inline",
                    "jsonc",
                    "python",
                    "zig",
                    "rust",
                    "go",
                    "haskell",
                    "objc",
                },
            })
        end
    },
}
