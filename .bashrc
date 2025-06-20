
if type __git_ps1 >/dev/null 2>&1
then
	git_branch_ps1() {
		local branch=`__git_ps1 '%s'`
		test ! -z "$branch" && echo -en "─[\033[01;35m$branch\033[00m]"
	}
else
	git_branch_ps1() {
		echo
	}
fi

nvx() {
	local nvx_pipe="$HOME/.cache/nvim/server.pipe"
	if ! test -S "$nvx_pipe"
	then
		killall nvim >"/dev/null" 2>&1
		nohup nvim --listen "$nvx_pipe" >"/dev/null" 2>&1 &
		disown
		sleep 1
	fi
	nvim --remote-ui --server "$nvx_pipe"
}

PS1='┌─[\[\033[38;5;3m\]\t\[\033[00m]'
PS1+='─[\[\033[01;32m\]\u@\h\[\033[00m\]]'
PS1+='─[\[\033[01;34m\]\w\[\033[00m\]]'
PS1+='$(git_branch_ps1)' # git branch
PS1+='\n└─$ '
shopt -s globstar
export EDITOR=nvim
alias ll='ls -l'
alias vi=nvim
alias vim=nvim
alias G=git
stty -ixon

