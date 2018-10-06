#!/usr/bin/python3
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
