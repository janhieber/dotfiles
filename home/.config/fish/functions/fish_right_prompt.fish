function fish_right_prompt -d "Write out the right prompt"
  set -l last_status $status
  
  # Print a red dot for failed commands.
  if test $last_status -gt 0
    set_color red;    echo -n "•"
    set_color normal; echo -n " "
  end

  # Print a fork symbol when in a subshell
  if test $SHLVL -gt 2
    set_color red;    echo -n "⑂"
    set_color normal; echo -n " "
  end

  # Print the username when the user has been changed.
  if test $USER != $LOGNAME
    echo -n "$USER@"
  end
 
  # Print the current directory.
  set_color ; echo -n (pwd | sed -e "s|^$HOME|~|")

  # Print the checked out branch name or commit hash of a git repository.
  set -l current_commit (git rev-parse HEAD 2> /dev/null)
 
  if test $status -gt 0
    return
  end
 
  echo -n ":"
  git diff-files --quiet --ignore-submodules 2>/dev/null
 
  if test $status = 0
    set_color green
  else
    set_color red
  end
 
  set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
 
  if test $branch = "HEAD"
    echo -n $current_commit | cut -b 1-7
  else
    echo -n $branch
  end
 
  set_color normal
end
