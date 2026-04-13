function folder-icon
  if test (count $argv) -ne 2
    echo "Usage: folder-icon <icon-name> <folder-path>"
    echo "Example: folder-icon 'camera.viewfinder' '/path/to/folder'"
    return 1
  end

  xattr -w 'com.apple.icon.folder#S' "{\"sym\":\"$argv[1]\"}" $argv[2]
end
