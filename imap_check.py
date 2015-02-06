#!/usr/bin/env python
"""Check a gmail account and print number of new and unread mails"""

import imaplib
import sys

# Two gmail accounts, two routines of login/logout
# Give passwords as arguments (I know, not optimal but better than storing it 
# on disk)

# The server
gmail_forod = imaplib.IMAP4_SSL("imap.gmail.com", 993)

# Let's login
gmail_forod.login('forod.g@gmail.com', sys.argv[1])
gmail_forod.select() # select default mailbox, "INBOX"

# List of folder to check
folders = ('INBOX')
unreads = []

for f in folders:
# For every folder get number of unread messages, stores them in unreads list
# and then add them as integer. At the end the print needs to convert back the
# number to a string to output correctly
    status_forod, counts_forod = gmail_forod.status(f, "(MESSAGES UNSEEN)")
    print(status_forod, counts_forod)
    unreads.append(int(counts_forod[0].split()[4][:-1]))

# Add all the undread messages from the above folders
unread_total = str(sum(unreads))

#unread = countsF[0].split()[4][:-1]

if unread_total == "0":
# no output at all if no unread mail
    output_forod = '0'.encode('utf-8')
else:
    output_forod = unread_total

gmail_forod.logout()

# Server
gmail_gianluca = imaplib.IMAP4_SSL("imap.gmail.com", 993)

# Login
gmail_gianluca.login("fioregianluca@gmail.com", sys.argv[2])
gmail_gianluca.select() # select default mailbox, "INBOX"

status_gianluca, counts_gianluca = gmail_gianluca.status("INBOX", "(MESSAGES UNSEEN)")

unread = counts_gianluca[0].split()[4][:-1]
if unread == "0":
    output_gianluca = '0'.encode('utf-8')
else:
    output_gianluca = unread

gmail_gianluca.logout()

# Put the two outputs together and print them to screen
output_final = output_forod + b'/' + output_gianluca

print(output_final.decode())
