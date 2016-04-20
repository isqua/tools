#!/bin/sh

# Create colored cell
get_cell() {
    local bg=$1
    local title=$bg

    # Padding
    if [[ $bg -lt 100 ]]; then title=" $bg"; fi
    if [[ $bg -lt 10 ]]; then title="  $bg"; fi

    # Contrast
    local fg=255
    if [[ ( $bg -ge 142 ) && ( $bg -lt 232 ) || ( $bg -ge 244 ) ]]; then
        fg=232
    fi

    echo "$(tput setab $bg)$(tput setaf $fg) $title $(tput sgr0)"
}

# Create block rows×cols
print_block() {
    local base=$1
    local rows=$2
    local cols=$3
    local r=$(( $rows - 1))
    local c=$(( $cols - 1))
    local i
    local j
    local line
    local color
    for i in $(seq 0 $r); do
        line=""
        for j in $(seq 0 $c); do
            color=$(( $base + $i * $cols + $j ))
            line+="$(get_cell $color)"
        done
        echo $line
    done
}

print_base() {
    print_block 0 2 8
}

print_colors() {
    for i in $(seq 16 36 196); do
        print_block $i 6 6
        echo
    done
}

print_grayscale() {
    print_block 232 4 6
}

echo "\nBase palette:"
print_base
echo "\nExtended palette:"
print_colors
print_grayscale
