#!/bin/bash

INPUT_IMAGE="$1"
OUTPUT_DIR="$2"

if [ -z "$INPUT_IMAGE" ]; then
  echo "Usage: favicon INPUT_IMAGE [OUTPUT_DIRECTORY]"
  exit 1
fi

if [ -z "$OUTPUT_DIR" ]; then
  OUTPUT_DIR="."
fi

if [ ! -d "$OUTPUT_DIR" ]; then
  echo "Error: Output directory does not exist."
  exit 1
fi

if ! [ -x "$(command -v convert)" ]; then
  echo "Error: convert not found. Check if ImageMagick is installed. Get it from https://www.imagemagick.org." >&2
  exit 1
fi

if [ -f $INPUT_IMAGE ]; then
  echo "Generating favicons..."
#   SIZES=(16 32 57 72 114 144)
  #####################################
  
 while IFS= read -r line; do 
    OUTPUT_NAME=$(cut -d' ' -f1 <<< $line)
     OUTPUT_SIZE=$(cut -d' ' -f2 <<< $line);
    convert -flatten -background none -gravity center $INPUT_IMAGE -resize ${OUTPUT_SIZE}x${OUTPUT_SIZE} -extent ${OUTPUT_SIZE}x${OUTPUT_SIZE} $OUTPUT_DIR/${OUTPUT_NAME}

    if [  -f $OUTPUT_DIR/${OUTPUT_NAME} ]; then
      echo ">" ${OUTPUT_NAME}
    else
      echo "Error: Could not process input file. $INPUT_IMAGE may not be an image file."
      exit 1
    fi
done < favicon-list.txt
  
  #####################################
#   for size in ${SIZES[@]}; do
#     convert -flatten -background none -resize ${size}x${size} $INPUT_IMAGE $OUTPUT_DIR/favicon-${size}.png
#     if [  -f favicon-${size}.png ]; then
#       echo ">" favicon-${size}.png
#     else
#       echo "Error: Could not process input file. $INPUT_IMAGE may not be an image file."
#       exit 1
#     fi
#   done
  #####################################
  
#   echo "> favicon.ico"
#   convert -flatten -background none -resize 16x16 $INPUT_IMAGE $OUTPUT_DIR/favicon.ico
else
  echo "Error: Input file does not exist."
  exit 1
fi
