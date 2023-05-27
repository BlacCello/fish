set PATH ~/.local/bin $PATH
set PATH ~/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.binenv $PATH
set PATH /var/lib/snapd/snap/bin $PATH

function cat
  bat --paging never --decorations never $argv
end

abbr -a vi nvim
abbr -a vim nvim

function journal
  journalctl --since "$argv[1] 00:00" --until "$argv[1] 23:59" | grep -v crond | less
end

if type -f keychain >/dev/null 2>&1
  # for loading the SSH key
  keychain -q --nogui "$HOME/.ssh/id_ed25519"
  source "$HOME/.keychain/"(uname -n)-fish
end
