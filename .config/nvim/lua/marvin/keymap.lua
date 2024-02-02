local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap
--
keymap("", "<Space>", "<Nop>", opts)

keymap("n", "ü", "{", opts)
keymap("n", "+", "}", opts)

keymap("n", "<leader>vp", ":VimuxPromptCommand<cr>", opts)
keymap("n", "<leader>vz", ":VimuxZoomRunner<cr>", opts)
keymap("n", "<leader>vq", ":VimuxCloseRunner<cr>", opts)
keymap("n", "<leader>vc", ":VimuxInterruptRunner<cr>", opts)

-- keymap("n", "<leader>rp", ":call VimuxRunCommand('python ' . bufname('%'))<cr>", opts)
-- keymap("n", "<leader>rs", ":call VimuxRunCommand('npm start')<cr>", opts)
-- keymap("n", "<leader>rr", ":VimuxInterruptRunner<cr>:VimuxRunLastCommand<cr>", opts)
-- keymap("n", "<leader>rz", ":VimuxRunLastCommand<cr>:VimuxZoomRunner<cr>", opts)
keymap("n", "<leader>r", ":VimuxOpenRunner<cr> :call VimuxSendKeys('up enter')<cr>", opts)
function run_file()
  local f = vim.bo.filetype
  if f == 'javascript' or f == 'typescript' then
    vim.cmd [[VimuxRunCommand('npm start')]]
  elseif f == 'rust' then
    vim.cmd [[VimuxRunCommand('cargo run')]]
  elseif f == 'dart' then
    vim.cmd [[FlutterDevices]]
  end
end

vim.keymap.set("n", "<leader>R", run_file, opts)

keymap("n", "<leader>dt", ":lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<cr>",
  opts)

keymap("n", "<leader>xx", ":s/\\[ \\]/[x]<cr>:noh<cr>", opts)
keymap("n", "<leader>xu", ":s/\\[x\\]/[ ]<cr>:noh<cr>", opts)
keymap("n", "<leader>xn", "o- [ ] ", opts)
keymap("n", "<leader>xd", "dd G p <C-o>k", opts) -- cut the line and paste it to the bottom of the file (move todo to done)

keymap("n", "<C-p>", ":NvimTreeToggle<cr>", opts)
-- keymap("n", "<C-x>", ":Bdelete<cr>", opts)
keymap("n", "<leader>nh", ":noh<cr>", opts)
keymap("n", "<leader>nw", ":set wrap!<cr>", opts)

keymap("v", "<leader>yy", '"+y', {})
keymap("n", "<leader>t", ":FloatermNew --height=0.95 --width=0.95<cr>", opts)
keymap("n", "<leader>G", ":FloatermNew --height=0.95 --width=0.95 --cwd=<buffer> lazygit<cr>", opts)
-- keymap("n", "<leader>G", ":0G<cr>", opts)

keymap("n", "<F5>", ":lua require('dap').continue()<cr>", opts)
keymap("n", "<F10>", ":lua require('dap').step_over()<cr>", opts)
keymap("n", "<F11>", ":lua require('dap').step_into()<cr>", opts)
keymap("n", "<F12>", ":lua require('dap').step_out()<cr>", opts)
keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
keymap("n", "<leader>dt", ":lua require('dap-go').debug_test()<cr>", opts)
keymap("n", "<leader>dr", ":lua dapRunConfigWithArgs()<cr>", opts)
-- keymap("n", "<leader>dl", ":lua require('dap').run_last()<cr>", opts)

keymap("n", "<C-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<C-b>", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>dl", ":Telescope diagnostics<cr>", opts)
keymap("n", "<leader>gB", ":Telescope git_branches<cr>", opts)

keymap("n", "<leader>gh", ":Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>gb", ":Gitsigns blame_line<cr>", opts)
-- keymap("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<cr>", opts)

local dv_open = false
local function toggle_dv()
  if dv_open then
    vim.cmd [[DiffviewClose]]
  else
    vim.cmd [[DiffviewOpen]]
  end
  dv_open = not dv_open
end

vim.keymap.set("n", "<leader>gd", toggle_dv, opts)

keymap("n", "<leader>gg", ":G<cr>", opts)
keymap("n", "<leader>gl", ":G pull<cr>", opts)
keymap("n", "<leader>gp", ":G push<cr>", opts)

keymap("n", "<leader>gf", ":diffget //2<cr>", opts)
keymap("n", "<leader>gj", ":diffget //3<cr>", opts)

keymap("n", "<leader>o", "<C-w>gf", {})
keymap("n", "<leader>#", "gcc", {})
keymap("n", "<leader>\\", "gcc", {})
keymap("n", "<leader>Q", ":Bdelete!<cr>", {})
keymap("n", "<leader>qq", ":qa<cr>", {})
keymap("n", "<leader>qd", ":DiffviewClose<cr>", {})
keymap("n", "<leader>qa", ":%bd|e#|bd#<cr>", {})
keymap("v", "<leader>#", "gc", {})
keymap("v", "<leader>\\", "gc", {})

keymap("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {}) -- replace word under cursor
keymap("n", "<leader>st", ":%s/\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)/\\1:\\2/g", {})  -- replace word under cursor

keymap("n", "<C-j>", ":cnext<cr>", opts)
keymap("n", "<C-k>", ":cprev<cr>", opts)
--
-- -- Normal --
-- -- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Left>", ":vertical resize -5<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +5<cr>", opts)
keymap("n", "<C-Up>", ":resize -5<cr>", opts)
keymap("n", "<C-Down>", ":resize +5<cr>", opts)

keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- -- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- keymap("n", "<Tab>", ">>", opts)
-- keymap("n", "<S-Tab>", "<<", opts)

keymap("i", "<S-Tab>", "<C-D>", {})

-- -- Visual --
-- -- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)


-- -- GUI Editor Shotcuts --
keymap("n", "<D-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<esc>:w<cr>", {})
keymap("n", "<C-s>", ":w<cr>", {})

-- Harpoon
keymap("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- go to the angular template file
-- toggle between ts and html for angular
vim.keymap.set("n", "<leader>gt", function()
  -- local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  -- local str = table.concat(content, "\n")
  -- local template = str:match("templateUrl: '([%a%p]+)'")
  -- local folder = vim.fn.expand("%:h")
  -- vim.cmd("e " .. folder .. '/' .. template)
  local filename = vim.fn.expand("%")
  if filename:match("%.html$") then
    local new_filename = filename:gsub('%.html$', ".ts")
    print(new_filename)
    vim.cmd("e " .. new_filename)
  end
  if filename:match("%.ts$") then
    local new_filename = filename:gsub("%.ts$", ".html")
    print(new_filename)
    vim.cmd("e " .. new_filename)
  end
end, opts)
