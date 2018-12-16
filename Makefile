all: phase1/phase1.tap

TOPS20_7:=	bb-h137f-bm:install \
		bb-ev83b-bm_longer:tcpip \
		bb-h138f-bm:dist1 \
		bb-lw55a-bm:dist2 \
		bb-m780d-sm:monsrc \
		bb-gs97b-sm:execsrc \
		bb-m080z-sm:monsrcmod.4 \
		bb-m081z-sm:execsrcmod.4 \
		bb-penea-bm:tsu04.1 \
		bb-kl11m-bm:tsu04.2 \
		bb-m836d-bm:tools

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

phase0/phase0.tap: phase0 pexpect-venv/bin/python3 tapes/dec/install.tap bin/kn10-kl config/config.tap phase0.py
	(cd phase0; ../pexpect-venv/bin/python3 ../phase0.py)
	bzip2 -fk tapes/phase0.tap
	cp -v tapes/phase0.tap.bz2 tapes/bootstrap.tap.bz2

tapes/bootstrap.tap: tapes/bootstrap.tap.bz2
	bunzip2 -k tapes/bootstrap.tap.bz2

clean::
	$(RM) tapes/bootstrap.tap

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

CONFIG_SRC := 7-config.cmd 7-ptycon.ato
CONFIG_DEP := $(addprefix config/,$(CONFIG_SRC))

config/config.tap: $(CONFIG_DEP) tools/back10/back10
	(cd config; ../tools/back10/back10 -c -f config.tap -i $(CONFIG_SRC))

clean::
	$(RM) config/config.tap

MONITOR_DEP := $(wildcard src/monitor/*)
MONITOR_SRC := $(notdir $(MONITOR_DEP))

src/monitor.tap: $(MONITOR_DEP) tools/back10/back10
	(cd src/monitor; ../../tools/back10/back10 -c -f ../monitor.tap -i $(MONITOR_SRC))

clean::
	$(RM) src/monitor.tap

EXEC_DEP := $(wildcard src/exec/*)
EXEC_SRC := $(notdir $(EXEC_DEP))

src/exec.tap: $(EXEC_DEP) tools/back10/back10
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
