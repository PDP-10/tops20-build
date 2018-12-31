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
import re
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
    kl.sync()
    kl.build('<src>', maximum_subdirectories=262143)

    kl.build('<src.monitor>')
    kl.cl('connect <src.monitor>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/monitor.tap')
    kl.cl('del *.exe')

    kl.cl('submit ln2070.ctl/time/notify')
    kl.expect('From SYSTEM: Job LN2070 request #[0-9]* finished executing at', timeout=3600)
    kl.line('')
    kl.assert_exists('2060-monmax.exe', 'ln2070.log')

    kl.cl('submit t20-an70.ctl/time/notify')
    kl.expect('From SYSTEM: Job T20-AN request #[0-9]* finished executing at', timeout=3600)
    kl.line('')
    kl.assert_exists('an-monmax.exe', 't20-an.log')

    kl.cl('dir *.exe')
    kl.cl('copy *.exe <system>')
    kl.cl('copy bugstrings.txt <system>')
    kl.cl('copy an-monmax.exe <system>monitr.exe')

    kl.cl('copy monsym.unv <subsys>')
    kl.cl('copy macsym.unv <subsys>')

    kl.cl('copy kddt.rel <subsys>')
    kl.cl('copy mddt.rel <subsys>')

    kl.cl('copy ctermd.unv <subsys>')
    kl.cl('copy d36par.unv <subsys>')
    kl.cl('copy globs.unv <subsys>')
    kl.cl('copy mscpar.unv <subsys>')
    kl.cl('copy phypar.unv <subsys>')
    kl.cl('copy prolog.unv <subsys>')
    kl.cl('copy scpar.unv <subsys>')
    kl.cl('copy scapar.unv <subsys>')
    kl.cl('copy sercod.unv <subsys>')

    kl.cl('vdir')
    kl.sync()

    kl.build('<src.exec>')
    kl.cl('connect <src.exec>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/exec.tap')
    kl.cl('del *.exe')

    kl.cl('submit exec/notify')
    kl.expect(
        'From SYSTEM: Job EXEC request #[0-9]* finished executing at',
        timeout=305)
    kl.line('')
    kl.assert_exists('exec.exe', 'exec.log')

    kl.cl('submit mkmexc/notify')
    kl.expect(
        'From SYSTEM: Job MKMEXC request #[0-9]* finished executing at',
        timeout=305)
    kl.line('')
    kl.assert_exists('mic-exec.exe', 'mkmexc.log')

    kl.cl('submit mkcexc/notify')
    kl.expect(
        'From SYSTEM: Job MKCEXC request #[0-9]* finished executing at',
        timeout=305)
    kl.line('')
    kl.assert_exists('cmd-exec.exe', 'mkcexc.log')

    kl.sync()

    kl.cl('copy cmd-exec.exe <system>exec.exe')
    kl.expect('OK')

    kl.build('<third>')

    kl.build('<src.iddt>')
    kl.cl('connect <src.iddt>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/iddt.tap')
    kl.cl('exec iddt')
    kl.cl('<third>iddt.exe', 'Output IDDT to ')
    kl.expect('IDDT 9.1')
    kl.send('\032')

    # what version of midas are we building
    ver = max(
        int(name.split('.')[-1])
        for name in os.listdir('../src/midas')
        if re.match(r'[^.]+\.[^.]+\.\d+', name))
    kl.build('<src.midas>')
    kl.cl('connect <src.midas>')
    kl.cl('del *.*.*')
    kl.restore_interchange('../src/midas.tap')
    kl.cl('del *.exe')
    kl.cl('midas cvtunv')
    kl.cl('dsk:cvtunv')
    kl.cl('midas temp_midas')
    kl.cl('iddt')
    kl.expect('IDDT 9.1')
    kl.line(';ytemp.exe')
    kl.send('purify\033g')
    kl.expect('IDDT')
    kl.line(';umidas.exe.%d' % ver)
    kl.send('\032')
    kl.cl('copy cvtunv.exe <third>')
    kl.cl('copy midas.exe.%d <third>midas.exe.%d' % (ver, ver))

    kl.build('<info>')
    kl.cl('del <info>*.*.*')
    kl.build('<emacs>')
    kl.cl('del <emacs>*.*.*')
    kl.restore('../ref/emacs/emacs.tap', ['toed: ps:', 'info: ps:'])
    kl.cl('del <info>*.exe.*')
    kl.cl('connect <emacs>')
    kl.cl('del *.exe')
    kl.cl('edit/unsequence teco.mid')
    kl.cl('f.symtab\033', '\*')
    kl.cl('s13997\03324571\033.', '\*')  # ;SHOULD BE PLENTY (and yet)
    kl.cl('e', '\*')
    kl.cl('edit emacs.ctl')
    kl.cl('sinfo:emacs.init\033info:info.init\033^:*,10000', '\*')
    kl.cl('e', '\*')
    kl.cl('submit emacs/time/notify')
    kl.expect('From SYSTEM: Job EMACS request #[0-9]* finished executing at', timeout=3600)
    kl.line('')
    kl.assert_exists('nemacs.exe', 'emacs.log')
    kl.cl('rename nemacs.exe emacs.exe')

    # make clean by any other name
    kl.cl('del <src.*>*.exe')
    kl.cl('del <src.*>*.rel')

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
