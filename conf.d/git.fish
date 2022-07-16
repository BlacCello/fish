abbr -a g git
abbr -a ga git add
abbr -a gs git status
abbr -a gb git switch
abbr -a gm git switch main
abbr -a gf git fetch --prune
abbr -a gc git checkout
abbr -a gu git pull
abbr -a gp git push

function gdub
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
end

function pr
  git diff (git symbolic-ref refs/remotes/origin/HEAD)...(git rev-parse --abbrev-ref HEAD)
end
