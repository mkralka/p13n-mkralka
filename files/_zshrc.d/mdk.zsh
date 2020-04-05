# vim: set filetype=zsh:


##
## History
##

# History settings
# - share history between shell sessions
# - store dups, but expire the duplicates first when trimming the history
# - verify command before executing
setopt sharehistory histexpiredupsfirst histverify


##
## Path
##
test -d "$HOME/bin" && prepend_path "$HOME/bin"

##
## Command-line completion
##

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
autoload -Uz compinit && compinit

# Bash-compatible completion
autoload bashcompinit && bashcompinit


##
## Command-specific settings
##

## git
__p13n_git=false
for __p13n_dir in /Applications/Xcode.app/Contents/Developer/usr/share/git-core \
	/Library/Developer/CommandLineTools/usr/share/git-core; do
	if test -f "$__p13n_dir/git-completion.zsh" -a -f "$__p13n_dir/git-prompt.sh"; then
		zstyle ':completion:*:*:git:*' script "$__p13n_dir/.git-completion.zsh"
		. "$__p13n_dir/git-prompt.sh"
		__p13n_git=true
		break
	fi
done

## ls
if $p13n_macosx; then
	export CLICOLOR=1
	# Foreground: dir=cyan, symlink=bold-cyan, socket=bold-magenta,
	#             pipe=brown, exec=red, block=yellow, char=green,
	#             setuid-exec=bold-red, setgid-exec=bold-red,
	#             writeable-dir=bold-blue, sticky-writable-dir=bold-blue
	# Backgorund: default across the board.
	export LSCOLORS=gxGxFxdxbxDxcxBxBxCxCx
elif $p13n_linux; then
	alias ls='ls --color=auto'
fi


##
## Command Prompt
##

# Need to expand commands in the prompt
setopt promptsubst
if $__p13n_git; then
	export PS1=$'%{\e[0;33m%}%n@%m%{\e[0m%} %{\e[0;36m%}%c%{\e[0m%}$(__git_ps1 " %%{\e[0;32m%%}(%s)%%{\e[0m%%}") %# '
else
	export PS1=$'%{\e[0;33m%}%n@%m%{\e[0m%} %{\e[0;36m%}%c%{\e[0m%} %# '
fi


##
## Environment Variables
##
export EDITOR=vim

##
## Aliases
##
alias vi=vim
