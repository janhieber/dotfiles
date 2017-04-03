#!/bin/sh
SIGMA=2.0

IMAGE=$(mktemp /tmp/i3lock_XXX.jpg)
scrot -z $IMAGE
convert $IMAGE -filter Gaussian -resize 25% -define filter:sigma=$SIGMA -resize 400% ${IMAGE%.jpg}.png
rm $IMAGE
i3lock -i ${IMAGE%.jpg}.png -t -I 10 -e
rm ${IMAGE%.jpg}.png
xset dpms force off

