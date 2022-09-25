# Execute a command in a specific directory
# https://github.com/anishathalye/dotfiles/blob/master/shell/aliases.sh#L85-89
function xin
      fish -c "cd $argv[1] && $argv[2..]"
end
