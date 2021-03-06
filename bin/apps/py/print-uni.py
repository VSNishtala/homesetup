#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""@package -
   @script: print-uni.py
  @purpose: Print a backslash (4 digits) unicode character E.g:. \\uf118.
  @created: Sep 12, 2019
   @author: <B>H</B>ugo <B>S</B>aporetti <B>J</B>unior
   @mailto: yorevs@gmail.com
     @site: https://github.com/yorevs/homesetup
  @license: Please refer to <http://unlicense.org/>
"""

import os
import sys
import re

APP_NAME = os.path.basename(__file__)

# Version tuple: (major,minor,build)
VERSION = (0, 9, 0)

# Usage message
USAGE = """
Print a backslash 4 digits unicode character E.g:. \\uf118 => \\uf118

Usage: python {} <4-digit-unicode-escape>
""".format(APP_NAME)


# @purpose: Display the usage message and exit with the specified code ( or zero as default )
def usage(exit_code=0):
    print(USAGE)
    sys.exit(exit_code)


# @purpose: Display the current program version and exit
def version():
    print('{} v{}.{}.{}'.format(APP_NAME, VERSION[0], VERSION[1], VERSION[2]))
    sys.exit(0)


# @purpose: Print the unicode string
def sysout(string):
    sys.stdout.write(string.encode('utf-8').decode('unicode-escape'))


args = sys.argv[1:]
str_code = ''.join(args)

if str_code == '-v':
    version()

if not re.match(r"^[a-fA-F0-9]{4}$", str_code):
    usage()
else:
    sysout('\\u%s' % str_code)
