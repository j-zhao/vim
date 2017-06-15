" Modeline and Notes {{{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldlevel=0 foldmethod=marker spell:
" }}}

""""""""""""""""""""""""""""""""
" README
""""""""""""""""""""""""""""""""
"   Author: Jesse Zhao
"   github.com/j-zhao
"   Last Modified: 06-15-2017
""""""""""""""""""""""""""""""""

" Vundle, and Plugins {{{
    " Vundle {{{
        set nocompatible              " be iMproved, required
        filetype off                  " required

    " set the runtime path to include Vundle and initialize
        if has ('win32' || 'win64')
            set rtp+=%USERPROFILE%/vimfiles/bundle/Vundle.vim
        else
            set rtp+=~/.vim/bundle/Vundle.vim
        endif
        call vundle#begin()

    " alternatively, pass a path where Vundle should install plugins
        "call vundle#begin('~/some/path/here')
    " }}}

    " Plugins {{{
        " let Vundle manage Vundle, required
        Plugin 'VundleVim/Vundle.vim'

        Plugin 'jistr/vim-nerdtree-tabs'
        Plugin 'udalov/kotlin-vim'
        Plugin 'ervandew/supertab'
        Plugin 'kien/rainbow_parentheses.vim'
        Plugin 'scrooloose/nerdtree'
        "Plugin 'Valloric/YouCompleteMe'
        Plugin 'vim-syntastic/syntastic'
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'altercation/vim-colors-solarized'
        Plugin 'bling/vim-airline'
        Plugin 'tpope/vim-fugitive'
        "Plugin 'tpope/vim-surround'

        if !has ('nvim')
            Plugin 'tpope/vim-sensible'
        endif

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
    " }}}
" }}}

" Environment Configs and Startup {{{
    if has ('nvim')
       set rtp+=/usr/share/vim/vim74
    else
    endif

    if has ('win32' || 'win64')
        "Startup directory
        "cd C:\Projects
        "DirectX
        set enc=utf-8
        behave mswin
        if !has ('nvim')
            set renderoptions=type:directx,geom:1,taamode:1
        endif
    endif

    if has ('unix')
        "Startup directory
        cd ~/Projects
    endif
" }}}

" Mappings {{{
    " Closes braces automatically
    inoremap (  ()<Left>
    inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
    inoremap [  []<Left>
    inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
    inoremap <  <><Left>
    inoremap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"
    inoremap {  {}<Left>
    inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
    inoremap '  ''<Left>
    inoremap <expr> <CR> strpart(getline('.'), col('.')-1, 1) == "}" ? "<CR><CR><Up><Tab>" : "<CR>"
    inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
    inoremap "  ""<Left>
    inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
" }}}

" Plugin Settings {{{
    " Rainbow Parens Always on
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

    " NERDTree
    autocmd vimenter * NERDTree "Start NERDTree Automatically
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeShowBookmarks=1

    "Indent Guides
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size=1

    "Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{{{SyntasticStatuslineFlag()}}}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

    "Solarized
    let g:solarized_contrast = "high"
" }}}

" Vim Customization {{{
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim

    set noswapfile

    set relativenumber
    set linebreak
    set mouse=a

    syntax enable
    set background=dark
    colorscheme solarized

    set tabstop=4 shiftwidth=4 expandtab
    set showbreak=↪\ 
    set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
    "set listchars=eol:↲
    "set listchars=tab:>~,nbsp:_,trail:.,extends:>,precedes:<
    "set listchars=eol:$,
    set list
    set smarttab
    "set smartindent
    set autoindent
    set colorcolumn=121
    set number
    set guifont=Consolas:h12
    set showcmd
" }}}

" Developer Settings {{{
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
" }}}

" Cosmetic Stuff {{{
    "Highlight over 80 characters
    "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    "match OverLength /\%81v.\+/

    " statusline
    set laststatus=2            " always statusbar
    set statusline=%{getcwd()}: " pwd of vim
    set statusline+=\ %f%m%=    " relative path to filename, modified flag, RHS
    set statusline+=%c,         " char number
    set statusline+=%l/%L\ %y   " curr line/total line [filetype]
    set statusline+=%{fugitive#statusline()} " show current git branch with fugitive

    " if persistent_undo, configure a directory for it
    if has("persistent_undo")
        set undodir=$HOME/.undodir/
        set undofile
    endif

    " always show tabline (2) or only show when multiple (1)
    " Show tab numbers
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

    " Tooltip to show multiple windows in a tab
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
" }}}

