map() {
    local f=$1 ; shift
    for elt in $@; do
        echo $($f $elt); done
}
