# TOPS-20 builder

This is the beginning of a builder for TOPS-20.  At the moment,

```
make phase1/phase1.tap
```

should build an installer tape image based on the monitor sources in
```src/monitor``` and ```tapes/bootstrap.tap```.
```tapes/bootstrap``` can be rebuilt from the DEC distribution tapes
with

```
make phase0/stamp
```

(network access required to retrieve the DEC tape images) but that
eventually should not ever be necessary, and it is expected that
eventually bootstrap.tap will be periodically copied from a built
```phase1.tap```.  It may be necessary for some development work as
it's currently based on the original unpatched 7.0 distribution (but
that might be superceded by the source code).

At the moment, ```src/``` contains only a copy of the unpatched 7.0
monitor code; this is expected to be rolled forward and expanded over
time (EXEC is obviously the next step).

The vision (possibly hallucination) that ```src/```xxx might
eventually replaced by submodules pointing into repositories with more
complete history.

