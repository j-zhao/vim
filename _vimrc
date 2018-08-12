" Modeline and Notes {{{
    " vim: set foldmethod=marker foldlevel=0 et :
" }}}

""""""""""""""""""""""""""""""""
" README
""""""""""""""""""""""""""""""""
"   Author: Jesse Zhao
"   github.com/j-zhao
"   Last Modified: 04-18-2018
""""""""""""""""""""""""""""""""

" Vundle, and Plugins {{{
    " Vundle {{{
        set nocompatible              " be iMproved, required
        filetype off                  " required

    " set the runtime path to include Vundle and initialize
        if has('win32')
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

        Plugin 'udalov/kotlin-vim'
        Plugin 'ervandew/supertab'
        Plugin 'kien/rainbow_parentheses.vim'
        Plugin 'scrooloose/nerdtree'
        Plugin 'jistr/vim-nerdtree-tabs'
        "Plugin 'Valloric/YouCompleteMe'
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'altercation/vim-colors-solarized'
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'tpope/vim-fugitive'
        "Plugin 'tpope/vim-surround'
        "Plugin 'tpope/vim-obsession'
        "Plugin 'tpope/vim-sleuth'
        Plugin 'ciaranm/detectindent'
        "Plugin 'vim-syntastic/syntastic'
        Plugin 'xolox/vim-session'
        Plugin 'xolox/vim-misc'
        Plugin 'airblade/vim-gitgutter'
        Plugin 'dzeban/vim-log-syntax'
        Plugin 'scrooloose/nerdcommenter'
        "Plugin 'leafgarland/typescript-vim'
        Plugin 'tpope/vim-sensible'
"        Plugin 'tomasr/molokai'

        if has('gui_running')
        endif

        if has('unix')
            Plugin 'Valloric/YouCompleteMe'
        endif

        "if !has('nvim')
        "endif

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

" Functions and AutoCommands {{{

    " Autostart Obsession
    "autocmd VimEnter * call AutoSourceObsession()
"    autocmd VimEnter * call VimSessionAutoStart()

    augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END

"    function! VimSessionAutoStart()
"        OpenSession
"        SaveSession
"    endfunction

"    function! AutoSourceObsession()
"        if !argc() && empty(v:this_session) && filereadable('~/.vim/Obsession.vim') && !&modified
"            source ~/.vim/Obsession.vim
"            Obsession ~/Obsession.vim
"        else
"            Obsession ~/Obsession.vim
"        endif
"    endfunction

    function! OpenVimrcs()
        tabnew $MYVIMRC
        if has ('unix')
            vnew ~/Dropbox/Programming/Vim/.vimrc
            vnew ~/Dropbox/Programming/Vim/_vimrc
        elseif has ('win32')
            vnew D:/Dropbox/Programming/Vim/_vimrc
            vnew D:/Dropbox/Programming/Vim/.vimrc
        endif
    endfunction
" }}}

" Environment Configs and Startup {{{
    if has('nvim')
       set rtp+=/usr/share/vim/vim74
    else
    endif

    if has('win32')
        " Startup directory
        cd D:\Projects
        set enc=utf-8
        behave mswin
        set directory^=$HOME/tmp
        " DirectX
        if !has('nvim')
            set renderoptions=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
        endif
    endif

    if has('unix')
        "Startup directory
        set t_BE=
        cd ~/Projects
    endif

    " Startup
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
    inoremap <expr> <CR> strpart(getline('.'), col('.')-1, 1) == '}' ? '<CR><CR><Up><Tab>' : '<CR>'
"    inoremap '  ''<Left>
"    inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == '\'' ? '\<Right>' : '\'\'\<Left>'
    inoremap "  ""<Left>
    inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

    if !has('macunix')
        nmap <C-a> ggVG$
        map <C-c> "+y
        map <C-v> "+p
    endif

    " Save/Open Sessions
    "map <F2> :Obsess ~/Obsession.vim
    "map <F3> :source ~/Obsession.vim
    " Quick write session with F2
    "map <F2> :mksession! ~/.vim/Session.vim
    "map <F3> :source ~/.vim/Session.vim
    map <F2> :SaveSession
    map <F3> :OpenSession
    map <F4> :call OpenVimrcs()
" }}}

" Plugin Settings and Cosmetics {{{
    " Rainbow Parens Always on
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

        " NERDTree/NERDTreeTabs
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    map <C-n> :NERDTreeTabsToggle<CR>
    let g:nerdtree_tabs_open_on_console_startup=0
    let NERDTreeShowBookmarks=1
    let g:nerdtree_tabs_synchronize_focus=1
    let g:nerdtree_tabs_focus_on_files=1
    let g:nerdtree_tabs_autofind=1
    let g:nerdtree_tabs_synchronize_view=0

    " Indent Guides
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size=1

    " Syntastic
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

    " Solarized
    let g:solarized_termtrans=1
"    let g:solarized_termcolors=256
"    let g:solarized_contrast='high'

    " Vim-Session
    let g:session_autosave='yes'

    " GitGutter
    set updatetime=250

    " DetectIndent
    autocmd BufReadPost * :DetectIndent

    " Cosmetics
    " Statusline
    set laststatus=2            " always statusbar
    "set statusline=%{getcwd()}: " pwd of vim
    "set statusline+=\ %f%m%=    " relative path to filename, modified flag, RHS
    "set statusline+=%c,         " char number
    "set statusline+=%l/%L\ %y   " curr line/total line [filetype]
    "set statusline+=%{fugitive#statusline()} " show current git branch with fugitive
    "set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%{ObsessionStatus('Obsessed','!Obsessed')}
    "set statusline+=%*

    " Airline
    let g:airline_detect_modified=1

    " Airline Theme
    let g:airline_solarized_bg='dark'
    let g:airline_powerline_fonts = 1
    "let g:airline#extensions#tabline#enabled = 1
"    let g:airline#extensions#tabline#left_sep = ' '
"    let g:airline#extensions#tabline#left_alt_sep = '|'

    " NERDCommenter
    let g:NERDCompactSexyComs = 1
    let g:NERDCommentEmptyLines = 1

" }}}

" Vim Customization {{{
    "source $VIMRUNTIME/vimrc_example.vim
    "source $VIMRUNTIME/mswin.vim
    scriptencoding utf-8
    set encoding=utf-8

    " Swap Files
    "    set directory=.,$TEMP

    if has ('win32')
        set directory^=$HOME/tmp//
    else
        set directory^=~/.vim/tmp//
    endif
"    set directory^=HOME/tmp//

    set noswapfile
    set relativenumber
    set linebreak
    set mouse=a
    set splitright
    set splitbelow
    set tabstop=4 shiftwidth=4 expandtab
"    set showbreak=\\
"    set listchars=tab:>~,nbsp:_,trail:.,extends:>,precedes:<
    if has('gui_running')
        set showbreak=↪\
"        set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
        set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
    else
        set listchars=tab:>~,nbsp:_,trail:.,extends:>,precedes:<
    endif
    set list
    set smarttab
    "set smartindent
    set autoindent
    set colorcolumn=121
    " Font
    if has ('win32')
"        set guifont=Consolas:h11
        set guifont=Fira\ Code:h11,Consolas:h11
    elseif has ('macunix')
"        set guifont=Menlo:h12
        set macligatures
    elseif has ('macunix')
        set guifont=Fira\ Code\ Retina:h12,Fira\ Code:h12, Menlo:h12
    elseif has ('unix')
        set guifont=Fira\ Mono\ Regular:h12,Fira\ Code\ Retina:h12,Fira\ Code:h12,Menlo:h12,Consolas:h12
    endif
    set number
    set showcmd

    "syntax enable
    syntax on
    set background=dark
    colorscheme solarized

" }}}

" Developer Settings {{{
    "set autowrite
    """"Hotkeys for Java
    " F9/F10 to make with javac/compile.
    " F5 to run file.

    autocmd FileType java :set makeprg=javac\ %
    "map <F9> :set makeprg=javac\ %<CR>:make<CR>
    map <F9> :make<CR>
    map <F10> :!javac %<CR>
    map <F11> :!java %:r

    " Smooth Scrolling
"    function SmoothScroll(up)
"        if a:up
"            let scrollaction="\"
"        else
"            let scrollaction="\"
"        endif
"        exec "norm " . scrollaction
"        redraw
"        let counter=1
"        while counter<&scroll
"            let counter+=1
"            sleep 10m
"            redraw
"            exec "norm " . scrollaction
"        endwhile
"    endfunction
"    nnoremap  :call SmoothScroll(1)
"    nnoremap  :call SmoothScroll(0)
"    inoremap  :call SmoothScroll(1)i
"    inoremap  :call SmoothScroll(0)i

    " Hotkeys for Python
    " F5/F6 to make with Python/run
    "map <F5> :set makeprg=python\ %<CR>:make<CR>
    autocmd FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<CR>

    set errorformat=%A:%f:%l:\ %m,%-Z%p^,%-C%.%#

    " If two files are loaded, switch to the alternate file, then back.
    " That sets # (the alternate file).
    if argc() == 2
      n
      e #
    endif
" }}}

" Cosmetic Stuff {{{

    " Syntax Highlighting {{{
        autocmd BufNewFile,BufRead *.ion  set syntax=java
    " }}}
    "Highlight over 80 characters
    "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    "match OverLength /\%81v.\+/

    " if persistent_undo, configure a directory for it
    if has("persistent_undo")
        set undodir=$HOME/.undodir/
        set undofile
    endif

    " always show tabline (2) or only show when multiple (1)
    " Show tab numbers
    set showtabline=2
    " always show tabs in gvim, but not vim
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
    function! MyDiff()
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

