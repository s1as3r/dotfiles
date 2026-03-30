function source_if_exists -a fpath -d "source file if it exists"
    test -f $fpath; and source $fpath
end
