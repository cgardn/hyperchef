let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set laststatus=2
set lazyredraw
set nomodeline
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim81,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set showcmd
set showmatch
set softtabstop=2
set splitright
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=2
set wildmenu
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/recipesabc
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd app/views/search/index.html.erb
edit app/views/search/query.html.erb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 1resize ' . ((&columns * 83 + 83) / 167)
exe '2resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 2resize ' . ((&columns * 83 + 83) / 167)
exe '3resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 3resize ' . ((&columns * 83 + 83) / 167)
exe '4resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 4resize ' . ((&columns * 83 + 83) / 167)
argglobal
let s:cpo_save=&cpo
set cpo&vim
cmap <buffer>  <Plug><cfile>
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=<%#%s%>
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'eruby'
setlocal filetype=eruby
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\<\\(load\\>\\|require\\>\\|autoload\\s*:\\=[\"']\\=\\h\\w*[\"']\\=,\\)
setlocal includeexpr=
setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal nomodeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal path=~/.rbenv/rbenv.d/exec/gem-rehash,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'eruby'
setlocal syntax=eruby
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tags=./tags,./TAGS,tags,TAGS,~/.rbenv/rbenv.d/exec/gem-rehash/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux/tags
setlocal termmode=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 2 - ((1 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 04|
wincmd w
argglobal
if bufexists("app/views/search/index.html.erb") | buffer app/views/search/index.html.erb | else | edit app/views/search/index.html.erb | endif
let s:cpo_save=&cpo
set cpo&vim
cmap <buffer>  <Plug><cfile>
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=<%#%s%>
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'eruby'
setlocal filetype=eruby
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\<\\(load\\>\\|require\\>\\|autoload\\s*:\\=[\"']\\=\\h\\w*[\"']\\=,\\)
setlocal includeexpr=
setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal nomodeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal path=~/.rbenv/rbenv.d/exec/gem-rehash,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'eruby'
setlocal syntax=eruby
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tags=./tags,./TAGS,tags,TAGS,~/.rbenv/rbenv.d/exec/gem-rehash/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux/tags
setlocal termmode=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 029|
wincmd w
argglobal
if bufexists("app/models/recipe.rb") | buffer app/models/recipe.rb | else | edit app/models/recipe.rb | endif
let s:cpo_save=&cpo
set cpo&vim
cmap <buffer>  <Plug><cfile>
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\<\\(load\\>\\|require\\>\\|autoload\\s*:\\=[\"']\\=\\h\\w*[\"']\\=,\\)
setlocal includeexpr=
setlocal indentexpr=GetRubyIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,:,.,=end,=else,=elsif,=when,=ensure,=rescue,==begin,==end,=private,=protected,=public
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=~/.rbenv/rbenv.d/exec/gem-rehash,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tags=./tags,./TAGS,tags,TAGS,~/.rbenv/rbenv.d/exec/gem-rehash/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux/tags
setlocal termmode=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 14 - ((13 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 017|
wincmd w
argglobal
if bufexists("app/controllers/search_controller.rb") | buffer app/controllers/search_controller.rb | else | edit app/controllers/search_controller.rb | endif
let s:cpo_save=&cpo
set cpo&vim
cmap <buffer>  <Plug><cfile>
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\<\\(load\\>\\|require\\>\\|autoload\\s*:\\=[\"']\\=\\h\\w*[\"']\\=,\\)
setlocal includeexpr=
setlocal indentexpr=GetRubyIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,:,.,=end,=else,=elsif,=when,=ensure,=rescue,==begin,==end,=private,=protected,=public
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=~/.rbenv/rbenv.d/exec/gem-rehash,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tags=./tags,./TAGS,tags,TAGS,~/.rbenv/rbenv.d/exec/gem-rehash/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/site_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/2.6.0/x86_64-linux/tags,~/.rbenv/versions/2.6.5/lib/ruby/vendor_ruby/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/tags,~/.rbenv/versions/2.6.5/lib/ruby/2.6.0/x86_64-linux/tags
setlocal termmode=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 023|
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 1resize ' . ((&columns * 83 + 83) / 167)
exe '2resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 2resize ' . ((&columns * 83 + 83) / 167)
exe '3resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 3resize ' . ((&columns * 83 + 83) / 167)
exe '4resize ' . ((&lines * 17 + 18) / 37)
exe 'vert 4resize ' . ((&columns * 83 + 83) / 167)
tabnext 1
badd +0 app/views/search/index.html.erb
badd +1 app/controllers/search_controller.rb
badd +0 app/views/search/query.html.erb
badd +0 app/models/recipe.rb
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
