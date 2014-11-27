# vim: set fileencoding=utf-8 :
#
# (C) 2011 Guido Guenther <agx@sigxcpu.org>
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Funciton to ease git usage

import os
import subprocess
import puppethooks.checkers

def diff_tree(oldrev, newrev):
    # We use -z to handle filenames with spaces, tabs, etc.
    cmd = ['git', 'diff-tree', '--raw', '-r', '-z', oldrev, newrev ]
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    # Parse the '\0' terminated filenames out of the metadata
    output = popen.communicate()[0].split('\0')
    for i in xrange(0, len(output)-2, 2):
        meta, filename = output[i:i+2]
        yield meta.split() + [ filename ]


def diff_cached(rev):
    """Check the index against the given commit"""
    # We use -z to handle filenames with spaces, tabs, etc.
    cmd = ['git', 'diff', '--cached', '--diff-filter=AM', '--raw', '-z' ]
    if rev:
        cmd.append(rev)
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    # Parse the '\0' terminated filenames out of the metadata
    output = popen.communicate()[0].split('\0')
    for i in xrange(0, len(output)-2, 2):
        meta, filename = output[i:i+2]
        yield meta.split() + [ filename ]


def verify_rev(rev):
    """Verify ref, return True if it's o.k."""
    return not subprocess.call(['git', 'rev-parse', '-q', '--verify', '--no-revs', rev])


def write_tmp_blob(dir, name, sha):
    """Write the git blog to a temporary file"""
    cmd = ['git', 'cat-file', '-p', sha ]
    abs_path = os.path.join(dir, os.path.basename(name))
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    output = popen.communicate()[0]
    f = file(abs_path, 'w')
    f.write(output)
    f.close()
    return abs_path


def do_check(name, tmpdir, sha):
    """Call the checker for a given file path and content sha"""
    path = write_tmp_blob(tmpdir, name, sha)
    puppethooks.checkers.check(path)
    os.unlink(path)

