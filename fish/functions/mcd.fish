# Create a direcotry and cd into it
function mcd -d "mkdir and cd"
    mkdir -p $argv[1] && cd $argv[1]
end
