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
import sys

import tops20


def install():
    if os.path.exists(tops20.DISKFILE):
        os.unlink(tops20.DISKFILE)

    kl = tops20.KLH10()
    kl.install('PHASE1')
    tops20.shutdown(kl)


def monbuild():
    kl = tops20.KLH10()
    kl.boot()
    kl.login()
    tops20.build(kl, '<src>', maximum_subdirectories=262143)
    tops20.build(kl, '<src.monitor>')
    kl.expect('\$')
    kl.send('connect <src.monitor>\r')
    kl.mttape('../src/monitor.tap')
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
    kl.expect('\$')
    kl.send('del *.exe\r')
    kl.expect('\$')
    kl.send('copy tty: batch.cmd\r')
    kl.send('define mon: ps:<src.monitor>\r')
    kl.send('define r: mon:\r')
    kl.send('\032')
    kl.expect('\$')
    kl.send('submit ln2070.ctl/time/notify\r')
    kl.expect('From SYSTEM: Job LN2070 request #[0-9]* finished executing at', timeout=3600)
    kl.send('\r')
    kl.expect('\$')
    kl.send('dir 2060-monmax.exe\r')
    index = kl.expect(['2060-MONMAX.EXE', 'File not found'])
    if index != 0:
        print('monitor not built')
        kl.expect('\$')
        kl.send('type ln2070.log')
        tops20.shutdown(kl)
        sys.exit(1)
    kl.expect('\$')
    kl.send('copy 2060-monmax.exe <system>monitr.exe\r')
    tops20.shutdown(kl)

    # now boot it and see if it worked, if so, build an install tape
    kl = tops20.KLH10()
    kl.boot()
    kl.send('\r')
    kl.expect('@')
    kl.send('login operator dec-20\r')
    kl.expect('@')
    kl.send('terminal width 0\r')
    kl.expect('@')
    kl.send('enable\r')

    if os.path.exists('phase1.tap'):
        os.remove('phase1.tap')

    kl.mttape('phase1.tap create')

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
    kl.send('SPHASE1:\033PS:\033^:*,10000\r')
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
    monbuild()
