" nocompatible
set nocompatible
filetype off

" Vundle
"if empty(glob('~/.vim/bundle/Vundle.vim'))
"    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"    autocmd VimEnter * PluginInstall
"endif
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"call vundle#end()

" VIM Plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'VundleVim/Vundle.vim'
Plug 'crusoexia/vim-monokai'
Plug 'tikhomirov/vim-glsl'
Plug 'jansenm/vim-cmake'
Plug 'thinca/vim-ref'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/unite.vim'
Plug 'kshenoy/vim-signature'
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-signify'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
call plug#end()

" Habit breaking
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>

" Tab sizes
autocmd FileType html setlocal ts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sw=2 expandtab

" Mappings
imap <C-f> <C-x><C-o>
nmap <F8> :TagbarToggle<CR>
nmap <F12> :set tabstop=2 shiftwidth=2 expandtab<CR>:retab<CR>:w<CR>
set cc=80

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" vim-go
let g:go_version_warning = 0
let g:go_fmt_autosave = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" Set configuration
set nowrap      " No text wrap
set number      " Line numbers
set relativenumber
set visualbell  " Turn off dinging
set showcmd     " Show commands
set hls         " Highlight search
set backspace=indent,eol,start
"set backup
"set undofile
set incsearch
set ruler
set history=128

if has("mouse")
    set mouse=a
endif
if has('autocmd')
    augroup vimrcEx
    au!
    autocmd FileType text setlocal textwidth=128
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
    augroup END
endif

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
    set langnoremap
endif

" Clipboard sharing
set clipboard=unnamed

" Set tabs to 4 spaces
filetype plugin indent on
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

filetype on
set cinoptions=:0,g0,(0,Ws,l1
set smarttab
autocmd FileType make set noexpandtab
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/syntax/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END


" Line highlighting
highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
if v:version >= 702
  " Lines longer than 80 columns.
  au BufWinEnter * let w:m0=matchadd('LongLine', '\%>80v.\+', -1)

  " Whitespace at the end of a line. This little dance suppresses
  " whitespace that has just been typed.
  au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
  au InsertEnter * call matchdelete(w:m1)
  au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
  au InsertLeave * call matchdelete(w:m2)
  au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
else
  au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
  au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
  au InsertLeave * syntax match WhitespaceEOL /\s\+$/
endif

" Monokai
syntax on
colorscheme onedark
highlight Normal ctermfg=grey ctermbg=black

" Syntax highlight for CUDA
au BufNewFile,BufRead *.cu set filetype=cuda
au BufNewFile,BufRead *.cuh set filetype=cuda

" Cursor type
if has("autocmd")
    au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
    au InsertEnter,InsertChange *
        \ if v:insertmode == 'i' |
        \   silent execute '!echo -ne "\e[5 q"' | redraw! |
        \ elseif v:insertmode == 'r' |
        \   silent execute '!echo -ne "\e[3 q"' | redraw! |
        \ endif
    au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" Trim Whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! Trimwhitespace call TrimWhitespace()
if has("autocmd")
    autocmd BufWritePre * :call TrimWhitespace()
endif


