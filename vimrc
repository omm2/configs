﻿" My .vimrc file
"
" Author: Konstantin Bukley <madundead@gmail.com>
" Raw version: http://raw.github.com/madundead/stuff/master/vim/vimrc
" 
" Inspired by:
" Vincent Driessen <vincent@datafox.nl> 
" https://raw.github.com/nvie/vimrc/master/vimrc
"
" amix the lucky stiff
" http://amix.dk/vim/vimrc.html
"
" Colorscheme:
" Ethan Schoonover
" https://github.com/altercation/solarized
"
" Feel free to use, modify or share this file 


" ========================================================
" -> General
" ========================================================

" turn off vi-compatible mode
if &compatible
  set nocompatible
endif

set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)

" encoding
set encoding=utf-8                                  
set fileencoding=utf-8
set termencoding=utf-8

" quantity of lines vim have to remember
set history=500

" includes ftplugin.vim which is responsible for filetype detection
filetype plugin on

" set syntax highlighting
syntax on

" setting up <leader>
let mapleader=","
let g:mapleader=","


" ========================================================
" -> Colors & Fonts
" ========================================================

if has('gui_running')
	winpos 0 0
	set lines=999 columns=999    " trying to maximize
	set guioptions-=T            " remove toolbar
	set guioptions-=m            " remove menubar
	set guioptions+=LlRrb        " remove
	set guioptions-=LlRrb        " scrollbars
	colorscheme solarized        " awesome colorscheme
	set background=light         " realy nice :3 

	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_win32")
		set guifont=Monaco:h10:cANSI " problem, textmate?
	endif
else 
	" TODO: improve  non-gui section
	colorscheme torte
	set background=dark
endif


" ========================================================
" -> User Interface
" ========================================================

" enables menu at the bottom
set wildmenu
" highlight search
set hlsearch
" do not redraw while running macros
set lazyredraw
" status line google for tokens
set statusline=%f\ %m%r%h%w[%{&ff}]%y[%p%%]
" show status even for single buffer displayed
set laststatus=2
" highlight current line
set cursorline
" number rows
set number
" disable welcome message 
set shortmess+=I
" show matching braces
set showmatch
" shows when you are in insert mode
set showmode
" shows commands in right bottom corner 
set showcmd
" show cursor position all the tiem
set ruler
" show title in console status bar
set title
" dont wrap lines
set nowrap
" when I scroll up or down, there are 2 lines between the line I'm on and the bottom or top of the screen. 
set scrolloff=2


" ========================================================
" -> Behavior & Different Tricks
" ========================================================

" copying to clipboard
set clipboard=autoselect,unnamed,exclude:cons\|linux
" dunno
set matchtime=2
" force backspace to behave like in any other editor
set backspace=2
" editor will start searching when you type the first character of the search string
set incsearch
" turn off visualbell
set novisualbell
" no ~ backup files
set nobackup
" do not write annoying intermediate swap files,
set noswapfile

" ========================================================
" -> Indentations
" ========================================================

" automatically inserts one extra level of indentation in some cases
set smartindent
" affects how <TAB> key presses are interpreted depending on where the cursor is
set smarttab
" tab counts as 4 columns
set tabstop=4
" numbers of spaces to (auto)indent
set shiftwidth=4


" ========================================================
" -> Filetype Dependent Settings
" ========================================================

if has("autocmd")
	" phtml => html
	autocmd BufNewFile,BufRead *.phtml set filetype=html

	" Gemfile => rb
	autocmd BufNewFile,BufRead Gemfile,Vagrantfile setlocal filetype=ruby

	" YAML
	autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

    augroup html_files "{{{
        au!
    augroup end " }}}

	augroup ruby_files "{{{
        au!
        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup css_files "{{{
        au!
        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!
    augroup end "}}}
endif


" ========================================================
" -> Filetype Depended Settings
" ========================================================

" make p in visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" swtich between windows by <Ctrl> + arrows (that's not nice at all)
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" change size of vsplited buffers by <Alt> + arrows
map <A-Left> <C-W><
map <A-Right> <C-W>>

" space in normal mode
 nnoremap <Space> i<Space><Esc>   

" ; = : 
nnoremap ; :

" don't move on *
nnoremap * *<c-o>

" folding
nnoremap <F4> za

" switching between tabs
nmap <silent> <C-Tab> :tabnext<CR>
nmap <silent> <C-S-Tab> :tabprevious<CR>

" vertical split by F2
nmap <silent> <F2> :vsplit<CR>

" remove search highlight
nmap <silent> <C-N> :silent noh<CR>

" Use the damn hjkl keys
" fucking smart!
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" cd \\webtools.kha.gameloft.org\konstantin.bukley\gprod3\trunk

" Mode Indication -Prominent!
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=red
    set cursorcolumn
  elseif a:mode == 'r'
    hi statusline guibg=blue
  else
    hi statusline guibg= magenta
  endif
endfunction

function! InsertLeaveActions()
  hi statusline guibg=green
  set nocursorcolumn
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()

" to handle exiting insert mode via a control-C
inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>

" default the statusline to green when entering Vim
hi statusline guibg=green

au FocusLost * :wa


" added recently 
" TODO: find fancy symbols

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" leader + , to launch NERDTree
nmap <leader>, :NERDTree <CR>

"open NERDTree in every tab
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd w

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:>-,eol:¬

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

map N Nzz
map n nzz

" to save session
autocmd VIMEnter * :source C:/Users/annap/session.vim
autocmd VIMLeave * :mksession! C:/Users/annap/session.vim

autocmd VIMEnter * :set tags=C:/Users/annap/tags

" for taglist Plugin
let Tlist_Ctags_Cmd = "C:/Users/annap/ctags58/ctags.exe"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
map <F8> :!C:/Users/annap/ctags58/ctags.exe -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

