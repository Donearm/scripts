#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#1cd2ee'  # default
T='#fffefe'  # text
W='#fff0021'  # wrong
V='#1fc95a'  # verifying

i3lock -i /home/gianluca/documents/Images/linuxmasterrace-archlinux-black.png \
-C \
--clock \
--force-clock \
--time-pos x+5:y+h-80 \
--time-color 3e999f \
--date-pos tx:ty+15 \
--date-color 3e999f \
--date-align 1 \
--time-align 1 \
--ringver-color ff0021 \
--ringwrong-color ff0021 \
--status-pos x+5:y+h-16 \
--verif-align 1 \
--wrong-align 1 \
--verif-color ffffffff \
--wrong-color ffffffff \
--modif-pos -50:-50
#--blur 7 \
#--bar-indicator \
#--bar-pos y+h \
#--bar-direction 1 \
#--bar-max-height 50 \
#--bar-base-width 50 \
#--bar-color 1cd2ee \
#--keyhl-color fffefe \
#--bar-periodic-step 50 \
#--bar-step 50 \
#--redraw-thread \
#\
