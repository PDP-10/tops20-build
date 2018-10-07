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

    def shutdown(self):
        self.expect('\$')
        self.cmd('\05cease now')
        self.expect('\[Confirm\]')
        self.cmd('')
        self.expect('Shutdown complete')  # it does say this twice
        self.expect('Shutdown complete')
        self.send('\034')
        self.expect('KLH10. ')
        self.cmd('shutdown')
        self.expect('KLH10. ')
        self.cmd('q')
        self.expect('\[Confirm\]')
        self.cmd('y')
        self.expect(['Shutting down\r', pexpect.EOF])
        self.close()

    def build(self, name, **kw):
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
        index = self.expect(['\$', '@'])
        if index == 1:
            self.cmd('enable')
            self.expect('\$')
        self.cmd('build %s' % (name,))
        for (k, v) in kw.items():
            tag = k.lower().replace('_', '-')
            if tag not in subcommands:
                raise Exception('unknown build subcommand %s (%s)' % (tag, repr(v)))
            subcommands[tag] = v
        for (k, v) in subcommands.items():
            if v is None:
                continue
            self.expect('\$\$')
            if v is True:
                self.cmd(k)
            elif v is False:
                self.cmd('no %s' % (k,))
            else:
                self.cmd('%s %s' % (k, v))
        self.expect('\$\$')
        self.cmd('')

    def restore_interchange(self, tape):
        self.mttape(tape)
        self.expect('\$')
        self.cmd('dumper')
        self.expect('DUMPER>')
        self.cmd('files')
        self.expect('DUMPER>')
        self.cmd('interchange')
        self.expect('DUMPER>')
        self.cmd('tape mta0:')
        self.expect('DUMPER>')
        self.cmd('restore <*>*.*.*')
        self.expect('DUMPER>')
        self.cmd('exit')

    def systape(self, tape):
        self.mttape('%s create' % (tape,))

        self.expect('\$')
        self.cmd('del <operator>*-lost-pages.bin.*')
        self.expect('\$')
        self.cmd('expunge <operator>')
        self.expect('\$')
        self.cmd('del <system-error>error.sys.*')
        self.expect('\$')
        self.cmd('expunge <system-error>')
        self.expect('\$')
        self.cmd('del <system>device-status.bin.*')
        self.expect('\$')
        self.cmd('expunge <system>')
        self.expect('\$')
        self.cmd('del <spool>*.*.*')
        self.expect('\$')
        self.cmd('expunge <spool>')
        self.expect('\$')
        self.cmd('assign mta0')
        self.expect('\$')
        self.cmd('rewind mta0:')
        self.expect('\$')
        self.cmd('get ps:<system>monitr.exe')
        self.expect('\$')
        self.cmd('save mta0:')
        self.expect('\$')
        self.cmd('get system:exec.exe')
        self.expect('\$')
        self.cmd('save mta0:')
        self.expect('\$')
        self.cmd('get sys:dluser.exe')
        self.expect('\$')
        self.cmd('save mta0:')
        self.expect('\$')
        self.cmd('start')
        self.expect('DLUSER>')
        self.cmd('structure ps:')
        self.expect('DLUSER>')
        self.cmd('dump dluser.txt')
        self.expect('DLUSER>')
        self.cmd('exit')
        self.expect('\$')
        self.cmd('edit dluser.txt')
        self.expect('\*')
        self.cmd('SPHASE0:\033PS:\033^:*,10000')
        self.expect('\*')
        self.cmd('e')
        self.expect('\$')
        self.cmd('copy dluser.txt mta0:')
        self.expect('\$')
        self.cmd('del dluser.*')
        self.expect('\$')
        self.cmd('expunge')
        self.expect('\$')
        self.cmd('get sys:dumper.exe')
        self.expect('\$')
        self.cmd('save mta0:')
        self.expect('\$')
        self.cmd('start')
        self.expect('DUMPER>')
        self.cmd('tape mta0:')
        self.expect('DUMPER>')
        self.cmd('exact')
        self.expect('DUMPER>')
        self.cmd('files')
        self.expect('DUMPER>')
        self.cmd('save ps:<*>*.*.* ps:<*>*.*.*')
        self.expect('DUMPER>')
        self.cmd('exit')
        self.expect('\$')
        self.cmd('unload mta0:')
        self.expect('\$')
        self.cmd('deassign mta0:')

