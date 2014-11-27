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

import subprocess

puppet_version = None

class CheckFailed(Exception):
    def __init__(self, error, path, details=None):
        self.args = (error, path, details)

def get_puppet_version():
    global puppet_version

    popen = subprocess.Popen(["puppet", "--version"],
                              stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = popen.communicate()
    if popen.returncode:
        puppet_version = 0
    else:
        ma, mi, rel = output[0].split('.')
        puppet_version = int(ma) * 1000 + int(mi) * 100 + int(rel)

def puppet_checker(path):
    """Check syntax of puppet manifests"""
    if puppet_version == None:
        get_puppet_version()

    if puppet_version >= 2700:
        cmd = ['puppet', 'parser', 'validate', '--color=false',
               '--noop', '--vardir=/tmp', '--confdir=/tmp', path]
    else:
        cmd = ['puppet', '--color=false', '--noop', '--vardir=/tmp',
               '--confdir=/tmp', '--parseonly', path]

    popen = subprocess.Popen(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = popen.communicate()
    if popen.returncode:
        # Using '--ignoreimport is broken as of puppet 2.6.X:
        # https://projects.puppetlabs.com/issues/5081
        # so we check the error message to ignore import errors:
        if not 'found for import of' in output[0]:
            verbose = "\n".join(output).strip()
            raise CheckFailed("You can verify the error using '%s'" % " ".join(cmd), path, verbose)


def ruby_checker(path):
    """Simple ruby syntax checker"""
    cmd = ['ruby', '-c', path]
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    popen.communicate()
    if popen.returncode:
        raise CheckFailed("You can verify the error using '%s'" % " ".join(cmd), path)


def template_checker(path):
    """Check syntax of erb templates"""
    cmd_str = "erb -P -x -T '-' %s | ruby -c "
    cmd = [ cmd_str % path]
    popen = subprocess.Popen(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    popen.communicate()
    if popen.returncode:
        raise CheckFailed("You can verify the error using '%s'" % cmd[0], path)


_file_checkers = { 'pp':        puppet_checker,
                   'rb':        ruby_checker,
                   'erb':       template_checker,
                 }

def check(path):
    try:
        extension = path.rsplit('.',1)[-1]
    except IndexError:
        pass # ignore files without extension

    try:
        _file_checkers[extension](path)
    except KeyError:
        pass # ignore unknown extensions
