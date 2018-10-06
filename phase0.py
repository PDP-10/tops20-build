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

import tops20

def install():
    if os.path.exists(tops20.DISKFILE):
        os.unlink(tops20.DISKFILE)

    kl = tops20.start('../tools/klh10/run/klt20/mtboot.sav')
    kl.send('devmount mta0 ../tapes/dec/install.tap\r')
    kl.expect('KLH10. ')
    kl.send('go\r')
    kl.expect('MTBOOT>')
    kl.send('/l\r')
    kl.expect('MTBOOT>')
    kl.send('/g143\r')
    kl.expect('DO YOU WANT TO REPLACE THE FILE SYSTEM ON THE SYSTEM STRUCTURE\? ')
    kl.send('Y\r')
    kl.expect('DO YOU WANT TO DEFINE THE SYSTEM STRUCTURE\? ')
    kl.send('Y\r')
    kl.expect('HOW MANY PACKS ARE IN THIS STRUCTURE: ')
    kl.send('1\r')
    kl.expect('ON WHICH "CHANNEL,CONTROLLER,UNIT" IS LOGICAL PACK # 0 MOUNTED\? ')
    kl.send('0,-1,0\r')
    kl.expect('DO YOU WANT THE DEFAULT SWAPPING SPACE\? ')
    kl.send('Y\r')
    kl.expect('DO YOU WANT THE DEFAULT SIZE FRONT END FILE SYSTEM\? ')
    kl.send('Y\r')
    kl.expect('DO YOU WANT THE DEFAULT SIZE BOOTSTRAP AREA\? ')
    kl.send('Y\r')
    kl.expect('DO YOU WANT TO ENABLE PASSWORD ENCRYPTION FOR THE SYSTEM STRUCTURE\? ')
    kl.send('Y\r')
    kl.expect('WHAT IS THE NAME OF THIS STRUCTURE\? ')
    kl.send('PHASE0\r')
    kl.expect('DO YOU WANT TO WRITE A SET OF PROTOTYPE BAT BLOCKS\? ')
    kl.send('Y\r')
    kl.expect('WHY RELOAD\? ')
    kl.send('NEW\r')
    kl.expect('NO SYSJOB')
    kl.send('\03')
    kl.expect('MX>')
    kl.send('gmta0:\r')
    kl.expect('MX>')
    kl.send('gmta0:\r')
    kl.expect('MX>')
    kl.send('s\r')
    kl.expect('@')
    kl.send('terminal width 0\r')
    kl.expect('@')
    kl.send('enable\r')
    kl.expect('\$')
    kl.send('run mta0:\r')
    kl.expect('DLUSER>')
    kl.send('load mta0:\r')
    kl.expect('DLUSER>')
    kl.send('exit\r')
    kl.expect('\$')
    kl.send('run mta0:\r')
    kl.expect('DUMPER>')
    kl.send('files\r')
    kl.expect('DUMPER>')
    kl.send('tape mta0:\r')
    kl.expect('DUMPER>')
    kl.send('restore <*>*.*.* <system>*.*.*\r')
    kl.expect('DUMPER>')
    kl.send('restore <*>*.*.* <subsys>*.*.*\r')
    kl.expect('DUMPER>')
    kl.send('restore <*>*.*.* <subsys>*.*.*\r')
    kl.expect('DUMPER>')
    kl.send('restore <*>*.*.* <*>*.*.*\r')
    kl.expect('DUMPER>')
    kl.send('unload\r')
    kl.expect('DUMPER>')
    kl.send('exit\r')
    kl.expect('\$')
    kl.send('connect <system>\r')
    kl.expect('\$')
    kl.send('copy 2060-monmax.exe.* monitr.exe\r')
    kl.expect('\$')
    kl.send('\034')
    kl.expect('KLH10. ')
    kl.send('devmount mta0 ../config/config.tap\r')
    kl.expect('\[mta0: Tape online\]')
    kl.send('c\r')
    kl.expect('Continuing KN10')
    kl.send('\r')
    kl.expect('\$')
    kl.send('dumper\r')
    kl.expect('DUMPER>')
    kl.send('files\r')
    kl.expect('DUMPER>')
    kl.send('interchange\r')
    kl.expect('DUMPER>')
    kl.send('tape mta0:\r')
    kl.expect('DUMPER>')
    kl.send('restore <*>*.*.*\r')
    kl.expect('DUMPER>')
    kl.send('exit\r')
    # *sigh*
    kl.expect('\$')
    kl.send('rename 7-conf.cmd 7-config.cmd\r')
    kl.expect('\$')
    kl.send('rename 7-ptyc.ato 7-ptycon.ato\r')
    tops20.shutdown(kl)


def makestrap():
    if os.path.exists(tops20.BOOTSTRAP):
        os.unlink(tops20.BOOTSTRAP)
    kl = tops20.start('../tools/klh10/run/klt20/boot.sav')
    kl.send('devmount mta0 %s create\r' % (tops20.BOOTSTRAP,))
    kl.expect('KLH10. ')
    kl.send('go\r')
    kl.expect('BOOT>')
    kl.send('\r')
    kl.expect('WHY RELOAD\? ')
    kl.send('NEW\r')
    kl.expect('RUN CHECKD\? ')
    kl.send('Y\r')
    kl.expect('STRUCTURE STATUS CHANGE DETECTED', timeout=300)
    kl.expect('STRUCTURE STATUS CHANGE DETECTED')
    kl.expect('SJ  0: \r')
    kl.send('\r')
    kl.expect('@')
    kl.send('login operator dec-20\r')
    kl.expect('@')
    kl.send('terminal width 0\r')
    kl.expect('@')
    kl.send('enable\r')
    kl.expect('\$')

    kl.send('del <operator>*-lost-pages.bin.*\r')
    kl.expect('\$')
    kl.send('expunge <operator>\r')
    kl.expect('\$')
    kl.send('del <system-error>error.sys.*\r')
    kl.expect('\$')
    kl.send('expunge <system-error>\r')
    kl.expect('\$')
    kl.send('del <system>device-status.bin.*\r')
    kl.expect('\$')
    kl.send('expunge <system>\r')
    kl.expect('\$')
    kl.send('assign mta0\r')
    kl.expect('\$')
    kl.send('rewind mta0:\r')
    kl.expect('\$')
    kl.send('get ps:<system>monitr.exe\r')
    kl.expect('\$')
    kl.send('save mta0:\r')
    kl.expect('\$')
    kl.send('get system:exec.exe\r')
    kl.expect('\$')
    kl.send('save mta0:\r')
    kl.expect('\$')
    kl.send('get sys:dluser.exe\r')
    kl.expect('\$')
    kl.send('save mta0:\r')
    kl.expect('\$')
    kl.send('start\r')
    kl.expect('DLUSER>')
    kl.send('structure ps:\r')
    kl.expect('DLUSER>')
    kl.send('dump dluser.txt\r')
    kl.expect('DLUSER>')
    kl.send('exit\r')
    kl.expect('\$')
    kl.send('edit dluser.txt\r')
    kl.expect('\*')
    kl.send('SPHASE0:\033PS:\033^:*,10000\r')
    kl.expect('\*')
    kl.send('e\r')
    kl.expect('\$')
    kl.send('copy dluser.txt mta0:\r')
    kl.expect('\$')
    kl.send('del dluser.txt\r')
    kl.expect('\$')
    kl.send('expunge\r')
    kl.expect('\$')
    kl.send('get sys:dumper.exe\r')
    kl.expect('\$')
    kl.send('save mta0:\r')
    kl.expect('\$')
    kl.send('start\r')
    kl.expect('DUMPER>')
    kl.send('tape mta0:\r')
    kl.expect('DUMPER>')
    kl.send('exact\r')
    kl.expect('DUMPER>')
    kl.send('files\r')
    kl.expect('DUMPER>')
    kl.send('save ps:<*>*.*.* ps:<*>*.*.*\r')
    kl.expect('DUMPER>')
    kl.send('exit\r')
    kl.expect('\$')
    kl.send('unload mta0:\r')
    kl.expect('\$')
    kl.send('deassign mta0:\r')

    tops20.shutdown(kl)


if __name__ == '__main__':
    install()
    makestrap()
