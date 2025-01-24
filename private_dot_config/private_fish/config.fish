export EDITOR=vim
if status is-interactive
    # Commands to run in interactive sessions can go here
	zoxide init fish | source

	function fzf_jj_edit
		if test -d .jj
		    set -l name (jj log --no-graph -T 'change_id.shortest() ++ "\t" ++ description.first_line() ++ " "  ++ branches.join("  ") ++ "\n"' --color always | fzf --ansi | cut -f1)
		    commandline -it "$name"
		else
		    commandline -it "# not in a jj directory"
		end
	end
	bind \cj 'fzf_jj_edit'


	function y
		set tmp (mktemp -t "yazi-cwd.XXXXXX")
		yazi $argv --cwd-file="$tmp"
		if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
			builtin cd -- "$cwd"
		end
		rm -f -- "$tmp"
	end
end
