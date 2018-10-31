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

dec-7.0-tapes: tapes/dec
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

tapes/dec:
	mkdir -p tapes/dec

clean::
	$(RM) -r tapes/dec

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

build/klh10/bld-kl/kn10-kl: tools/klh10/autogen.sh
	mkdir -p build/klh10
	(cd tools/klh10; ./autogen.sh)
	(cd build/klh10; ../../tools/klh10/configure --bindir=$(CURDIR)/bin)
	make -C build/klh10/bld-kl

tools/klh10/autogen.sh:
	git submodule update --init tools/klh10

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

phase1/phase1.tap: phase1 pexpect-venv/bin/python3 tapes/bootstrap.tap bin/kn10-kl phase1.py src/monitor.tap src/exec.tap src/midas.tap src/iddt.tap
	(cd phase1; ../pexpect-venv/bin/python3 ../phase1.py)

tools/back10/back10:
	make -C tools/back10 all

clean::
	make -C tools/back10 clean

config/config.tap: config/7-config.cmd config/7-ptycon.ato tools/back10/back10
	(cd config; ../tools/back10/back10 -c -f config.tap -i 7-config.cmd 7-ptycon.ato)

clean::
	$(RM) config/config.tap

MONITOR_DEP := $(wildcard src/monitor/*)
MONITOR_SRC := $(notdir $(MONITOR_DEP))

src/monitor.tap: $(MONITOR_DEP) tools/back10/back10
	(cd src/monitor; ../../tools/back10/back10 -c -f ../monitor.tap -i $(MONITOR_SRC))

clean::
	$(RM) src/monitor.tap

EXEC_SRC = \
	edexec.mac excsrc.cmd exec.ctl exec0.mac exec1.mac exec2.mac \
	exec3.mac exec4.mac execca.mac execcs.mac execde.mac execed.mac \
	execf0.mac execgl.mac execin.mac execmt.mac execp.mac execpr.mac \
	execqu.mac execse.mac execsu.mac execvr.mac loexec.ccl mkexec.cmd \
	batch.cmd

src/exec.tap: $(addprefix src/exec/,$(EXEC_SRC)) tools/back10/back10
	(cd src/exec; ../../tools/back10/back10 -c -f ../exec.tap -i $(EXEC_SRC))

clean::
	$(RM) src/exec.tap

src/midas: $(wildcard ref/its/midas/*)
	$(RM) -r src/midas src/-midas
	mkdir src/-midas
	for i in ref/its/src/midas/*; do echo $$i | sed -Ee 's;(.*/)([^.]*)\.(.*);perl -p -e '\''s/\\000//g'\'' \1\2.\3 | perl -p -e '\''s/$$/\\r/'\'' > src/-midas/\2.mid;'  | sh -x; done
	ls src/-midas
	mv src/-midas src/midas

clean::
	$(RM) -r src/midas src/-midas

src/midas.tap: src/midas tools/back10/back10
	(cd src/midas; ../../tools/back10/back10 -c -f ../midas.tap -i $(notdir $(wildcard src/midas/*.mid)))

clean::
	$(RM) src/midas.tap

src/iddt.tap: $(wildcard src/iddt/*.mac) tools/back10/back10
	(cd src/iddt; ../../tools/back10/back10 -c -f ../iddt.tap -i $(notdir $(wildcard src/iddt/*.mac)))

clean::
	$(RM) src/iddt.tap

.PHONEY: dec-7.0-tapes clean clean-phase0 clean-phase1












