#!/bin/bash

MUSIC="/home/pi/RetroPie/music"
MOVIES="/home/pi/RetroPie/movies"
TVSHOWS="/home/pi/RetroPie/tv-shows"
USB="/media/usb"

if [ -d "$USB" ]; then

   echo "Transfering files..."

   if [ -d "$MUSIC" ]; then
      if [ "$( ls -A $USB/music)" ]; then
      echo "Transfering Music..."
      cp -R $USB/music/* $MUSIC
      fi
   else
      echo "Error: ${MUSIC} not found. Can not continue."
   fi

   if [ -d "$MOVIES" ]; then
      if [ "$( ls -A $USB/movies)" ]; then
      echo "Transfering Movies..."
      cp -R $USB/movies/* $MOVIES
      fi
   else
      echo "Error: ${MOVIES} not found. Can not continue."
   fi

   if [ -d "$TVSHOWS" ]; then
      if [ "$( ls -A $USB/tv-shows)" ]; then
      echo "Transfering TV-shows..."
      cp -R $USB/tv-shows/* $TVSHOWS
      fi
   else
      echo "Error: ${TVSHOWS} not found. Can not continue."
   fi
else
echo "No USB detected."
fi

echo "Operation completed"

