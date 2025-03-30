#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Credit: Marcus Olsson https://github.com/marcusolsson/obsidian-projects/discussions/581

import csv
import os
import re

def sanitize_filename(filename):
    # Remove invalid characters from filename
    return re.sub(r'[\\/*?:"<>|]', '-', filename)

# Directory to store the .md files
output_dir = 'md_files'

# Make sure the output directory exists
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Loop through each file in the current directory
for filename in os.listdir('.'):
    # Process only .csv files
    if filename.endswith('.csv'):

        # Read the CSV file
        with open(filename, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            headers = reader.fieldnames

            # Iterate through each row in the CSV
            for row in reader:
                # Sanitize and create .md file named after the first column
                title = sanitize_filename(row[headers[0]])
                md_filename = os.path.join(output_dir, f"{title}.md")

                # Open the .md file for writing
                with open(md_filename, 'w', encoding='utf-8') as md_file:
                    # Write attributes to the .md file
                    md_file.write('---\n')
                    for header in headers:
                        if header != headers[0] and row[header]:
                            md_file.write(f"{header}: {row[header]}\n")
                    md_file.write('---\n')
