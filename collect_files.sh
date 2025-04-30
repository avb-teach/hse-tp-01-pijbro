#!/bin/bash
if [ "$1" == "--max_depth" ]; then
    max1=$2
    from=$3
    to=$4
else
    max1=-1
    from=$1
    to=$2
fi
mkdir -p "$to"
find "$from" -type f | while read filepath; do
    depth=$(echo "$filepath" | tr -cd '/' | wc -c)
    depth=$((depth - $(echo "$from" | tr -cd '/' | wc -c)))
    if [ "$max1" -ne -1 ] && [ "$depth" -gt "$max1" ]; then
        continue
    fi
    filename=$(basename "$filepath")
    new_path="$to"
    if [ "$max1" -ne -1 ]; then
        rel_path=$(echo "$filepath" | sed "s|^$from/||")
        path_parts=($(echo "$rel_path" | tr '/' '\n'))
        for ((i=0; i<$max1 && i<${#path_parts[@]}-1; i++)); do
            new_path="$new_path/${path_parts[$i]}"
        done
        mkdir -p "$new_path"
    fi
    if [ -f "$new_path/$filename" ]; then
        counter=1
        while [ -f "$new_path/${filename%.*}_$counter.${filename##*.}" ]; do
            ((counter++))
        done
        cp "$filepath" "$new_path/${filename%.*}_$counter.${filename##*.}"
    else
        cp "$filepath" "$new_path/$filename"
    fi
done

