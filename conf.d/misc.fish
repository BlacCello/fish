function cat
  bat --paging never --decorations never $argv
end

function journal
  journalctl --since "$argv[1] 00:00" --until "$argv[1] 23:59" | grep -v crond | less
end
