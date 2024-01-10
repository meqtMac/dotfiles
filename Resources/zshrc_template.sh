if [[ -e ~/.FILE ]]; then
    source ~/.FILE
else
    echo "Error: ~/.FILE file or link does not exist."
fi
