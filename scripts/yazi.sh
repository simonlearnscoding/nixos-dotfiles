
yazi_cd() {
    DIR=$(yazi --print-path)
    if [ -d "$DIR" ]; then
        cd "$DIR"
    else
        echo "Failed to retrieve directory path from Yazi."
    fi
}
