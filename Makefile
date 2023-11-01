ARCH ?= X86

build:
	scons build/$(ARCH)/gem5.opt -j8

build_fast:
	scons build/$(ARCH)/gem5.fast -j8

clean:
	rm -rf m5out/ logs/
