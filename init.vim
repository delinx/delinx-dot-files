set exrc
set guicursor=              " set cursor to block
set relativenumber          " show relative numbers to current pos
set nu                      " show current global line number
set nohlsearch              " disable highlighting after search
set hidden                  " allow to navigate away from unsaved buffers
set noerrorbells
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=a                 " middle-click paste with
set incsearch               " incremental search
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
set colorcolumn=80          " set an 80 column border for good coding style
set signcolumn=yes          " extra column on the left
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set spell                 " enable spell check (may need to download language package)

set noswapfile            " disable creating swap file
set nobackup
set undodir=~/.nvim/undodir
set undofile

set scrolloff=8
set cmdheight=2
set updatetime=50
set shortmess+=c

set background=dark
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
set listchars=

set splitbelow splitright

nnoremap <A-k> mz:m-2<CR>`z==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
nnoremap <A-j> mz:m+<CR>`z==
vnoremap <A-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

nnoremap <F5> :UndotreeToggle<CR>
nnoremap <silent> <C-p> <cmd>Telescope find_files theme=ivy<cr>

let mapleader= " "
nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<cr>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

call plug#begin("~/.nvim_piugins")
 " Plugin Section
 Plug 'luochen1990/rainbow'
 Plug 'thaerkh/vim-indentguides'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'airblade/vim-gitgutter'
 Plug 'tpope/vim-fugitive'
 Plug 'lifepillar/vim-gruvbox8'
 Plug 'ellisonleao/gruvbox.nvim'
 Plug 'mbbill/undotree'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-treesitter/nvim-treesitter'
 Plug 'neovim/nvim-lspconfig'
 Plug 'lukas-reineke/virt-column.nvim'
 Plug 'deoplete-plugins/deoplete-lsp'
 Plug 'junegunn/goyo.vim'
 Plug 'ThePrimeagen/harpoon'
 Plug 'psliwka/vim-smoothie'

 if has('nvim')
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 else
   Plug 'Shougo/deoplete.nvim'
   Plug 'roxma/nvim-yarp'
   Plug 'roxma/vim-hug-neovim-rpc'
 endif

  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

call plug#end()

let g:deoplete#enable_at_startup = 1

let g:rainbow_active = 1

colorscheme gruvbox8_hard
let g:airline_theme='base16_gruvbox_dark_hard'

"highlight LineNr ctermbg=0 ctermfg=107
"highlight CursorLineNr ctermfg=155 ctermbg=240
highlight LineNr ctermbg=none ctermfg=107
highlight CursorLineNr ctermfg=155 ctermbg=240
highlight SignColumn ctermbg=none

set cursorline
set cursorlineopt=number

highlight Normal ctermbg=none
highlight NonText ctermbg=none

autocmd BufEnter * VirtColumnRefresh
highlight VirtColumn ctermfg=black
lua require("virt-column").setup { char = "░" }

let g:indentguides_spacechar = '│'
let g:indentguides_tabchar = '│'

" rust language server
lua require'lspconfig'.rust_analyzer.setup{}

highlight Pmenu ctermbg=236
highlight PmenuSel ctermbg=66 ctermfg=230
highlight PmenuSbar ctermbg=72
highlight PmenuThumb ctermbg=108

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

set completeopt=menuone,noinsert,noselect

" trim remaining white spaces
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup customDel
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END



nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

" copy \ paste from vim to OS
vnoremap <C-c> "*Y :let @+=@*<cr>
map <C-p> "+P

" spellcheck on/off switch
map <silent> <leader>o <cmd>:setlocal spell!<CR>

" command line completion
set wildmode=longest,list,full

" Goyo
map <leader>f :Goyo \|set linebreak<cr>

" Narpoon mappings + harpoon \ telescope integration
nnoremap <silent> <leader>hm          <cmd>lua require("harpoon.mark").add_file()<CR>
nnoremap <silent> <leader>hh          <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent> <leader>hn          <cmd>lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent> <leader>hp          <cmd>lua require("harpoon.ui").nav_prev()<CR>
nnoremap <silent> <leader>ht          <cmd>Telescope harpoon marks<CR>
nnoremap <silent> <leader>1           <cmd>:lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent> <leader>2           <cmd>:lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent> <leader>3           <cmd>:lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent> <leader>4           <cmd>:lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent> <leader>5           <cmd>:lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <silent> <leader>6           <cmd>:lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <silent> <leader>7           <cmd>:lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <silent> <leader>8           <cmd>:lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <silent> <leader>9           <cmd>:lua require("harpoon.ui").nav_file(9)<CR>
nnoremap <silent> <leader>0           <cmd>:lua require("harpoon.ui").nav_file(10)<CR>
lua require("telescope").load_extension('harpoon')


" jump to last known file position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

tnoremap <Esc> <C-\><C-n><CR>


