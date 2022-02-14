all: build/tascar_ap_openmha.so build/showver_tascar build/showver_openmha

#include/usr/share/openmha/config.mk
include /usr/share/tascar/rules.mk

CXXFLAGS += -fPIC $(shell ./test_for_oldmha.sh)
LDLIBS += -ltascar -lopenmha

build: build/.directory

%/.directory:
	mkdir -p $*
	touch $@

build/%.so: src/%.cc build
	$(CXX) -shared -o $@ $< $(CXXFLAGS) $(LDFLAGS) $(LDLIBS)

build/%: src/%.cc build
	$(CXX) -o $@ $<

clean:
	rm -Rf build src/*~
