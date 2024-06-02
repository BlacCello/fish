set PATH ~/.local/bin $PATH
set PATH ~/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.binenv $PATH
set PATH /var/lib/snapd/snap/bin $PATH

abbr -a vi nvim
abbr -a vim nvim

if type -f keychain >/dev/null 2>&1
  # for loading the SSH key
  keychain -q --nogui "$HOME/.ssh/id_ed25519"
  source "$HOME/.keychain/"(uname -n)-fish
end
