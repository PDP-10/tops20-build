all: phase1/phase1.tap

TOPS20_7:=	BB-H137F-BM:install \
		BB-EV83B-BM:tcpip \
		BB-H138F-BM:dist1 \
		BB-LW55A-BM:dist2 \
		BB-M780D-SM:monsrc \
		BB-GS97B-SM:execsrc \
		BB-M080Z-SM:monsrcmod.4 \
		BB-M081Z-SM:execsrcmod.4 \
		BB-PENEA-BM:tsu04.1 \
		BB-KL11M-BM:tsu04.2 \
		BB-M836D-BM:tools

# getting these from trailing-edge.com because it's mysteriously more
# complete than bitsavers
TOPS20_BASE:=http://pdp-10.trailing-edge.com/tapes/

dec-7.0-tapes:
	for tape_name in $(TOPS20_7); do \
		oIFS="$$IFS" ;\
		IFS=: ;\
		set $$tape_name ;\
		IFS="$$oIFS" ;\
		tapenumber=$$(echo $$1 | tr A-Z a-z) ;\
		tapefunction=$$2 ;\
		$(RM) tapes/dec/$${tapefunction}.tap.bz2 ;\
		wget \
			-O tapes/dec/$${tapefunction}.tap.bz2 \
			$(TOPS20_BASE)/$${tapenumber}.tap.bz2 \
		;\
		bunzip2 tapes/dec/$${tapefunction}.tap.bz2 ;\
	done

tapes/dev/install.tap: dec-7.0-tapes

clean::
	true
#	$(RM) -r tapes/dec

pexpect-venv/bin/python3:
	python3 -m venv pexpect-venv
	pexpect-venv/bin/pip install --upgrade pip
	pexpect-venv/bin/pip install pexpect

pexpect-venv: pexpect-venv/bin/python3

clean::
	$(RM) -r pexpect-venv __pycache__

bin:
	mkdir bin

clean::
	$(RM) -r bin

build:
	mkdir build

clean::
	$(RM) -r build

build/klh10:: build
	mkdir build/klh10

clean::
	$(RM) -r build/klh10

build/klh10/bld-kl/kn10-kl:
	mkdir -p build/klh10
	(cd tools/klh10; ./autogen.sh)
	(cd build/klh10; ../../tools/klh10/configure --bindir=$(CURDIR)/bin)
	make -C build/klh10/bld-kl

bin/kn10-kl: bin build/klh10/bld-kl/kn10-kl
	make -C build/klh10/bld-kl install

phase0: clean-phase0
	mkdir phase0

clean-phase0:
	$(RM) -r phase0

clean:: clean-phase0

phase0/stamp: phase0 pexpect-venv/bin/python3 tapes/dec/install.tap bin/kn10-kl config/config.tap phase0.py
	(cd phase0; ../pexpect-venv/bin/python3 ../phase0.py) && touch phase0/stamp

phase1: clean-phase1
	mkdir phase1

clean-phase1:
	$(RM) -r phase1

clean:: clean-phase1

phase1/phase1.tap: phase1 pexpect-venv/bin/python3 tapes/bootstrap.tap bin/kn10-kl phase1.py src/monitor.tap
	(cd phase1; ../pexpect-venv/bin/python3 ../phase1.py)

tools/back10/back10:
	make -C tools/back10 all

clean::
	make -C tools/back10 clean

config/config.tap: config/7-config.cmd config/7-ptycon.ato tools/back10/back10
	(cd config; ../tools/back10/back10 -c -f config.tap -i 7-config.cmd 7-ptycon.ato)

clean::
	$(RM) config/config.tap

MONITOR_SRC = \
	append.cmd aprsrv.mac asembl.cmd bugs.mac cdkldv.mac cdpsrv.mac \
	cdrsrv.mac cfspar.mac cfssrv.mac cfsusr.mac cidll.mac cludgr.mac \
	clufrk.mac clupar.mac comnd.mac crypt.mac ctermd.mac cthsrv.mac \
	d36com.mac d36par.mac datime.mac device.mac diag.mac direct.mac \
	disc.mac dnadll.mac dob.mac dskalc.mac dtesrv.mac enq.mac enqpar.mac \
	enqsrv.mac fesrv.mac filini.mac filmsc.mac filnft.mac fork.mac \
	free.mac futili.mac getsav.mac globs.mac gtjfn.mac io.mac ipcf.mac \
	jntman.mac jsysa.mac jsysf.mac jsysm.mac kddt.rel latsrv.mac \
	ldinit.mac linepr.mac llinks.mac llmop.mac ln2070.ctl lnkini.ccl \
	lnklbg.ccl lnklm0.ccl lnklmx.ccl lognam.mac lookup.mac lpfedv.mac \
	magtap.mac mddt.rel mexec.mac mflin.mac mflout.mac monitr.cmd \
	mscpar.mac mstr.mac n70big.mac n70max.mac namam0.mac nipar.mac \
	nisrv.mac niusr.mac nrtsrv.mac ntman.mac p70big.mac p70max.mac \
	pagem.mac pagutl.mac param0.mac params.mac parlbg.mac parlm0.mac \
	parlmx.mac phyh11.mac phyh2.mac phyklp.mac phykni.mac phym2.mac \
	phym78.mac phymsc.mac phymvr.mac phyp2.mac phyp4.mac phypar.mac \
	physio.mac phyx2.mac plt.mac pmt.mac postld.mac prolog.mac ptp.mac \
	ptr.mac router.mac rp2.mac rsxsrv.mac scampi.mac scapar.mac sched.mac \
	scjsys.mac sclink.mac scpar.mac scsjsy.mac sercod.mac sources.cmd \
	stg.mac swpalc.mac syserr.mac sysflg.mac systap.ctl tape.mac \
	timer.mac tops.mac ttydef.mac ttysrv.mac vedit.mac versio.mac

src/monitor.tap: $(addprefix src/monitor/,$(MONITOR_SRC)) tools/back10/back10
	(cd src/monitor; ../../tools/back10/back10 -c -f ../monitor.tap -i $(MONITOR_SRC))

clean::
	$(RM) src/monitor.tap

.PHONEY: dec-7.0-tapes clean clean-phase0 clean-phase1
