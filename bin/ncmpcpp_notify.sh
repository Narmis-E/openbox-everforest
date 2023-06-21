#!/usr/bin/env bash
# notify when mpd music changed

cover_path=/tmp/cover.png
# mpd music directory
mpd_dir=~/Music
# if cover not found in metadata use this instead
backup_cover=~/Pictures/home.jpg

if [[ ! -f "$backup_cover" ]]; then
    ffmpeg -i ~/Pictures/home.jpg $backup_cover
fi

create_cover() {
    ffmpeg -i "$mpd_dir"/"$(mpc current -f %file%)" -vf scale=90:90 "${cover_path}" -y -hide_banner -loglevel panic || cp $backup_cover $cover_path || exit
}

while "true"; do
    status="`mpc status`"
    if [[ ${status} == *"[playing]"* ]]; then
        create_cover
        dunstify -a Music --replace=27072 -t 4000 -i /tmp/cover.png "Now Playing" "$(mpc --format '%title% - %artist%' current)"
    fi
    mpc idle > /dev/null
done
