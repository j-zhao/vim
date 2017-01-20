""""""""""""""""""""""""""""""""""""""""""
" JESSE ZHAO's VIMRC
" Last modified: 1/20/2017
""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""
" VUNDLE
""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=%HOME%/vimfiles/bundle/Vundle.vim/
call vundle#begin('%USERPROFILE%/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" Closes braces automatically
inoremap { {<CR><BS>}<Esc>
inoremap ( ()<Esc>
inoremap " ""<Esc>
inoremap [ []<Esc>
inoremap < <><Esc>

inoremap (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap    <  <><left>
inoremap <expr> >   strpart(getline('.'), col('.')-1,1) == ">" ? "\<Right>" : ">"

"""""""""""""""""""""""""""""""""""""""""
" CUSTOM SETTINGS
"""""""""""""""""""""""""""""""""""""""""

set mouse=a

syntax enable
set background=dark
colorscheme solarized

set tabstop=4 shiftwidth=4 expandtab
set listchars=tab:>~,nbsp:_,trail:.,eol:$,extends:>,precedes:<
set list
set smarttab
set smartindent
set autoindent
set number
set colorcolumn=80
set number
set guifont=Consolas:h15

"Startup directory
cd C:\Projects

"DirectX
set renderoptions=type:directx,geom:1,taamode:1
set enc=utf-8

"""""""""""""""""""""""""""""""""""""""""
" DEVELOPER SETTINGS
"""""""""""""""""""""""""""""""""""""""""

" Start NERDTree Automatically
autocmd vimenter * NERDTree

set directory=.,$TEMP
set autowrite
""""Hotkeys for Java
" F9/F10 to make with javac/compile.
" F5 to run file.

autocmd FileType java :set makeprg=javac\ %
"map <F9> :set makeprg=javac\ %<CR>:make<CR>
map <F9> :make<CR>
map <F10> :!javac %<CR>
map <F11> :!java %:r

""""Hotkeys for Python
" F5/F6 to make with Python/run
"map <F5> :set makeprg=python\ %<CR>:make<CR>
autocmd FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<CR>

" Save/Open Sessions
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3

set errorformat=%A:%f:%l:\ %m,%-Z%p^,%-C%.%#

" If two files are loaded, switch to the alternate file, then back.
" That sets # (the alternate file).
if argc() == 2
  n
  e #
endif

"""""""""""""""""""""""""""""""""""""""""
" COSMETIC STUFF
"""""""""""""""""""""""""""""""""""""""""
""Highlight over 80 characters
""highlight OverLength ctermbg=red ctermfg=white guibg=#592929
""match OverLength /\%81v.\+/

" statusline
set laststatus=2            " always statusbar
set statusline=%{getcwd()}: " pwd of vim
set statusline+=\ %f%m%=    " relative path to filename, modified flag, RHS
set statusline+=%c,         " char number
set statusline+=%l/%L\ %y   " curr line/total line [filetype]

" always show tabline (2) or only show when multiple (1)
set showtabline=1

" if persistent_undo, configure a directory for it
if has("persistent_undo")
    set undodir=$HOME/.undodir/
    set undofile
endif

""Show tab numbers
set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
""/

""Tooltip to show multiple windows in a tab
" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif
    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunction
set guitabtooltip=%{GuiTabToolTip()}
""/

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

