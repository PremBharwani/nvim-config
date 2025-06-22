"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" temp debug
" set verbose=2
" redir! > ~/.nvim_log
" :runtime plugin/fzf.vim
" redir END
"" temp debug end

" Leader key mapping
let mapleader = " "
let g:mapleader = " "


" Set modifiable for live reload
set modifiable

" Allow mouse
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug
" Automatic installaion of vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

  " VCS Related
  Plug 'tpope/vim-fugitive'                                                       " Best Git integration
  Plug 'airblade/vim-gitgutter'                                                   " Show git changes in the gutter

  " Manipulation
  Plug 'tpope/vim-eunuch'                                                         " UNIX commands on buffer & file sys too! (Rename, Chmod, etc.)

  Plug 'tpope/vim-commentary'                                                     " Toggle comments

  " Buffers, Tags, QuickFix, Undo
  "
  " Note for fzf to work you need to install fzf in your system. This is just a plugin
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'moll/vim-bbye'                                                            " Close buffers without closing windows

  " Plug 'feline-nvim/feline.nvim'
  Plug 'itchyny/lightline.vim'

  Plug '907th/vim-auto-save'                                                      " Autosave files as you type
  Plug 'tpope/vim-surround'                                                       " Change surround

  " Symbols outline
  " Plug 'liuchengxu/vista.vim'
  " Plug 'simrat39/symbols-outline.nvim'                                            " Symbols outline
  Plug 'hedyhli/outline.nvim'

  " AI stuff 
  Plug 'github/copilot.vim'

  " Nvim tree
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'folke/tokyonight.nvim' "testing how i like it

  " Theme
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'fei6409/log-highlight.nvim'                                               "Logs highlighting

  " CoC - Completion, LSP and more 
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
 
  " Snippets
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.3.0', 'do': 'make install_jsregexp'} 
  Plug 'rafamadriz/friendly-snippets'
  
  " Misc
  Plug 'romainl/vim-cool'                                                         " Close hlsearch after complete
  Plug 'jiangmiao/auto-pairs'                                                     " Auto pairs brackets, quotes, etc.
  Plug 'akinsho/toggleterm.nvim'                                                  " Terminal in a floating window

  " Format code
  Plug 'sbdchd/neoformat'

  " Folding
  Plug 'kevinhwang91/promise-async'
  Plug 'kevinhwang91/nvim-ufo'

  " Self plugin 
  Plug '~/.config/nvim/plugged/peepy' " Custom plugin I am writing

  " Claude code
  Plug 'nvim-lua/plenary.nvim'
  Plug 'greggh/claude-code.nvim'

  " Hardtime - Teaches you vim motions (popups if you make mistakes)
  Plug 'm4xshen/hardtime.nvim'

  " Better comments ( Colors comemnts for sane humans )
  Plug 'jbgutierrez/vim-better-comments'
  Plug 'folke/todo-comments.nvim'

  Plug 'wellle/context.vim'

call plug#end()
"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Set theme
"""""""""""""
" latte is light theme. surprisingly its cool.
" machhiato is a darkd one.
" colorscheme catppuccin-latte "catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
" colorscheme tokyonight-night , tokyonight-day, tokyonight-moon, tokyonight-storm
colorscheme tokyonight-night

" Edit vimrc
"""""""""""""
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>


" Auto save
"""""""""""""
let g:auto_save = 1  " enable AutoSave on Vim startup

" Buffer management
"""""""""""""
nnoremap <silent> <Leader>q :Bdelete<CR>                                            " Close active buffer
nnoremap <silent> <Leader>bc :BufOnly<CR>                                           " Close all buffers except the current one - Uses custom method CloseAllButCurrentBdelete()
nnoremap <silent> <leader>t :enew<CR>                                               " New empty buffer
nnoremap <silent> <leader>i :echo expand("%:p")<CR>                                 " Show full path of current file 


" Close all buffers except the current one using Bdelete
function! CloseAllButCurrentBdelete() 
  let current = bufnr('%')
  " Get a list of all listed buffers
  for buf in getbufinfo({'buflisted': 1})
    if buf.bufnr != current
      execute 'Bdelete' buf.bufnr
    endif
  endfor
endfunction
command! BufOnly call CloseAllButCurrentBdelete()                                   " Alias for CloseAllButCurrentBdelete() 


" FZF
"""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"let g:fzf_files_options = '--preview bat --style=numbers --color=always --line-range :100 {}"'

nnoremap <silent> <leader>h :Files<CR>
nnoremap <silent> <leader>g :GFiles?<CR> 
"nnoremap <silent> <leader>b :Buffers<CR>

" Rg - Ripgrep 
""""""""""""""
nnoremap <silent> <leader>f :Rg<CR> 


" Git blame toggle
""""""""""""""""""
nnoremap <silent> <leader>b :Git blame<CR>

" Outline stuff
""""""""""""""

" 
nnoremap <silent> <C-s> :Outline<CR> 


"

" function! NearestMethodOrFunction() abort 
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction

" set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you dont call it explicitly."
"
" If you want to show the nearest function in your statusline automatically,
"

" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" " Function to toggle vista  
" "
" function! ToggleVista()
"   if exists("g:vista") && g:vista.is_open
"     exe "Vista!"
"   else
"     exe "Vista"
"   endif
" endfunction

" nnoremap <silent> <C-s> :Vista!!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Show branch name
"
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'method'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

" Always show the status line
"
set laststatus=2

" Do not show editor mode
"
set noshowmode

" Height of the command bar
"
set cmdheight=2
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ => Git gutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Seperate git status sign & line number in gutter
" set signcolumn=yes

" augroup SignColumnAlways
"   autocmd!
"   autocmd BufEnter,BufWinEnter * setlocal signcolumn=yes
" augroup END

"}}}

" Copilot  
""""""""""""""
" Accept completion with <C-y>
imap <silent><script><expr> <C-y> copilot#Accept("\\<CR>")
let g:copilot_no_tab_map = v:true

" Accept next  word with <C-u>
"
imap <silent><script><expr> <C-u> copilot#AcceptWord("\\<C-u>")

" Dismiss suggestion with <C-d> 
"
imap <silent><script><expr> <C-d> copilot#Dismiss()

" Cycle to next suggestion with <C-n> and previous with <C-m>
"
imap <silent><script><expr> <C-n> copilot#Next()
imap <silent><script><expr> <C-m> copilot#Prev()

" Pane navigation
"""""""""""""""""
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open new windows on bottom and right
"""""""""""""""""
set splitright
set splitbelow

" Allow unsaved files
"""""""""""""""""
set hidden

" switching b/w buffers 
"""""""""""""""""
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Set the title of the terminal
"""""""""""""""""
set title

" Always show current position
"""""""""""""""""
set ruler

" This is the most awesome configurationa ever, is shows both
" the absolute and relative numbering together to make jumps
" easier
"""""""""""""""""
set number

set relativenumber

" COC
"""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"
" inoremap <silent><expr> <TAB>
"         \ coc#pum#visible() ? "\<C-n>" :
"         \ <SID>check_back_space() ? "\<TAB>" :
"         \ coc#refresh()
"
" inoremap <expr><S-TAB> coc#pum#visible() ? "\<C-p>" : "\<C-h>"
"
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm()
                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-rename)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

" Navigate suggestions
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
                call CocActionAsync('doHover')
        else
                execute '!' . &keywordprg . " " . expand('<cword>')
        endif
endfunction

let g:coc_global_extensions = ['coc-stylelint', 'coc-tsserver', 'coc-docker', 'coc-vimlsp', 'coc-sh', 'coc-json']

" Configure backspace so it acts as it should act
"
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
"
set lazyredraw

" Indicate this is a fast terminal
"
set ttyfast

" For regular expressions turn magic on
"
set magic

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Mark the current line
set cursorline

" 

" This prevents redraw for git-gutter/errors as signcolumn always is present
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Search Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Search your selection in visual mode selection
vnoremap // y/\V<C-R>=escape(@", '/\')<CR><CR>

" Taken from www.vi-improved.org/recommendations
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set foldcolumn=0
set foldlevel=99
set foldlevelstart=99
set foldenable


"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and completions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set fileencoding=utf-8
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set to auto read when a file is changed from the outside
set autoread

" Sets how many lines of history VIM has to remember and undolevels
set history=9999
set undolevels=9999

" If you use git + undo long enough, and have a durable laptop which doesn't
" explode, you can do without swaps and backups
set noswapfile
set nowb
set nobackup

" Time travelling with vim
" All changes are automatically saved; All undos are logged, so we can always move
" back and forth between changes and files without worrying
set undofile
set undodir=~/.config/nvim/undodir//
au FocusLost * silent! wa

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on


" Use '*' for fuzzy search, and suggest completions on command line
set wildmenu

" Tab completion: mimics the behaviour of zsh
set wildmode=list:longest,full

" Adding omnicomplete
set ofu=syntaxcomplete#Complete

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.so,*.swp,*.zip,*/tmp/*
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Text, and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tabstop & shift widhth
set tabstop=2
set shiftwidth=2

" Scroll 
set scroll=15

" Be smart when using tabs ;)
set smarttab

" Show matching brackets
set showmatch

" Migrated to editorconfig
" 1 tab == 4 spaces
" set shiftwidth=4
" set tabstop=4
" set softtabstop=4
set expandtab "Converts tabs into space characters

" Textwrap at 120 haracters
set tw=120
set wrap

" Indentation
set autoindent "Auto indent
set smartindent "Smart indent
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" The annoying jump over wrapped lines is removed
nnoremap j gj
nnoremap k gk

" Taken from @Tarrasch's vimrc
" Exit

" In ex mode use <C-p> <C-n> for scroll
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" white spaces
nnoremap <silent> <leader>4 :set list!<CR>

" Paste from clipboard
nnoremap <leader>v :set paste<CR>"+p:set nopaste<CR>
" Copy selected text to clipboard
vnoremap <leader>y "+y
" Reselect yanked text
nnoremap gy `[v`]

" Get the count of a search string
nnoremap <leader>c <Esc>:%s///gn<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Remove any enter maps in insert mode
""""""""""""""""""""'
" iunmap <CR>

" Netrw disable
"""""""""""""""""
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1


nnoremap <silent> <C-n> :NvimTreeToggle<CR>

" Toggle terminal
"""""""""""""""""
nnoremap <silent> <C-t> :ToggleTerm<CR>
tnoremap <buffer> <esc> <C-\><C-n>



" Experimental
""""""""""""""""
nnoremap <leader><leader>, V:s/[,)]/&\r/g <cr>='<

" Lua Snip - Snippets
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" JSON stringify
" JSON stringification + copy to clipboard
function! JsonStringifyAndCopy()
    " Only run on JSON files
    if &filetype !=# 'json'
        echo "Not a JSON file."
        return
    endif
    " Join entire buffer into one string
    let json_text = join(getline(1, '$'), "\n")
    " Parse JSON; catch errors if invalid
    try
        let parsed = json_decode(json_text)
    catch /^Vim\%((\a\+)\)\=:E25/
        echo "Invalid JSON."
        return
    endtry
    " Convert back to compact JSON string
    let compact = json_encode(parsed)
    " Copy to macOS clipboard via pbcopy
    call system('pbcopy', compact)
    echo "JSON copied to clipboard."
endfunction

" Map <leader>jc to run the function
nnoremap <silent> <leader>jc :call JsonStringifyAndCopy()<CR>


" Colorful coments using
"""""""""""""""""""""""""
let g:bettercomments_included = ['typescript']

augroup BetterCommentsCustom
  autocmd!
  autocmd FileType * call matchadd('ImportantBetterComment', '^\s*\(\/\/\|#\|--\|"\)\s*\*\s\+.*')
  autocmd ColorScheme * highlight ImportantBetterComment ctermfg=111 guifg=#61afef
  "highlight ImportantBetterComment ctermfg=Blue guifg=Blue
  highlight ImportantBetterComments ctermfg=111 guifg=#61afef
augroup END


"
" Lua part
lua << EOF


-- Log file highlighting
-- *********************
require('log-highlight').setup {
    -- The following options support either a string or a table of strings.

    -- The file extensions.
    extension = 'log',

    -- The file names or the full file paths.
    filename = {
        'messages',
    },

    -- The file path glob patterns, e.g. `.*%.lg`, `/var/log/.*`.
    -- Note: `%.` is to match a literal dot (`.`) in a pattern in Lua, but most
    -- of the time `.` and `%.` here make no observable difference.
    pattern = {
        '/var/log/.*',
        'messages%..*',
    },
}

-- Outline stuff (Candidate shall replace vista if works well for me)
-- """""""""""""""""
require("outline").setup({
  outline_window = {
    -- Where to open the split window: right/left
    position = 'right',
    -- The default split commands used are 'topleft vs' and 'botright vs'
    -- depending on `position`. You can change this by providing your own
    -- `split_command`.
    -- `position` will not be considered if `split_command` is non-nil.
    -- This should be a valid vim command used for opening the split for the
    -- outline window. Eg, 'rightbelow vsplit'.
    -- Width can be included (with will override the width setting below):
    -- Eg, `topleft 20vsp` to prevent a flash of windows when resizing.
    split_command = nil,

    -- Percentage or integer of columns
    width = 18,
    -- Whether width is relative to the total width of nvim
    -- When relative_width = true, this means take 25% of the total
    -- screen width for outline window.
    relative_width = true,

    -- Auto close the outline window if goto_location is triggered and not for
    -- peek_location
    auto_close = false,
    -- Automatically scroll to the location in code when navigating outline window.
    auto_jump = false,
    -- boolean or integer for milliseconds duration to apply a temporary highlight
    -- when jumping. false to disable.
    jump_highlight_duration = 300,
    -- Whether to center the cursor line vertically in the screen when
    -- jumping/focusing. Executes zz.
    center_on_jump = true,

    -- Vim options for the outline window
    show_numbers = true,
    show_relative_numbers = false,
    wrap = false,

    -- true/false/'focus_in_outline'/'focus_in_code'.
    -- The last two means only show cursorline when the focus is in outline/code.
    -- 'focus_in_outline' can be used if the outline_items.auto_set_cursor
    -- operations are too distracting due to visual contrast caused by cursorline.
    show_cursorline = true,
    -- Enable this only if you enabled cursorline so your cursor color can
    -- blend with the cursorline, in effect, as if your cursor is hidden
    -- in the outline window.
    -- This makes your line of cursor have the same color as if the cursor
    -- wasn't focused on the outline window.
    -- This feature is experimental.
    hide_cursor = false,

    -- Whether to auto-focus on the outline window when it is opened.
    -- Set to false to *always* retain focus on your previous buffer when opening
    -- outline.
    -- If you enable this you can still use bangs in :Outline! or :OutlineOpen! to
    -- retain focus on your code. If this is false, retaining focus will be
    -- enforced for :Outline/:OutlineOpen and you will not be able to have the
    -- other behaviour.
    focus_on_open = true,
    -- Winhighlight option for outline window.
    -- See :help 'winhl'
    -- To change background color to "CustomHl" for example, use "Normal:CustomHl".
    winhl = '',
  },

  outline_items = {
    -- Show extra details with the symbols (lsp dependent) as virtual next
    show_symbol_details = true,
    -- Show corresponding line numbers of each symbol on the left column as
    -- virtual text, for quick navigation when not focused on outline.
    -- Why? See this comment:
    -- https://github.com/simrat39/symbols-outline.nvim/issues/212#issuecomment-1793503563
    show_symbol_lineno = false,
    -- Whether to highlight the currently hovered symbol and all direct parents
    highlight_hovered_item = true,
    -- Whether to automatically set cursor location in outline to match
    -- location in code when focus is in code. If disabled you can use
    -- `:OutlineFollow[!]` from any window or `<C-g>` from outline window to
    -- trigger this manually.
    auto_set_cursor = true,
    -- Autocmd events to automatically trigger these operations.
    auto_update_events = {
      -- Includes both setting of cursor and highlighting of hovered item.
      -- The above two options are respected.
      -- This can be triggered manually through `follow_cursor` lua API,
      -- :OutlineFollow command, or <C-g>.
      follow = { 'CursorMoved' },
      -- Re-request symbols from the provider.
      -- This can be triggered manually through `refresh_outline` lua API, or
      -- :OutlineRefresh command.
      -- items = { 'InsertLeave', 'WinEnter', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' },
    },
  },

  -- Options for outline guides which help show tree hierarchy of symbols
  guides = {
    enabled = true,
    markers = {
      -- It is recommended for bottom and middle markers to use the same number
      -- of characters to align all child nodes vertically.
      bottom = '└',
      middle = '├',
      vertical = '│',
    },
  },

  symbol_folding = {
    -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
    autofold_depth = 1,
    -- When to auto unfold nodes
    auto_unfold = {
      -- Auto unfold currently hovered symbol
      hovered = true,
      -- Auto fold when the root level only has this many nodes.
      -- Set true for 1 node, false for 0.
      only = true,
    },
    markers = { '', '' },
  },

  preview_window = {
    -- Automatically open preview of code location when navigating outline window
    auto_preview = false,
    -- Automatically open hover_symbol when opening preview (see keymaps for
    -- hover_symbol).
    -- If you disable this you can still open hover_symbol using your keymap
    -- below.
    open_hover_on_preview = true,
    width = 50,     -- Percentage or integer of columns
    min_width = 50, -- Minimum number of columns
    -- Whether width is relative to the total width of nvim.
    -- When relative_width = true, this means take 50% of the total
    -- screen width for preview window, ensure the result width is at least 50
    -- characters wide.
    relative_width = true,
    height = 50,     -- Percentage or integer of lines
    min_height = 10, -- Minimum number of lines
    -- Similar to relative_width, except the height is relative to the outline
    -- window's height.
    relative_height = true,
    -- Border option for floating preview window.
    -- Options include: single/double/rounded/solid/shadow or an array of border
    -- characters.
    -- See :help nvim_open_win() and search for "border" option.
    border = 'single',
    -- winhl options for the preview window, see ':h winhl'
    winhl = 'NormalFloat:',
    -- Pseudo-transparency of the preview window, see ':h winblend'
    winblend = 0,
    -- Experimental feature that let's you edit the source content live
    -- in the preview window. Like VS Code's "peek editor".
    live = true 
  },

  -- These keymaps can be a string or a table for multiple keys.
  -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
  keymaps = {
  --   show_help = '?',
  --   close = {'<Esc>', 'q'},
  --   -- Jump to symbol under cursor.
  --   -- It can auto close the outline window when triggered, see
  --   -- 'auto_close' option above.
  --   goto_location = '<Cr>',
  --   -- Jump to symbol under cursor but keep focus on outline window.
  --   peek_location = 'o',
  --   -- Visit location in code and close outline immediately
  --   goto_and_close = '<S-Cr>',
  --   -- Change cursor position of outline window to match current location in code.
  --   -- 'Opposite' of goto/peek_location.
  --   restore_location = '<C-g>',
  --   -- Open LSP/provider-dependent symbol hover information
  --   hover_symbol = '<C-space>',
  -- Preview location code of the symbol under cursor
  toggle_preview = 'K',
  --   rename_symbol = 'r',
  --   code_actions = 'a',
  --   -- These fold actions are collapsing tree nodes, not code folding
  --   fold = 'h',
  --   unfold = 'l',
  --   fold_toggle = '<Tab>',
  --   -- Toggle folds for all nodes.
  --   -- If at least one node is folded, this action will fold all nodes.
  --   -- If all nodes are folded, this action will unfold all nodes.
  --   fold_toggle_all = '<S-Tab>',
  --   fold_all = 'W',
  --   unfold_all = 'E',
  --   fold_reset = 'R',
  --   -- Move down/up by one line and peek_location immediately.
  --   -- You can also use outline_window.auto_jump=true to do this for any
  --   -- j/k/<down>/<up>.
  --   down_and_jump = '<C-j>',
  --   up_and_jump = '<C-k>',
  },

  providers = {
    priority = { 'lsp', 'coc', 'markdown', 'norg', 'man' },
    -- Configuration for each provider (3rd party providers are supported)
    lsp = {
      -- Lsp client names to ignore
      blacklist_clients = {},
    },
    markdown = {
      -- List of supported ft's to use the markdown provider
      filetypes = {'markdown'},
    },
  },

  symbols = {
    -- Filter by kinds (string) for symbols in the outline.
    -- Possible kinds are the Keys in the icons table below.
    -- A filter list is a string[] with an optional exclude (boolean) field.
    -- The symbols.filter option takes either a filter list or ft:filterList
    -- key-value pairs.
    -- Put  exclude=true  in the string list to filter by excluding the list of
    -- kinds instead.
    -- Include all except String and Constant:
    --   filter = { 'String', 'Constant', exclude = true }
    -- Only include Package, Module, and Function:
    --   filter = { 'Package', 'Module', 'Function' }
    -- See more examples below.
    filter = nil,

    -- You can use a custom function that returns the icon for each symbol kind.
    -- This function takes a kind (string) as parameter and should return an
    -- icon as string.
    ---@param kind string Key of the icons table below
    ---@param bufnr integer Code buffer
    ---@param symbol outline.Symbol The current symbol object
    ---@returns string|boolean The icon string to display, such as "f", or `false`
    ---                        to fallback to `icon_source`.
    icon_fetcher = nil,
    -- 3rd party source for fetching icons. This is used as a fallback if
    -- icon_fetcher returned an empty string.
    -- Currently supported values: 'lspkind'
    icon_source = nil,
    -- The next fallback if both icon_fetcher and icon_source has failed, is
    -- the custom mapping of icons specified below. The icons table is also
    -- needed for specifying hl group.
    icons = {
      File = { icon = '󰈔', hl = 'Identifier' },
      Module = { icon = '󰆧', hl = 'Include' },
      Namespace = { icon = '󰅪', hl = 'Include' },
      Package = { icon = '󰏗', hl = 'Include' },
      Class = { icon = '𝓒', hl = 'Type' },
      Method = { icon = 'ƒ', hl = 'Function' },
      Property = { icon = '', hl = 'Identifier' },
      Field = { icon = '󰆨', hl = 'Identifier' },
      Constructor = { icon = '', hl = 'Special' },
      Enum = { icon = 'ℰ', hl = 'Type' },
      Interface = { icon = '󰜰', hl = 'Type' },
      Function = { icon = '', hl = 'Function' },
      Variable = { icon = '', hl = 'Constant' },
      Constant = { icon = '', hl = 'Constant' },
      String = { icon = '𝓐', hl = 'String' },
      Number = { icon = '#', hl = 'Number' },
      Boolean = { icon = '⊨', hl = 'Boolean' },
      Array = { icon = '󰅪', hl = 'Constant' },
      Object = { icon = '⦿', hl = 'Type' },
      Key = { icon = '🔐', hl = 'Type' },
      Null = { icon = 'NULL', hl = 'Type' },
      EnumMember = { icon = '', hl = 'Identifier' },
      Struct = { icon = '𝓢', hl = 'Structure' },
      Event = { icon = '🗲', hl = 'Type' },
      Operator = { icon = '+', hl = 'Identifier' },
      TypeParameter = { icon = '𝙏', hl = 'Identifier' },
      Component = { icon = '󰅴', hl = 'Function' },
      Fragment = { icon = '󰅴', hl = 'Constant' },
      TypeAlias = { icon = ' ', hl = 'Type' },
      Parameter = { icon = ' ', hl = 'Identifier' },
      StaticMethod = { icon = ' ', hl = 'Function' },
      Macro = { icon = ' ', hl = 'Function' },
    },
  },
})

-- Key mappings for opening/closing folds
-- ======================================
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
require('ufo').setup()


--  Nvim Tree " Following is the way to configure lua in init.vim
-- """"""""""""""""
require("nvim-tree").setup({
  git = {
    ignore = false,
  }
})

-- Toggle Terminal
-- """"""""""""""""
require("toggleterm").setup()

-- Claude code 
-- """"""""""""
require("claude-code").setup({
  -- Terminal window settings
  window = {
    split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
    position = "botright",  -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
    enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
    hide_numbers = true,    -- Hide line numbers in the terminal window
    hide_signcolumn = true, -- Hide the sign column in the terminal window
  },
  -- File refresh settings
  refresh = {
    enable = true,           -- Enable file change detection
    updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
    timer_interval = 1000,   -- How often to check for file changes (milliseconds)
    show_notifications = true, -- Show notification when files are reloaded
  },
  -- Git project settings
  git = {
    use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
  },
  -- Command settings
  command = "claude",        -- Command used to launch Claude Code
  -- Keymaps
  keymaps = {
    toggle = {
      normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
      terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
    },
    window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
    scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
  }
})

print('hello prem')
-- Lua snips load plugins from the file
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/custom-snippets" } })
--require("luasnip.loaders.from_vscode").lazy_load()


-- Setup hardtime
require("hardtime").setup()


-- Setup todo-comments
require("todo-comments").setup()

EOF
