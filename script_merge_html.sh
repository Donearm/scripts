#!/bin/sh

# Merge all html files in a directory in a single page

read -e -p "Enter directory path pages: " html_path
read -e -p "Enter complete filename of the starting page: " start_page
read -e -p "Enter filename of the merged, final html file: " final_page

grep -iv "</body>" "${start_page}" | grep -iv "</html>" > "${final_page}"

for i in ${html_path}/*.[hH][Tt][Mm]*;
do
	grep -iv "<body>" "$i" | grep -iv "<html>" | grep -iv "</body>" | grep -iv "</html>" >> "${final_page}"
done

echo "</body></html>" >> "${final_page}"

exit 0
