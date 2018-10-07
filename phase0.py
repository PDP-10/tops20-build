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

    kl = tops20.KLH10()
    kl.install_dec('PHASE0')
    kl.expect('\$')
    kl.send('connect <system>\r')
    kl.expect('\$')
    kl.send('copy 2060-monmax.exe.* monitr.exe\r')
    kl.mttape('../config/config.tap')
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
    kl.shutdown()


def makestrap():
    if os.path.exists(tops20.BOOTSTRAP):
        os.unlink(tops20.BOOTSTRAP)
    kl = tops20.KLH10()
    kl.boot()

    kl.login()

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
    kl.mttape('%s create' % (tops20.BOOTSTRAP,))
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

    kl.shutdown()


if __name__ == '__main__':
    install()
    makestrap()
