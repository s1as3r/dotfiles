# display a qrcode
# usage: qr <text>
function qr
    if test "$TERM" = "xterm-kitty"
        qrencode -o - $argv[1] | kitty +kitten icat
    else
        qrencode -o - $argv[1] | feh -
    end
end
