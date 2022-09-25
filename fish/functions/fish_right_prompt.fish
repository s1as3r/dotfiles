function fish_right_prompt
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color --bold brblack
                echo '[N]'
            case replace_one
                set_color --bold white
                echo '[R]'
            case replace
                set_color --bold cyan
                echo '[R]'
            case visual
                set_color --bold magenta
                echo '[V]'
        end
        set_color normal
        echo -n ' '
    end

    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    set_color normal
end

