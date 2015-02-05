#!/usr/bin/env python
#
#   bigpkg : find packages that require a lot of space on your system
#   v0.4.0 (2011-07-29)
#
#   Copyright (c) 2009-2011 by Allan McRae <allan@archlinux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Credits: Allan McRae for the initial script. markbabc and Karol for contributions
#   
#   Patched to work with Pacman >= 4.2 by Gianluca Fiore
#

import os, re

LOCAL_DB_PATH="/var/lib/pacman/local"

def adjust_space(pkg, size):
    size_l = len(size)
    spaces = (16-size_l)*" "
    return "{0}:{1}{2}".format(size, spaces, pkg)

def find_pkg_size(size, options=["KB", "MB", "GB"], count=0):
    if size >= 1024:
        count += 1
        return find_pkg_size(size/1024, options, count)
    else:
        if count == 0: return "{0:7,} {1}".format(size, options[count])
        else: return "{0:7,.2f} {1}".format(size, options[count])
def strip_versioning(pkg):
    r = re.compile('[^=,^<,^>]+')
    m = r.match(pkg)
    return m.group()

def parse_package_info(pkg, dir):
    pkg_deps[pkg] = []
    pkg_provides[pkg] = []
    pkg_size[pkg] = 0

    file = LOCAL_DB_PATH + "/" + dir + "/desc"
    f = open(file, "r")

    while 1:
        line = f.readline();
        if len(line) == 0:
            break
        if line[0:9] == "%DEPENDS%":
            while 1:
                line = f.readline();
                if len(line) == 1:
                    break
                pkg_deps[pkg].append(strip_versioning(line.strip()))
        if line[0:10] == "%PROVIDES%":
            while 1:
                line = f.readline();
                if len(line) == 1:
                    break
                pkg_provides[pkg].append(strip_versioning(line.strip()))
        if line[0:6] == "%SIZE%":
            line = f.readline();
            pkg_size[pkg] = int(line)/1024
    f.close()


pkg_list = []
pkg_deps = {}
pkg_provides = {}
pkg_size = {}

for dir in os.listdir(LOCAL_DB_PATH):
    try:
        pkg = dir[0:dir.rfind("-",0,dir.rfind("-"))]
        pkg_list.append(pkg)
        parse_package_info(pkg, dir)
    except NotADirectoryError:
        pass

pkg_deptree = {}

for pkg in pkg_list:
    pkg_deptree[pkg] = pkg_deps[pkg]
    for dep in pkg_deptree[pkg]:
            if dep in pkg_deps:
                for rdep in pkg_deps[dep]:
                    if not rdep in pkg_deptree[pkg]:
                        pkg_deptree[pkg].append(rdep);
            else:
                for key in pkg_provides:
                    if dep in pkg_provides[key]:
                        pkg_deptree[pkg][pkg_deptree[pkg].index(dep)] = key
                        dep = key
                        break
                for rdep in pkg_deps[dep]:
                    if not rdep in pkg_deptree[pkg]:
                        pkg_deptree[pkg].append(rdep);				

needed_by = {}
for pkg in pkg_list:
    needed_by[pkg] = 0

for pkg in pkg_list:
    for dep in pkg_deptree[pkg]:
        needed_by[dep] += 1

pkg_usage = {}
for pkg in pkg_list:
    if needed_by[pkg] == 0:
        pkg_usage[pkg] = pkg_size[pkg]
        for dep in pkg_deps[pkg]:
            pkg_usage[pkg] += pkg_size[dep] / needed_by[dep]

pkg_usage = [ [v[1],v[0]] for v in pkg_usage.items()]
pkg_usage.sort()
print("      SIZE       PKG")
for pkg in range(len(pkg_usage)):
    print("{0}".format(adjust_space(pkg_usage[pkg][1], find_pkg_size(round(pkg_usage[pkg][0])))))
print("      SIZE       PKG")
