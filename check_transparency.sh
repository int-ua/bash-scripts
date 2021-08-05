#!/bin/bash
# Check if a part of an image has
# at least a certain percentage of transparent pixels

# Usage: check_transparency input_image crop threshold
# Example: check_transparency input_image 32x32+0+0 0.5

# author int_ua

# version 2021-08-06

# TODO: treat threshold as number of pixels if it's not float

input_image="$1"
crop="${2:-32x32+0+0}"
threshold="${3:-0.5}"

if [[ -z $input_image ]]; then
  echo no input image
  exit 1
fi

fraction=$(\
convert "$input_image" -crop "$crop" -strip png:- | \
convert png: -channel a -separate -format "%[fx:mean]" info:\
) || echo "$input_image"

if [[ $fraction == *"e"* ]]; then
  echo "ImageMagick scientific notation output detected (${fraction}), skipping $input_image"
  exit
fi

if (( $(echo "$fraction > $threshold" |bc -l) )); then
  echo "$input_image covers more than $threshold ($fraction)"
  exit 1
fi
