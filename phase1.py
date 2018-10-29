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
    kl.shutdown()


def build():
    kl = tops20.KLH10()
    kl.boot()
    kl.login()
    kl.build('<src>', maximum_subdirectories=262143)

    kl.build('<src.monitor>')
    kl.cl('connect <src.monitor>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/monitor.tap')
    kl.cl('del *.exe')
    kl.cl('submit ln2070.ctl/time/notify')
    kl.expect('From SYSTEM: Job LN2070 request #[0-9]* finished executing at', timeout=3600)
    kl.line('')
    kl.cl('type ln2070.log')
    kl.cl('dir 2060-monmax.exe')
    index = kl.expect(['2060-MONMAX.EXE', 'File not found'])
    if index != 0:
        print('monitor not built')
        kl.shutdown()
        sys.exit(1)
    kl.cl('copy 2060-monmax.exe <system>monitr.exe')

    kl.build('<src.exec>')
    kl.cl('connect <src.exec>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/exec.tap')
    kl.cl('del *.exe')
    kl.cl('submit exec/time/notify')
    kl.expect('From SYSTEM: Job EXEC request #[0-9]* finished executing at', timeout=3600)
    kl.line('')
    kl.cl('type exec.log')
    kl.cl('dir exec.exe')
    index = kl.expect(['EXEC.EXE', 'File not found'])
    if index != 0:
        print('exec not built')
        kl.shutdown()
        sys.exit(1)
    kl.cl('copy exec.exe <system>exec.exe')

    kl.build('<src.midas>')
    kl.cl('connect <src.midas>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/midas.tap')
    kl.cl('del *.exe')
    kl.cl('midas cvtunv')
    kl.cl('dsk:cvtunv')
    kl.cl('midas midas')
    kl.cl('copy *.exe <third>')

    kl.shutdown()

    # now boot it and see if it worked, if so, build an install tape
    kl = tops20.KLH10()
    kl.boot()
    kl.login()

    if os.path.exists('phase1.tap'):
        os.remove('phase1.tap')

    kl.systape('phase1.tap', 'PHASE1')

    kl.cl('information version')

    kl.shutdown()


if __name__ == '__main__':
    install()
    build()
