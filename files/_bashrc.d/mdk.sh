# vim: set filetype=sh:

##
## History settings
##

# Append history to .bash_history, rather than overwrite, with interleave
# when multiple sessions are open.
shopt -s histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}history -a"

# Save multi-line commands as a single command in the history, making it easy
# to subsequently edit these commands.
shopt -s cmdhist

##
## Commands
##

## Git
__p13n_git=false
for __p13n_dir in /Applications/Xcode.app/Contents/Developer/usr/share/git-core \
	/Library/Developer/CommandLineTools/usr/share/git-core; do
	if test -f "$__p13n_dir/git-completion.bash" -a -f "$__p13n_dir/git-prompt.sh"; then
		. "$__p13n_dir/git-completion.bash"
		. "$__p13n_dir/git-prompt.sh"
		__p13n_git=true
		break
	fi
done

# Colors for LS
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

if $__p13n_git; then
	export PS1='[\h \[\033[0;36m\]\W\[\033[0m\]$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")]\$ '
else
	export PS1='[\h \[\033[0;36m\]\W\[\033[0m\]]\$ '
fi


##
## Environment Variables
##
export EDITOR=vim

##
## Aliases
##
alias vi=vim
