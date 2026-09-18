#!/bin/bash
notify_for_each_line() {
  while IFS= read -r line; do
    notify-send -a KERNEL -u CRITICAL -w -i dialog-warning "$line"
  done
}
sudo dmesg -l err+ --follow-new --nopager --notime | notify_for_each_line
