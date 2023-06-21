#!/bin/bash
maim -s | convert - +swap -background none -layers merge +repage ~/Pictures/Screenshots/$(date +%s).png | xclip -selection clipboard -t image/png
