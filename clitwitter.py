#!/usr/bin/env python
###############################################################################
# Copyright (c) 2009-2014, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

__version__ = "0.1"

# Small advice:
# given that this script is meant to be used launched by a shell, pay the
# utmost attention to the characters you'll be use, be sure that they aren't
# going to be interpreted by the shell or find a way to escape them. For bash
# it's best to use double quotes (") at the start and end of your message and
# not to use the exclamation mark. Other characters like the period, the
# semi-period, the comma and the interrogative point should be ok. For quoting
# inside the message obviously make use of the single quotes


from urllib.parse import urlencode
import urllib.request, urllib.error, urllib.parse
from base64 import b64encode
import sys
import re
from argparse import ArgumentParser

# regexp to match any whitespace character
RWhitespaces = re.compile("\s")

def msgtoolong():
    """Complain if the message is too long and exit"""
    print("Are you going to post the entire Divine Comedy? Keep it short please")
    exit(1)


def truncate(string, target):
    """Truncate a string to respect the twitter 140 characters limit and
    preserve word boundaries"""
    if len(string) < target:
        # string is shorter than target
        return string
    elif len(string) >= target*2:
        # string is equal or bigger than double the target, too much
        msgtoolong()
    else:
        # string is bigger than target but shorter than 280 characters. It's ok
        lastchar = string[140]
        if RWhitespaces.match(lastchar):
            # last character is a space, good, split the string there
            msg1 = string[:140]
            msg2 = string[141:]
            return msg1, msg2
        else:
            # loop to catch latest whitespace to split the message there
            num = target
            for char in reversed(string[:140]):
                num = num-1
                if RWhitespaces.match(char):
                    # if found it, split the two messages there but only if the
                    # whitespace is at least at the 137th character so to have
                    # room for the three suspension dots; if not, search the
                    # second to last one instead and move the rest to the
                    # second message
                    if num >= target-3:
                        continue
                    else:
                        msg1 = string[:num]
                        msg2 = string[num:]
                        if len(msg2) > target:
                            # if the second message is also longer than target
                            # just quit, not going to split in 3 parts...
                            msgtoolong()
                        else:
                            return msg1, msg2


def twitterpost(username, password, message):
    """Just a post to twitter function with basic authentication"""

    auth_header = username + ':' + password
    req = urllib.request.Request('https://twitter.com/statuses/update.json')
    req.add_header('Authorization', 'Basic %s' % b64encode(auth_header.encode()))
    req.data = message.encode()
    urllib.request.urlopen(req)


def argument_parser():
    """Argument parser"""
    usage = "usage: clitwitter.py -u [username] -p [password]"
    arguments = ArgumentParser(usage=usage)
    arguments.add_argument("-v", "--version",
            action="version",
            version=__version__)
    arguments.add_argument("-u", "--user",
            help="the twitter username",
            action="store",
            type=str,
            dest='username')
    arguments.add_argument("-p", "--password",
            help="the twitter password",
            action="store",
            type=str,
            dest='password')
    args = arguments.parse_args()

    return args


def main():
    """Main loop"""
    # get twitter login data
    args = argument_parser()
    if not args.username or not args.password:
        # we need both!
        print("Please insert both username and password for your twitter account")
        print("See -h for more help")
        exit(1)

    target = 140 # twitter messages limit

    # catch the arguments list and make it a string
    arguments = sys.argv[5:]
    str_arguments = " ".join(arguments)

    if len(str_arguments) <= target:
        # the message is already shorter than 140 characters? Post it then
        message1 = str_arguments
        twitterpost(args.username, args.password, message1)
        return 0
    else:
        # longer than 140? Truncate it in two
        msg1, msg2 = truncate(str_arguments, target)
        message1 = msg1 + '...'
        message2 = msg2

        # post both messages then
        for msg in message1, message2:
            twitterpost(args.username, args.password, msg)
            return 0


if __name__ == '__main__':
    status = main()
    sys.exit(status)
