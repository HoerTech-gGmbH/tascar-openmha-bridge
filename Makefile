all: build/tascar_ap_openmha.so

CXXFLAGS += -Itascar/libtascar/include -Itascar/libtascar/build	\
-IopenMHA/mha/libmha/src/ -fPIC

.PHONY : libtascar libopenmha

libtascar:
	$(MAKE) -C tascar libtascar

libopenmha: openMHA/config.mk
	$(MAKE) -C openMHA mha/libmha

build: build/.directory

openMHA/config.mk:
	(cd openMHA && ./configure)

%/.directory:
	mkdir -p $*
	touch $@

build/%: build

build/%.so: libtascar libopenmha

build/%.so: src/%.cc
	$(CXX) -shared -o $@ $< $(CXXFLAGS) $(LDFLAGS) $(LDLIBS)

