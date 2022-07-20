abbr -a g git
abbr -a ga git add
abbr -a gd git diff
abbr -a gs git status
abbr -a gb git switch
abbr -a gm git switch main
abbr -a gf git fetch --prune
abbr -a gc git commit
abbr -a gu git pull
abbr -a gp git push

function gdub
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
end

function pr
  git diff (git symbolic-ref refs/remotes/origin/HEAD)...(git rev-parse --abbrev-ref HEAD)
end

set GIT_DIR "$HOME/git"

function repo
  set repos (fd --type d --hidden '^\.git$' "$GIT_DIR" | rg "$argv")
  if test (count $repos) -eq 0
    echo "No repository with pattern '$argv' found" >&2
  else if test (count $repos) -eq 1
    cd (dirname $repos[1])
  else
    echo "Found multiple repos..."
    cd (dirname $repos | fzf)
  end
end

alias gh='cd "$GIT_DIR"'