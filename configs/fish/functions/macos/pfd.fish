function pfd
  osascript 2>/dev/null -e '''
    tell application "Finder"
      return POSIX path of (insertion location as alias)
    end tell
  '''
end

