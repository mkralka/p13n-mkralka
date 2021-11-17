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

# CTRL+B/CTRL+F backward/forward 1 word as delimited by whitespace
bindkey "^B" vi-backward-blank-word
bindkey "^F" vi-forward-blank-word
# ESC b/f move to the beginning of the word, vi style
bindkey "^[B" vi-backward-word
bindkey "^[F" vi-forward-word

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

	if test -f "$__p13n_dir/git-completion.zsh"; then
		zstyle ':completion:*:*:git:*' script "$__p13n_dir/.git-completion.zsh"
	fi
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
## Environment Variables
##
export EDITOR=vim

##
## Aliases
##
alias vi=vim
alias gsync='rsync --exclude=".git/" --filter="dir-merge,- .gitignore" --delete-after'
