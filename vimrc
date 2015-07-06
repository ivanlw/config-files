""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The setting before Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
set background=dark
colorscheme gruvbox
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setting
set encoding=utf-8                              " Set the encoding for new file
set ffs=unix,dos,mac                            " Set Unix as standard file type
syntax on
set number
set backspace=indent,eol,start                  " Enable backspace all the time
set whichwrap+=<,>,h,l                          " ?
set hlsearch                                    " Highlight search result
set incsearch                                   " Incremental search
set cursorline
set clipboard+=unnamed                          " Make yank and pasge working across Vims
set mouse=a                                     " Mouse Navigation
" Wrap settings
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
set nowrap                                      " Don't wrap lines
" Auto reload .vimrc if it has been changed
autocmd! bufwritepost _vimrc source %           " Windows
autocmd! bufwritepost .vimrc source %           " *nix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent setting, use 4 spaces for tab
" http://vim.wikia.com/wiki/Indenting_source_code
set tabstop=4                                   " length of <TAB>
set softtabstop=4                               " Delete 4 spaces, if generated using <TAB>
set expandtab                                   " When press <TAB> key, insert 'softtabstop' amount of space
set shiftwidth=4                                " Affects when press >>, << or ==
set smartindent                                 " Add extra level of indent in some cases, compared to autoindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
set foldmethod=indent	                        " http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
set foldlevelstart=20                           " files will be loaded with opend folds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * :%s/\s\+$//e              " Delete all trailing whitespaces on save
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 80 words onwards as 'warning' and 120 words as 'danger'
" For both 80 columns and 120 columns limitation
if exists('+colorcolumn')
    let &colorcolumn = "81,".join(range(121,999),",")
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The begining of Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                                " be iMproved, required by Vundle
filetype off                                    " Required, open later
set rtp+=~/.vim/bundle/Vundle.vim               " Set the runtime path to include Vundle and initialize
call vundle#begin()                             " Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'tolinwei/vim-airline'                   " forked repo to switch mode color of tomorrow theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2                                " Set airline to appear all the time
set timeoutlen=50                               " Remove the pause when leaving insert mode
let g:airline_theme = 'tomorrow'
let g:airline#extensions#tagbar#enabled=0       " Lazily load tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/nerdtree'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
" Open NERDTree automatically when vim starts up
"autocmd VimEnter * NERDTree | wincmd p
" Set NERDTree on right side, would be conflict with tagbar
" let g:NERDTreeWinPos="right"
" Set NERDTree length
let g:NERDTreeWinSize = 30
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" Close all open buffers on entering a window if the only buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'nathanaelkane/vim-indent-guides'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startup vim-indent-guides with vim
let g:indent_guides_enable_on_vim_startup = 1
" Set width of vim-indent-guides
let g:indent_guides_guide_size = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Need to install Exuberant Ctags before usage
" http://ctags.sourceforge.net/
Plugin 'majutsushi/tagbar'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-t> :TagbarToggle<CR>
" Set width
let g:tagbar_width=40
" Open tagbar when open Vim with supported file/files
" autocmd VimEnter * nested :call tagbar#autoopen(1)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'kien/rainbow_parentheses.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" Always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'jiangmiao/auto-pairs'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'yonchu/accelerated-smooth-scroll'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/nerdcommenter'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" http://stackoverflow.com/questions/14226390/how-to-use-nerd-commenter-for-vim-how-to-use-leader-key
set timeout timeoutlen=1500
" Add extra space after comment symbol
let NERDSpaceDelims = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'Valloric/YouCompleteMe'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion = ['<Down>']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#end()                               " required for Vundle
filetype plugin indent on                       " required for Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change cursor shape between insert and normal mode in iTerm2.app
" block(default) vs vertical bar
" if $TERM_PROGRAM =~ "iTerm"
    " Vertical bar in insert mode
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " Block in normal mode
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

