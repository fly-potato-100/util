" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nu
set tabstop=4
set shiftwidth=4
set smartindent
set tags=./tags,tags;

"set encoding=utf-8
"set termencoding=gb2312
set fileencodings=utf-8,gb2312

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

let mapleader = "\<Space>"

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype off

call plug#begin('~/.vim/plugged') "开始，指定插件安装目录
" Install nerdtree: 额外的窗口用于显示文件目录
Plug 'scrooloose/nerdtree'

" Install Vim-go: golang支持，需要go1.12以上并安装额外工具
Plug 'fatih/vim-go'

" Install tagbar: 符号标签条，需要安装ctags（最好用universal-ctags）
Plug 'majutsushi/tagbar'

" Install gutentags: 异步的tags database管理插件，需要vim8.0以上，gtags，python的pygments模块
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

" Install preview: 预览窗口
Plug 'skywind3000/vim-preview'

call plug#end()  "结束

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  au BufNewFile,BufRead *.hrp set filetype=cpp

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

""""""""" nerdtree 相关设置begin
" 当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 按F7自动显示或隐藏NERDTree区域
map <F7> :NERDTreeMirror<CR>
map <F7> :NERDTreeToggle<CR>

"let NERDTreeShowLineNumbers=1
"let NERDTreeShowHidden=1
"let NERDTreeWinSize=25
let NERDTreeAutoCenter=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.git','\.svn']
""""""""" nerdtree 相关设置end

""""""""" vim-go 相关设置begin
" 检查是否在go-module下打开
function! TestGoModule()
	let [l:out, l:err] = go#util#ExecInDir(['go', 'list', '-m'])
	return l:err
endfunction
if TestGoModule() == 0
	" go-module下使用gopls
	let g:go_def_mode='gopls'
	let g:go_info_mode='gopls'
else
	" GOPATH或outside-GOPATH下，需要打开go_autodetect_gopath
	let g:go_autodetect_gopath = 1
endif
""""""""" vim-go 相关设置end

""""""""" tagbar 相关设置begin
" 按F8自动显示或隐藏tagbar区域
nmap <F8> :TagbarToggle<CR>
"let g:tagbar_width=30
" 开启自动预览(随着光标在标签上的移动，顶部会出现一个实时的预览窗口)
let g:tagbar_autopreview=1
""""""""" tagbar 相关设置end

""""""""" gutentags 相关设置begin
let $GTAGSLABEL = 'native-pygments'
"let $GTAGSLABEL = 'native'
" 要读取的gtags.conf文件，默认为~/.globalrc，也可通过GTAGSCONF设置
"let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
" 把.h文件也作为cpp的头文件，否则其中的类相关符号无法识别
let $GTAGSFORCECPP = 1

" 激活一些调试命令用于troubleshooting
"let g:gutentags_define_advanced_commands = 1

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = 'tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 搜索完毕是否跳转到quickfix窗口中
let g:gutentags_plus_switch = 1

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+naiKStz', '--extras=+q', '--c++-kinds=+px', '--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
" 避免多个项目数据库相互干扰
" 使用plus插件解决问题
let g:gutentags_auto_add_gtags_cscope = 0

" 预览 quickfix 窗口 ctrl-w z 关闭
" p 预览 P关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
" 上下滚动预览窗口
noremap <leader><PageUp> :PreviewScroll -1<cr>
noremap <leader><PageDown> :PreviewScroll +1<cr>
""""""""" gutentags 相关设置end
