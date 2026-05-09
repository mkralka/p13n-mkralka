# vim: set filetype=zsh:


##
## History
##

# History settings
# - share history between shell sessions
# - don't store consecutive duplicates (but will store them if there are
#   intervening commands).
# - ... but expire the duplicates first when trimming the history
# - remove superfluous blanks before adding a command to the history
# - verify command before executing
setopt share_history hist_ignore_dups hist_expire_dups_first hist_reduce_blanks hist_verify


##
## Line Editor
##

# When navigating the history, filter out everything except what matches
# the text before the cursor
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

# By default, / and ? use normal search; use incremental search instead.
# Mirror vim's behavior of using ^G/^T to move to the previous/next match while
# incremental search is active..
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M isearch "^G" history-incremental-search-backward
bindkey -M isearch "^T" history-incremental-search-forward

# Reduce the ESC timeout to 10µs; the default in 400ms, which is
# long enough to make moving from insert to normal mode awkward.
# setting to zero will break arrow keys when in insert mode.
typeset -g KEYTIMEOUT=1

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
__p13n_git_prompt=false
for __p13n_dir in {/usr/share/git-core/contrib/completion,/Applications/Xcode.app/Contents/Developer/usr/share/git-core,/Library/Developer/CommandLineTools/usr/share/git-core}; do
	test -d "$__p13n_dir" || continue

	if test -f "$__p13n_dir/git-prompt.sh"; then
		. "$__p13n_dir/git-prompt.sh"
		__p13n_git_prompt=true
	fi
	break
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
if $__p13n_git_prompt; then
	export PS1=$'%{\e[0;33m%}%n@%m%{\e[0m%} %{\e[0;36m%}%c%{\e[0m%}$(__git_ps1 " %%{\e[0;32m%%}(%s)%%{\e[0m%%}") %# '
else
	export PS1=$'%{\e[0;33m%}%n@%m%{\e[0m%} %{\e[0;36m%}%c%{\e[0m%} %# '
fi


##
## Miscellaneous
##

# Use Dvorak keyboard (instead of qwerty) when examining spelling mistakes
setopt dvorak

##
## Aliases
##
alias vi=vim
alias gsync='rsync --exclude=".git/" --filter="dir-merge,- .gitignore" --delete-after'
