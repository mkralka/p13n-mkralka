" Configuration specific to C/C++ files

setlocal noexpandtab
setlocal   cindent
setlocal   cinoptions=>1s,e0,n0,f0,{0,}0,^0,:0,=1s,l1,b0,g0,h1s,t1s,i1s,+1s,(0,U1,W1s
if exists("+colorcolumn")
	setlocal   colorcolumn=80
endif
setlocal   foldmethod=syntax
setlocal   foldcolumn=4
setlocal   shiftwidth=8
setlocal   tabstop=8
setlocal   textwidth=0               " Don't hard-wrap the text.
