#!/bin/bash
mkdir -p "$output_dir"
find "$input_dir" -type f | while read file; do
filename=$(basename "$file")
if [ -f "$output_dir/$filename" ]; then
        cnt=1
        while [ -f "$output_dir/${filename%.*}_$cnt.${filename##*.}" ]; do
            cnt=$((counter + 1))
            done
        new_name="${filename%.*}_$cnt.${filename##*.}"
        cp "$file" "$output_dir/$new_name"
    else
        cp "$file" "$output_dir/$filename"
    fi


