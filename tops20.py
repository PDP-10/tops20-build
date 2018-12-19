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

import os
import pexpect
import sys


DISKFILE = 'RH20.RP07.1'
BOOTSTRAP = '../tapes/bootstrap.tap'

_output = open(sys.stdout.fileno(), mode='w', encoding='utf8', buffering=1)


class KLH10:
    def __init__(self):
        self.ex =  pexpect.spawn('../bin/kn10-kl ../klt20.ini', encoding='iso8859-1')
        self.ex.logfile_read = _output
        self.expect('ipaddr=')

    def send(self, *args, **kw):
        return self.ex.send(*args, **kw)

    def line(self, s, **kw):
        return self.send(s + '\r', **kw)

    def cl(self, s, prompt=r'\$', **kw):
        self.expect(prompt, **kw)
        self.line(s)

    def expect(self, *args, **kw):
        return self.ex.expect(*args, **kw)

    def close(self):
        self.ex.close()

    def start(self, bootstrap):
        self.cl('load %s' % (bootstrap,), 'KLH10. ')
        self.expect('Entvec:')

    def boot(self):
        self.start('../tools/klh10/run/klt20/boot.sav')
        self.cl('go', 'KLH10. ')
        self.cl('', 'BOOT>')
        self.cl('NEW', r'(?i)WHY RELOAD\? ')
        self.cl('Y', f'(?i)RUN CHECKD\? ')
        self.expect(r'(?i)STRUCTURE STATUS CHANGE DETECTED', timeout=300)
        self.expect(f'(?i)STRUCTURE STATUS CHANGE DETECTED')
        self.expect('SJ  0: \r')

    def install_dec(self, structure='PS'):
        self.install_boot(structure, '../tapes/dec/install.tap')
        self.cl('run mta0:')
        self.cl('files', 'DUMPER>')
        self.cl('tape mta0:', 'DUMPER>')
        self.cl('restore <*>*.*.* <system>*.*.*', 'DUMPER>')
        self.cl('restore <*>*.*.* <subsys>*.*.*', 'DUMPER>')
        self.cl('restore <*>*.*.* <subsys>*.*.*', 'DUMPER>')
        self.cl('restore <*>*.*.* <*>*.*.*', 'DUMPER>')
        self.cl('unload', 'DUMPER>')
        self.cl('exit', 'DUMPER>')

    def install(self, structure='PS'):
        self.install_boot(structure)
        self.cl('run mta0:')
        self.cl('files', 'DUMPER>')
        self.cl('tape mta0:', 'DUMPER>')
        self.cl('restore <*>*.*.*', 'DUMPER>')
        self.cl('unload', 'DUMPER>')
        self.cl('exit', 'DUMPER>')

    def install_boot(self, structure='PS', tape=BOOTSTRAP):
        self.start('../tools/klh10/run/klt20/mtboot.sav')
        self.cl('devmount mta0 %s' % (tape,), 'KLH10. ')
        self.cl('go', 'KLH10. ')
        self.cl('/l', 'MTBOOT>')
        self.cl('/g143', 'MTBOOT>')
        self.cl('Y', r'(?i)DO YOU WANT TO REPLACE THE FILE SYSTEM ON THE SYSTEM STRUCTURE\? ')
        self.cl('Y', r'(?i)DO YOU WANT TO DEFINE THE SYSTEM STRUCTURE\? ')
        self.cl('1', r'(?i)HOW MANY PACKS ARE IN THIS STRUCTURE: ')
        self.cl('0,-1,0', r'(?i)ON WHICH "CHANNEL,CONTROLLER,UNIT" IS LOGICAL PACK # 0 MOUNTED\? ')
        self.cl('Y', r'(?i)DO YOU WANT THE DEFAULT SWAPPING SPACE\? ')
        self.cl('Y', r'(?i)DO YOU WANT THE DEFAULT SIZE FRONT END FILE SYSTEM\? ')
        self.cl('Y', r'(?i)DO YOU WANT THE DEFAULT SIZE BOOTSTRAP AREA\? ')
        self.cl('Y', r'(?i)DO YOU WANT TO ENABLE PASSWORD ENCRYPTION FOR THE SYSTEM STRUCTURE\? ')
        self.cl(structure, r'(?i)WHAT IS THE NAME OF THIS STRUCTURE\? ')
        self.cl('Y', r'(?i)DO YOU WANT TO WRITE A SET OF PROTOTYPE BAT BLOCKS\? ')
        self.cl('NEW', r'(?i)WHY RELOAD\? ')
        self.expect(r'(?i)NO SYSJOB')
        self.line('\03')
        self.cl('gmta0:', 'MX>')
        self.cl('gmta0:', 'MX>')
        self.cl('s', 'MX>')
        self.termsetup()
        self.cl('run mta0:')
        self.cl('load mta0:', 'DLUSER>')
        self.cl('exit', 'DLUSER>')

    def mttape(self, tape):
        self.expect('\$')
        self.send('\034')
        self.cl('devmount mta0 %s' % (tape,), 'KLH10. ')
        self.expect('\[mta0: Tape online\]')
        self.line('c')
        self.expect('Continuing KN10')
        self.line('')

    def termsetup(self):
        self.cl('terminal width 0', '@')
        self.cl('enable', '@')

    def login(self):
        self.line('')
        self.cl('login operator dec-20', '@')
        self.termsetup()

    def shutdown(self):
        self.cl('\05cease now')
        self.expect('\[Confirm\]')
        self.line('')
        self.expect('Shutdown complete')  # it does say this twice
        self.expect('Shutdown complete')
        self.send('\034')
        self.cl('shutdown', 'KLH10. ')
        self.cl('q', 'KLH10. ')
        self.cl('y', '\[Confirm\]')
        self.expect(['Shutting down\r', pexpect.EOF])
        self.close()

    def build(self, name, **kw):
        subcommands = {
            'protection': '777740',
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
            'default-file-protection': '777752',
            'generations': None,
            'maximum-subdirectories': None,
            }
        self.cl('build %s' % (name,))
        for (k, v) in kw.items():
            tag = k.lower().replace('_', '-')
            if tag not in subcommands:
                raise Exception('unknown build subcommand %s (%s)' % (tag, repr(v)))
            subcommands[tag] = v
        for (k, v) in subcommands.items():
            if v is None:
                continue
            if v is True:
                command = k
            elif v is False:
                command = 'no %s' % (k,)
            else:
                command = '%s %s' % (k, v)
            self.cl(command, '\$\$')
        self.cl('', '\$\$')

    def restore(self, tape, dirs=['<*>*.*.*'], interchange=False):
        self.mttape(tape)
        self.cl('dumper')
        self.cl('files', 'DUMPER>')
        if interchange:
            self.cl('interchange', 'DUMPER>')
        self.cl('tape mta0:', 'DUMPER>')
        for ds in dirs:
            self.cl('restore ' + ds, 'DUMPER>')
        self.cl('exit', 'DUMPER>')

    def restore_interchange(self, tape):
        self.restore(tape, ['<*>*.*.*'], interchange=True)

    def systape(self, tape, structure='PS'):
        if os.path.exists(tape):
            os.unlink(tape)
        self.mttape('%s create' % (tape,))

        self.cl('del <operator>*-lost-pages.bin.*')
        self.cl('expunge <operator>')
        self.cl('del <system-error>error.sys.*')
        self.cl('expunge <system-error>')
        self.cl('del <system>device-status.bin.*')
        self.cl('expunge <system>')
        self.cl('del <spool>*.*.*')
        self.cl('expunge <spool>')
        self.cl('assign mta0')
        self.cl('rewind mta0:')
        self.cl('get ps:<system>monitr.exe')
        self.cl('save mta0:')
        self.cl('get system:exec.exe')
        self.cl('save mta0:')
        self.cl('get sys:dluser.exe')
        self.cl('save mta0:')
        self.cl('start')
        self.cl('structure ps:', 'DLUSER>')
        self.cl('dump dluser.txt', 'DLUSER>')
        self.cl('exit', 'DLUSER>')
        self.cl('edit dluser.txt')
        self.cl('S%s:\033PS:\033^:*,10000' % (structure,), '\*')
        self.cl('e', '\*')
        self.cl('copy dluser.txt mta0:')
        self.cl('del dluser.*')
        self.cl('expunge')
        self.cl('get sys:dumper.exe')
        self.cl('save mta0:')
        self.cl('start')
        self.cl('tape mta0:', 'DUMPER>')
        self.cl('exact', 'DUMPER>')
        self.cl('files', 'DUMPER>')
        self.cl('save ps:<*>*.*.* ps:<*>*.*.*', 'DUMPER>')
        self.cl('exit', 'DUMPER>')
        self.cl('unload mta0:')
        self.cl('deassign mta0:')

