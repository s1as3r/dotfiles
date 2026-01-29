#!/usr/bin/env bash

# modified dotfiles/scripts/rr for waybar

display_no=0 
if [[ $# -eq 2 ]]; then
  # not used for now
  display_no="$2"
fi

display_info=$(wlr-randr --json)
if [[ $display_no -lt 0 || $display_no -gt "$(echo "$display_info" | jq 'length - 1')" ]]; then
  exit 1
fi

display_name=$(echo "$display_info" | jq -r ".[$display_no].name")
available_rr=$(echo "$display_info" | jq -c ".[$display_no].modes.[].refresh")
current_mode=$(echo "$display_info" | jq -r ".[$display_no].modes.[] | select(.current == true)")
current_rr=$(echo "$current_mode" | jq -r '.refresh')
current_res=$(echo "$current_mode" | jq -r '"\(.width)x\(.height)"')

match_rr() {
  for refresh_rate in $available_rr; do
    if [[ "$(echo "$refresh_rate" | cut -d"." -f1)" = "$1" ]]; then
      echo "$refresh_rate"
      return
    fi
  done
}

if [[ $# -eq 0 ]]; then
  echo "$current_rr" | cut -d"." -f1
  exit 0
fi

if [[ "$1" != "-s" ]]; then
  exit 1
fi

unique_rr=$(echo "$available_rr" | sed 's/"//g' | cut -d"." -f1 | sort -n | uniq)
current_rr_int=$(echo "$current_rr" | cut -d"." -f1)

next_rr=""
found_current=false
for rr in $unique_rr; do
  if $found_current; then
    next_rr=$rr
    break
  fi
  if [[ "$rr" == "$current_rr_int" ]]; then
    found_current=true
  fi
done

if [[ -z "$next_rr" ]]; then
  next_rr=$(echo "$unique_rr" | head -n1)
fi

matched_rr=$(match_rr "$next_rr")
matched_mode="$current_res@$matched_rr"

if [[ -z "$matched_rr" ]]; then
  exit 1
fi

wlr-randr --output "$display_name" --mode "$matched_mode"
echo "$next_rr"
exit 0
