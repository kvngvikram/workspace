" Things to note: 
" the letter 'z' is used for any kind of temporary register, mark etc
"
" This configuration assumes that vim is running inside a tmux session (while
" writing this, byobu is used instead of tmux).
" 
" There are mappings to directly open this file in new tab and in insert mode
" ';;' is mapped to escape and save the file.
"
" <Enter> or <CR> key is used in mappings assuming that it is not of much use
" in normal and visual mode. For the rest of the mappings a Leader key is used
" which can be changed. 


"""""""""""""""""""""""""""""   vim-plug   """""""""""""""""""""""""""""
" refer: https://github.com/junegunn/vim-plug
" vim-plug auto install if not installed 
if empty(glob('~/.vim/autoload/plug.vim'))
	" !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	!wget -P ~/.vim/autoload/ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
	call plug#begin()    " This line not found in the github (presently when writing this)
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



"""""""""""""""""""""""""""""    plugins   """""""""""""""""""""""""""""
" For new plugins add them to the list
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/ycm-core/YouCompleteMe'
"Plug 'https://github.com/ajh17/VimCompletesMe'

Plug 'jupyter-vim/jupyter-vim' 		" refer : https://github.com/wmvanvliet/jupyter-vim
Plug 'benmills/vimux'
"Plug 'ivanov/vim-ipython'
"Plug 'julienr/vim-cellmode'

call plug#end()
" To install new plugins enter this command once vim in opened 
" :PlugInstall



"""""""""""""""""""""""""""""   general    """""""""""""""""""""""""""""

" This is to have a bash like autocomplete
" set completeopt=menu,longest
set completeopt+=longest

" dictionary path
set dictionary+=/usr/share/dict/british-english

set nu rnu
set cursorline
set ruler

"let mapleader = ","
let mapleader = "\<Space>"

" always show statusline
set laststatus=2
set statusline=\ %F\ »\ %h%m%r\ %y%=\ %n\ »\ %-10.(%l,%c%V%)\ →\ %P

set smarttab
set tabstop=4
set shiftwidth=4
 
filetype plugin on 
filetype plugin indent on 
set autoindent
set smartindent

" Echo commands as they are being entered
set showcmd

syntax on
set background=dark
"color slate

" Disable beeping
set noerrorbells
" flash the screen for bell
"set visualbell 

" while searching jump to match
set incsearch
set hlsearch

" change the current working directory whenever you open a file, switch,delete buffer or open/close a window
set autochdir



"""""""""""""""""""""""""""""   mappings   """""""""""""""""""""""""""""
" mapping Esc key to '' in insert mode and also save the file and just Esc in
" Visual mode
inoremap ;; <Esc>:w<CR><Esc>
vnoremap <Leader><Leader> <Esc><Esc>
nnoremap <Leader><Leader> <Esc><Esc>
" mapping , to showing .vimrc file in normal mode 
nnoremap <Leader>, :tabnew ~/.vimrc<ENTER>
"Map j,k so that it will move DOWN,UP line by line for long wrapped lines.
nnoremap j gj
nnoremap k gk
" Mapping for navigation using relative numbers when lines are wrapped
" cant use <number>j when j is mapped to gj above. Refer: https://vi.stackexchange.com/a/16944
nnoremap <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
nnoremap <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'



"""""""""""""""""""""""""""""   tex_file   """""""""""""""""""""""""""""
autocmd BufReadPost,BufNewFile *.tex, inoremap <Leader>q <Esc>:w<CR><Esc>:!pdflatex %<CR><CR>
autocmd BufReadPost,BufNewFile *.tex, nnoremap <Leader>q <Esc>:w<CR><Esc>:!pdflatex %<CR><CR>

function! Tex_file_commands()
	inoremap <Leader>q <Esc>:w<CR><Esc>:!pdflatex %<CR><CR>
	nnoremap <Leader>q <Esc>:w<CR><Esc>:!pdflatex %<CR><CR>
endfunction
autocmd BufReadPost,BufNewFile *.tex, :call Tex_file_commands()


"""""""""""""""""""""""""""""  text_file   """""""""""""""""""""""""""""
function! Text_file_commands()
	"syntax might not work with spell
	syntax off
	" enable the spell check
	set spell  
	" disable the cursorline
"	set nocursorline 
"	hi clear SpellBad
"	hi SpellBad cterm=underline
	" replace a word with the first suggestion from dictionary
	nnoremap <CR> z=1<ENTER><ENTER> 
	" Lines from
	" http://www.panozzaj.com/blog/2016/03/21/ignore-urls-and-acroynms-while-spell-checking-vim/
	" Donn't mark URL-like things as spelling errors
	syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
	" Don't count acronyms / abbreviations as spelling errors
	" (all upper-case letters, at least three characters)
	" Also will not count acronym with 's' at the end a spelling error
	" Also will not count numbers that are part of this
	" Recognizes the following as correct:
	syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
endfunction
" execute the following for some particular files
autocmd BufReadPost,BufNewFile *.txt, call Text_file_commands()


"""""""""""""""""""""""""""""    Vimux     """""""""""""""""""""""""""""
" Function that can be called for Vimux
function! Vimux_python_commands()
	" The following two are only for python (discarded, for python check cellmode)
	"noremap ^ :call VimuxRunCommand("ipython")<CR>:VimuxRunCommand("cd ".getcwd())<CR>
	"nmap <Leader>q :call VimuxRunCommand("%run ".@%)<CR>
	nmap <CR> 0v$h"zy:call VimuxRunCommand(@z)<CR><Esc>
	vmap <CR> "zy:call VimuxRunCommand(@z)<CR>
	nmap <Leader>i <Esc>:VimuxInterruptRunner<CR>
endfunction


""""""""""""""""""""""""""""" Jupyter-vim  """""""""""""""""""""""""""""
function! Jupyter_vim_qtconsole_commands()
	" open jupiter qtconsole and connect to it. Note: no spaces before \
	" qtconsole can be opened with configurations, refer ~/.jupyter/jupyter_qtconsole_config.py
	nnoremap <Leader>^ :!jupyter qtconsole --JupyterWidget.syntax_style="paraiso-dark" --JupyterWidget.font_size=12&<ENTER>
				\:sleep 500m <ENTER>
				\:JupyterConnect<ENTER>
	nmap <CR> V<Plug>JupyterRunVisual
	vmap <CR> <Plug>JupyterRunVisual
	nmap & oclear<Esc>V<Plug>JupyterRunVisualddk:w<CR>
	nmap <Leader>qt o%matplotlib<Space>qt<Esc>V<Plug>JupyterRunVisualddk:w<CR>
	nmap <Leader>q :JupyterRunFile<CR>
endfunction


""""""""""""""""""""""""""""" JPy_console  """""""""""""""""""""""""""""
"" Note : this needs both jupyter-vim/jupyter-vim and benmills/vimux
function! Jupyter_vim_console_commands()
	let g:VimuxOrientation = "h"
	let g:VimuxHeight = "35"	" This is percentage
	" open jupiter console and connect to it. Note: no spaces before \
	nnoremap <Leader>^ :call VimuxRunCommand("jupyter console")<CR>
				\:sleep 500m <ENTER>
				\:JupyterConnect<ENTER>
	nmap <CR> V:JupyterSendRange<CR>:call VimuxSendKeys("Enter")<CR>
	"nmap <CR> V<Plug>JupyterRunVisual:call VimuxSendKeys("Enter")<CR>
	vmap <CR> <Plug>JupyterRunVisual:call VimuxSendKeys("Enter")<CR>
	nmap <Leader><CR> mzVgg:JupyterSendRange<CR>:call VimuxSendKeys("Enter")<CR>`z
	nmap & oclear<Esc>V<Plug>JupyterRunVisualddk:w<CR>:call VimuxSendKeys("Enter")<CR>
	nmap <Leader>qt o%matplotlib<Space>qt<Esc>V<Plug>JupyterRunVisualddk:w<CR>:call VimuxSendKeys("Enter")<CR>
	nmap <Leader>q :JupyterRunFile<CR>:call VimuxSendKeys("Enter")<CR>
endfunction


""""""""""""""""""""""""""""" vim-cellmode """""""""""""""""""""""""""""
"let g:cellmode_default_mappings='0' 	" disable the default mappings
"let g:cellmode_tmux_panenumber='1'
"function! Cellmode_commands()
"	vmap <CR> :call RunTmuxPythonChunk()<CR>
"	nmap <CR> 0v$h:call RunTmuxPythonChunk()<CR>
"endfunction


"autocmd BufReadPost,BufNewFile *.py, call Vimux_python_commands()
"autocmd BufReadPost,BufNewFile *.py, call Jupyter_vim_qtconsole_commands()
autocmd BufReadPost,BufNewFile *.py, call Jupyter_vim_console_commands()
