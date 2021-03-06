" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

execute pathogen#infect()

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch            " Highlight the searches
set autowrite		" Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set mouse= 		" Enable mouse usage (all modes)
set expandtab           " Use softtabstop instead of tab for indentation
set shiftwidth=2	" Indentation 2 spaces
set softtabstop=2	" Indent 2 spaces when pressing TAB
set cindent		" Use cindent for indenting code
set tags=./.git/tags    " ctags file is automatically created with git commands like commit
                        " and saved to the .git directory (this is a solution
                        " from Tim Pope at
                        " http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
set wildmenu            " shows files during tab-complete in an extra line
set path+=**            " recursive search with find in subdirectories

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Highlight column 81
function! HighlightColumn81()
  if @% =~ '\vmpdv$'
    return
  endif
  highlight ColorColumn ctermbg=255 guibg=#2c2d27
  let &colorcolumn=join(range(81,999),",")
endfunction

autocmd BufRead,BufNewFile * call HighlightColumn81()

" Welcome ------------------------------------- {{{
echo "           /"
echo "          \\  / "
echo "           / \\/"
echo "            \\ /"
echo "             /\\"
echo "           /\\ /  "
echo "           \ /\\/"
echo "          / \\ / \\"
echo "       ~~~~~~~~~~~~~"
echo "       \\    /      /---/"
echo "        \\   \\//   /   /"
echo "         \\  / \\  /---/"
echo "          |     |"
echo "          ~~~~~~~"
echo "      Sugar Your Coffee"
" }}}

cabbr %% <C-R>=expand('%:p:h')<CR>

" Gloabal mappings ---------------------------- {{{

let mapleader = "-"
let localmapleader = "\\"

" open .vimrc in a new window
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source (reload) .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Turn the just type word to upper case in insert mode
inoremap <c-u> <esc>bviwUA
" Turn the word under the cursor to uppercase
nnoremap <c-u> viwU
" Highlite trailing white spaces > 1
nnoremap <leader>sw :match Error /\v\s{2,}$/<cr>
" Remove highlite for trailing white spaces 
nnoremap <leader>sW :match none<cr>
" Always start searching very magic
nnoremap / /\v

" Always start searching very magic
nnoremap / /\v

"  nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
" }}}

" JavaScript file settings--------------------- {{{
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" }}}

" RSpec file settings ------------------------- {{{
  au FileType ruby iabbrev dob before do<return>end<esc>O
" }}}

" Settings for GVim --------------------------- {{{
if has('gui_running')
  set grepprg=grep\ -nH\ $*
  filetype indent on
  let g:tex_flavor='latex'
endif
" }}}

" Vimscript file settings--------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup end
" }}}

" markdown file settings--------------------- {{{
augroup filetype_markdown
  autocmd!
  au BufRead,BufNewFile *.md set filetype=markdown
  au FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\\(-\\\|=\\)\\{2,\\}\r:nohlsearch\rkvg_"<cr>
  au FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\\(-\\\|=\\)\\{2,\\}\r:nohlsearch\rg_vk0"<cr>
augroup end
" }}}

" Ruby file settings--------------------- {{{
augroup filetype_ruby
  autocmd!

  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1

  set suffixesadd+=.rb
  set path+=.,/usr/include,,

  " run current file in Ruby
  nmap <leader>rr :!ruby %<CR>

  " mark a block visually and -c will comment out the block
  au FileType ruby inoremap <buffer> <localleader>c I# <esc>
  " comment out the current line in normal mode
  au FileType ruby nnoremap <buffer> <localleader>c I# <esc>

  " Ruby abbreviations

  au FileType ruby iabbrev mo module<return>end<esc><up>A
  au FileType ruby iabbrev cl class<return>end<esc><up>A
  au FileType ruby iabbrev def def<return>end<esc><up>A
  au FileType ruby iabbrev rr require_relative ''<left>
  au FileType ruby iabbrev <buffer> iff if<return>end<esc><up>A
  au FileType ruby iabbrev <buffer> doo do<return>end<esc>O
  au FileType ruby iabbrev <buffer> do\| do \|<return>end<esc><up>$A
  au FileType ruby iabbrev <buffer> { {}<left>
  au FileType ruby iabbrev <buffer> } <esc>A

augroup END
" }}}

" Lines added by the Vim-R-plugin command :RpluginConfig (2014-Nov-04 21:19):
filetype plugin on
" Change the <LocalLeader> key:
let maplocalleader = ","
" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
    set mouse=a
else
    inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Force Vim to use 256 colors if running in a capable terminal emulator:
if &term =~ "xterm" || &term =~ "256" || $DISPLAY != "" || $HAS_256_COLORS == "yes"
    set t_Co=256
endif

" There are hundreds of color schemes for Vim on the internet, but you can
" start with color schemes already installed.
" Click on GVim menu bar "Edit / Color scheme" to know the name of your
" preferred color scheme, then, remove the double quote (which is a comment
" character, like the # is for R language) and replace the value "not_defined"
" below:
"colorscheme not_defined
"

set runtimepath+=/home/pierre/Work/VimL/mpc/
" set runtimepath+=~/Work/vimnote/

" autocmd BufNewFile *.mom.md 0r ~/.vim/templates/mom.md
" nnoremap <c-j> /<+.\{-1,\}+><cr>c/+>/e<cr>
" inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

let g:notes_dir="~/Documents/vimnote/"

let g:elm_format_autosave = 1
