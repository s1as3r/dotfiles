function fish_user_key_bindings
  if which fzf &> /dev/null
      fzf_key_bindings
  end
end
