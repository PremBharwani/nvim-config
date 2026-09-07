" {{{{ Plugin manager installation
" ================================
	" Vim-plug plugin manager installation
	" Automatic installaion of vim-plug
	if empty(glob('~/.config/nvim/autoload/plug.vim'))
	    silent !mkdir -p ~/.config/nvim/autoload
	    silent !curl -fLo ~/.config/nvim/autoload/plug.vim
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall
	endif
" }}}}

" {{{{ Plugins list
" ================================
	call plug#begin('~/.config/nvim/plugged')

	Plug 'tpope/vim-sensible'			" because tpope is a goat
	Plug 'tpope/vim-surround'			" surround visually selected stuff ( add / remove / change parenthesis etc.)
	Plug 'tpope/vim-fugitive'			" git plugin

	" Pre-reqs for fzf plugin:
	" fzf for searching - `$ sudo apt install fzf` or (https://github.com/junegunn/fzf#installation)
	" bat too for pretty out - `$ sudo apt install bat` or (https://github.com/sharkdp/bat#installation)
	" rg - $ sudo apt-get install ripgrep or (https://github.com/BurntSushi/ripgrep#installation)
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

	Plug 'ellisonleao/gruvbox.nvim'		" Grubox theme
	
	Plug 'PremBharwani/scratchpad'	" scratchpad like i3wm

  Plug 'moll/vim-bbye'						" Close buffers without closing windows

	Plug 'stevearc/oil.nvim'				" File navigator
	Plug 'nvim-tree/nvim-web-devicons'	" Icons for oil.nvim and friends

	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}	" Proper syntax highlighting

	call plug#end()
" }}}}

" {{{{ Visual stuff (themes, etc.)
" ================================
	set termguicolors
	set background=dark " or light if you want light mode
	colorscheme gruvbox
" }}}}


" {{{{ Basic Mappings & configs
" =============================

	let g:mapleader = " "	" leader mapping to space
	set modifiable		" set modifiable for live reloading
	set mouse=a		" allow mouse usage


	set number		" show numbering
	set relativenumber	" set relative numbering
	set title		" set title of the terminal

	" Tabstop & shift widhth
	set tabstop=2
	set shiftwidth=2

	set incsearch							" Highlight terms as i type
	set ignorecase

	" Disable wrapping & allow horizontal scroll
	set nowrap         " Disable text wrapping
	set sidescroll=1   " Scroll horizontally 1 column at a time
	set sidescrolloff=8 " Keep 8 columns visible to the left/right of the cursor


" }}}}

" {{{{ Auto save
	augroup AutoSave
	    autocmd!
	    autocmd TextChanged,TextChangedI * if &modifiable && &modified && &buftype == '' && expand('%') != '' | silent write | endif
	augroup END
" }}}}


" {{{{ oil.nvim setup
" ================================
	lua << EOF
require('oil').setup({
  default_file_explorer = true, -- default file explorer
	columns = {
    "icon",
    -- "size",
    -- "permissions",
    -- "mtime",
  },
  float = {
    padding = 2,
    max_width = 0.8,
    max_height = 0.8,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
})
EOF

	nnoremap <silent> <C-n> :lua require('oil').toggle_float()<CR>
" }}}}

" {{{{ treesitter setup
" ================================
	lua << EOF
require('nvim-treesitter').setup()

local ts_langs = { "vim", "vimdoc", "bash", "json", "markdown" }

require('nvim-treesitter').install(ts_langs)

vim.api.nvim_create_autocmd('FileType', {
  pattern = ts_langs,
  callback = function()
    vim.treesitter.start()
  end,
})
EOF
" }}}}

" {{{{ custom keybinds
" ====================

	" edit & reload vimrc
	nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
	nnoremap <silent> <leader>sv :so $MYVIMRC<CR>


	" Buffer management
	nnoremap <silent> <Leader>q :Bdelete<CR>                                            " Close active buffer
	nnoremap <silent> <Leader><S-q> :Bdelete!<CR>                                       " Force Close active buffer (Closes unsaved buffers)
	nnoremap <silent> <Leader>bc :BufOnly<CR>                                           " Close all buffers except the current one - Uses custom method CloseAllButCurrentBdelete()
	nnoremap <silent> <leader>t :enew<CR>                                               " New empty buffer
	nnoremap <silent> <leader>i :echo expand("%:p")<CR>                                 " Show full path of current file 

	" Git
	nnoremap <silent> <leader>b :Git blame<CR>

	" Fzf buffers
	nnoremap <silent> <leader>h :Files<CR>
	nnoremap <silent> <leader>g :GFiles?<CR> 
	nnoremap <silent> <leader>; :Buffers<CR>
	nnoremap <silent> <leader>f :Rg<CR>
	
	" Pane navigation
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l

	" Paste from clipboard
	nnoremap <leader>v :set paste<CR>"+p:set nopaste<CR>
	" Copy selected text to clipboard
	vnoremap <leader>y "+y
	" Reselect yanked text
	nnoremap gy `[v`]
	" Search your selection in visual mode selection
	vnoremap // y/\V<C-R>=escape(@", '/\')<CR><CR>

	nnoremap <silent> <Esc><Esc> :nohlsearch<CR>			" get rid of highlights once search done

	" Terminal shortcut (leader + enter key to open :terminal)
	nnoremap <silent> <leader><CR> :terminal<CR>
	" Escape terminal mode back to normal mode with just Ctrl-\
	tnoremap <C-\> <C-\><C-n>

	" Hack to have the search terms cleared up once we hit escape and are done 
	nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" }}}}


" {{{{ Custom functions & commands
" ================================
	" Close all buffers except those visible in windows using Bdelete
	function! CloseAllButVisibleBdelete()
	  " Collect all buffer numbers currently visible in any window
	  let visible_bufs = []
	  for win in getwininfo()
	    if index(visible_bufs, win.bufnr) == -1
	      call add(visible_bufs, win.bufnr)
	    endif
	  endfor

	  " Close all listed buffers that are not visible
	  for buf in getbufinfo({'buflisted': 1})
	    if index(visible_bufs, buf.bufnr) == -1
	      execute 'Bdelete!' buf.bufnr
	    endif
	  endfor
	endfunction
	" Alias for CloseAllButVisibleBDelete()
	command! BufOnly call CloseAllButVisibleBdelete()
" }}}}
