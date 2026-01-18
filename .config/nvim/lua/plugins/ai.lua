return {
  {
    "coder/claudecode.nvim",
    keys = {
      { "<leader>a", nil, desc = "Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    opts = {
      terminal = {
        provider = "none", -- no UI actions; server + tools remain available
      },
    },
  },
}
