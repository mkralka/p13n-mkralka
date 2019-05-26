" Configuration specific to Python files

setlocal   autoindent
setlocal   cinwords=if,elif,else,for,while,try,except,finally,def,class
if exists("+colorcolumn")
	setlocal   colorcolumn=80
endif
setlocal   expandtab
setlocal   fileformat=unix
setlocal   foldmethod=indent
setlocal   foldcolumn=4
setlocal   shiftwidth=4
setlocal   smartindent
setlocal   softtabstop=4
setlocal   tabstop=4
setlocal   textwidth=79
