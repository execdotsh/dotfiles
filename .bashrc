
if type __git_ps1
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

PS1='┌─[\[\033[38;5;3m\]\t\[\033[00m]'
PS1+='─[\[\033[01;32m\]\u@\h\[\033[00m\]]'
PS1+='─[\[\033[01;34m\]\w\[\033[00m\]]'
PS1+='$(git_branch_ps1)' # git branch
PS1+='\n└─$ '
shopt -s globstar
export EDITOR=nvim
alias vi=nvim
alias vim=nvim
alias G=git

