function fish_greeting
    if which neofetch > /dev/null
        neofetch
    else
        echo
	    echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	    echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	    echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	    echo
	end

    if test -f ~/.taskrc || test -f ~/.config/task/taskrc
        task next &| tee /dev/tty | grep -i "sync required" > /dev/null
        if test $status -eq 0
            task sync &> /dev/null &
        end
    end
end
