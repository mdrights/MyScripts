" My customizations
set nu
set go=
"colorscheme desert
"set guifont=Courier_New:h12:cANSI
syntax on
set nocompatible
set encoding=utf-8
set showcmd
"winpos 5 5
"set lines=80 columns=155
set termencoding=utf-8
set encoding=utf-8
set clipboard+=unnamed
set nobackup
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ignorecase
autocmd InsertLeave * se cul		"underlining when leaving edit mode.
autocmd InsertEnter * se nocul

" plugin: Powerline
set laststatus=2
set rtp+=/usr/local/repo/powerline/powerline/bindings/vim

" Punc auto-complete
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

