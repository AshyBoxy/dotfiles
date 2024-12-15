#!/bin/sh
convert $1 \
        \( -clone 0 -resize 16x16 \) \
        \( -clone 0 -resize 32x32 \) \
        \( -clone 0 -resize 48x48 \) \
        \( -clone 0 -resize 64x64 \) \
        \( -clone 0 -resize 96x96 \) \
        \( -clone 0 -resize 128x128 \) \
        \( -clone 0 -resize 256x256 \) \
        \( -clone 0 -resize 512x512 \) \
        \( -clone 0 -resize 1024x1024 \) \
    -delete 0 -alpha remove -colors 256 $1.ico
