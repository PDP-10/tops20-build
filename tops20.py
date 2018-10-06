#!/usr/bin/python3

# This is mostly functional speech and probably not subject to copyright.
# However, if you insist on a license:
#
# Copyright © 2018 Karl Ramm
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following
# disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
# THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

import pexpect
import sys


DISKFILE = 'RH20.RP07.1'
BOOTSTRAP = '../tapes/bootstrap.tap'


def start(bootstrap):
    kl = pexpect.spawn('../bin/kn10-kl ../klt20.ini', encoding='iso8859-1')
    kl.logfile_read = sys.stdout
    kl.expect('ipaddr=')
    kl.expect('KLH10. ')
    kl.send('load %s\r' % (bootstrap,))
    kl.expect('Entvec:')
    return kl


def shutdown(kl):
    kl.expect('\$')
    kl.send('\05cease now\r')
    kl.expect('\[Confirm\]')
    kl.send('\r')
    kl.expect('Shutdown complete')  # it does say this twice
    kl.expect('Shutdown complete')
    kl.send('\034')
    kl.expect('KLH10. ')
    kl.send('shutdown\r')
    kl.expect('KLH10. ')
    kl.send('q\r')
    kl.expect('\[Confirm\]')
    kl.send('y\r')
    kl.expect(['Shutting down\r', pexpect.EOF])
    kl.close()


def build(kl, name, **kw):
    subcommands = {
        'protection': None,
        'ipcf': None,
        'operator': None,
        'number': None,
        'password': None,
        'permanent': None,
        'tops10-project-programmer-number': None,
        'working': 'infinity',
        'permanent': 'infinity',
        'files-only': True,
        'number': None,
        'user-of-group': None,
        'directory-group': None,
        'default-file-protection': None,
        'generations': None,
        'maximum-subdirectories': None,
        }
    index = kl.expect(['\$', '@'])
    if index == 1:
        kl.send('enable\r')
        kl.expect('\$')
    kl.send('build %s\r' % (name,))
    for (k, v) in kw.items():
        tag = k.lower().replace('_', '-')
        if tag not in subcommands:
            raise Exception('unknown build subcommand %s (%s)' % (tag, repr(v)))
        subcommands[tag] = v
    for (k, v) in subcommands.items():
        if v is None:
            continue
        kl.expect('\$\$')
        if v is True:
            kl.send('%s\r' % (k,))
        elif v is False:
            kl.send('no %s\r' % (k,))
        else:
            kl.send('%s %s\r' % (k, v))
    kl.expect('\$\$')
    kl.send('\r')
