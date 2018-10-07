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


def monbuild():
    kl = tops20.KLH10()
    kl.boot()
    kl.login()
    kl.build('<src>', maximum_subdirectories=262143)
    kl.build('<src.monitor>')
    kl.expect('\$')
    kl.cmd('connect <src.monitor>')
    kl.restore_interchange('../src/monitor.tap')
    kl.expect('\$')
    kl.cmd('del *.exe')
    kl.expect('\$')
    kl.cmd('copy tty: batch.cmd')
    kl.cmd('define mon: ps:<src.monitor>')
    kl.cmd('define r: mon:')
    kl.send('\032')
    kl.expect('\$')
    kl.cmd('submit ln2070.ctl/time/notify')
    kl.expect('From SYSTEM: Job LN2070 request #[0-9]* finished executing at', timeout=3600)
    kl.cmd('')
    kl.expect('\$')
    kl.cmd('type ln2070.log')
    kl.expect('\$')
    kl.cmd('dir 2060-monmax.exe')
    index = kl.expect(['2060-MONMAX.EXE', 'File not found'])
    if index != 0:
        print('monitor not built')
        kl.shutdown()
        sys.exit(1)
    kl.expect('\$')
    kl.cmd('copy 2060-monmax.exe <system>monitr.exe')
    kl.shutdown()

    # now boot it and see if it worked, if so, build an install tape
    kl = tops20.KLH10()
    kl.boot()
    kl.login()

    if os.path.exists('phase1.tap'):
        os.remove('phase1.tap')

    kl.systape('phase1.tap')

    kl.shutdown()


if __name__ == '__main__':
    install()
    monbuild()
