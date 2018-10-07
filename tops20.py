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


class KLH10:
    def __init__(self):
        self.ex =  pexpect.spawn('../bin/kn10-kl ../klt20.ini', encoding='iso8859-1')
        self.ex.logfile_read = sys.stdout
        self.expect('ipaddr=')
        self.expect('KLH10. ')

    def send(self, *args, **kw):
        return self.ex.send(*args, **kw)

    def cmd(self, s, **kw):
        return self.send(s + '\r', **kw)

    def expect(self, *args, **kw):
        return self.ex.expect(*args, **kw)

    def close(self):
        self.ex.close()

    def start(self, bootstrap):
        self.cmd('load %s' % (bootstrap,))
        self.expect('Entvec:')

    def boot(self):
        self.start('../tools/klh10/run/klt20/boot.sav')
        self.cmd('go')
        self.expect('BOOT>')
        self.cmd('')
        self.expect('WHY RELOAD\? ')
        self.cmd('NEW')
        self.expect('RUN CHECKD\? ')
        self.cmd('Y')
        self.expect('STRUCTURE STATUS CHANGE DETECTED', timeout=300)
        self.expect('STRUCTURE STATUS CHANGE DETECTED')
        self.expect('SJ  0: \r')

    def install_dec(self, structure='PS'):
        self.install_boot(structure, '../tapes/dec/install.tap')
        self.expect('\$')
        self.cmd('run mta0:')
        self.expect('DUMPER>')
        self.cmd('files')
        self.expect('DUMPER>')
        self.cmd('tape mta0:')
        self.expect('DUMPER>')
        self.cmd('restore <*>*.*.* <system>*.*.*')
        self.expect('DUMPER>')
        self.cmd('restore <*>*.*.* <subsys>*.*.*')
        self.expect('DUMPER>')
        self.cmd('restore <*>*.*.* <subsys>*.*.*')
        self.expect('DUMPER>')
        self.cmd('restore <*>*.*.* <*>*.*.*')
        self.expect('DUMPER>')
        self.cmd('unload')
        self.expect('DUMPER>')
        self.cmd('exit')

    def install(self, structure='PS'):
        self.install_boot(structure)
        self.expect('\$')
        self.cmd('run mta0:')
        self.expect('DUMPER>')
        self.cmd('files')
        self.expect('DUMPER>')
        self.cmd('tape mta0:')
        self.expect('DUMPER>')
        self.cmd('restore <*>*.*.*')
        self.expect('DUMPER>')
        self.cmd('unload')
        self.expect('DUMPER>')
        self.cmd('exit')

    def install_boot(self, structure='PS', tape=BOOTSTRAP):
        self.start('../tools/klh10/run/klt20/mtboot.sav')
        self.cmd('devmount mta0 %s' % (tape,))
        self.expect('KLH10. ')
        self.cmd('go')
        self.expect('MTBOOT>')
        self.cmd('/l')
        self.expect('MTBOOT>')
        self.cmd('/g143')
        self.expect('DO YOU WANT TO REPLACE THE FILE SYSTEM ON THE SYSTEM STRUCTURE\? ')
        self.cmd('Y')
        self.expect('DO YOU WANT TO DEFINE THE SYSTEM STRUCTURE\? ')
        self.cmd('Y')
        self.expect('HOW MANY PACKS ARE IN THIS STRUCTURE: ')
        self.cmd('1')
        self.expect('ON WHICH "CHANNEL,CONTROLLER,UNIT" IS LOGICAL PACK # 0 MOUNTED\? ')
        self.cmd('0,-1,0')
        self.expect('DO YOU WANT THE DEFAULT SWAPPING SPACE\? ')
        self.cmd('Y')
        self.expect('DO YOU WANT THE DEFAULT SIZE FRONT END FILE SYSTEM\? ')
        self.cmd('Y')
        self.expect('DO YOU WANT THE DEFAULT SIZE BOOTSTRAP AREA\? ')
        self.cmd('Y')
        self.expect('DO YOU WANT TO ENABLE PASSWORD ENCRYPTION FOR THE SYSTEM STRUCTURE\? ')
        self.cmd('Y')
        self.expect('WHAT IS THE NAME OF THIS STRUCTURE\? ')
        self.cmd(structure)
        self.expect('DO YOU WANT TO WRITE A SET OF PROTOTYPE BAT BLOCKS\? ')
        self.cmd('Y')
        self.expect('WHY RELOAD\? ')
        self.cmd('NEW')
        self.expect('NO SYSJOB')
        self.cmd('\03')
        self.expect('MX>')
        self.cmd('gmta0:')
        self.expect('MX>')
        self.cmd('gmta0:')
        self.expect('MX>')
        self.cmd('s')
        self.termsetup()
        self.expect('\$')
        self.cmd('run mta0:')
        self.expect('DLUSER>')
        self.cmd('load mta0:')
        self.expect('DLUSER>')
        self.cmd('exit')

    def mttape(self, tape):
        self.expect('\$')
        self.send('\034')
        self.expect('KLH10. ')
        self.cmd('devmount mta0 %s' % (tape,))
        self.expect('\[mta0: Tape online\]')
        self.cmd('c')
        self.expect('Continuing KN10')
        self.cmd('')

    def termsetup(self):
        self.expect('@')
        self.cmd('terminal width 0')
        self.expect('@')
        self.cmd('enable')

    def login(self):
        self.cmd('\r')
        self.expect('@')
        self.cmd('login operator dec-20')
        self.termsetup()


def start(bootstrap):
    kl = KLH10()
    kl.start(bootstrap)
    return kl


def shutdown(kl):
    kl.expect('\$')
    kl.cmd('\05cease now')
    kl.expect('\[Confirm\]')
    kl.cmd('')
    kl.expect('Shutdown complete')  # it does say this twice
    kl.expect('Shutdown complete')
    kl.send('\034')
    kl.expect('KLH10. ')
    kl.cmd('shutdown')
    kl.expect('KLH10. ')
    kl.cmd('q')
    kl.expect('\[Confirm\]')
    kl.cmd('y')
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
