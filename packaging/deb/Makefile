ALL_CSV=$(wildcard *.csv)

CODENAME=$(shell lsb_release -sc)

OPENMHAVER:=$(shell dpkg-query --show --showformat='$${Version}' libopenmha)
TASCARVER:=$(shell dpkg-query --show --showformat='$${Version}' libtascar)

PACKVERSION=$(TASCARVER)-$(OPENMHAVER)
ifeq "$(DEBUG)" "yes"
PACKVERSION:=$(PACKVERSION)-debug
endif
LIBVERSION=$(VERSION)

all:
	rm -Rf pack;\
	mkdir -p pack/$(CODENAME);\
	for c in $(ALL_CSV); do $(MAKE) $${c}.version && (cd ../.. && LIBVERSION=$(LIBVERSION) LSLVERSION=$(LSLVERSION) OPENMHAVER=$(OPENMHAVER) TASCARVER=$(TASCARVER) ./packaging/deb/htchdebian-mkdeb packaging/deb/$$c `cat packaging/deb/$${c}.version` ); done;\
	mv ../../*.deb pack/$(CODENAME);\
	for c in $(ALL_CSV:.csv=); do ls pack/$(CODENAME)/$${c}_*.deb || return 1; done


ver:
	@echo "Packaging: $(PACKVERSION)"

.PHONY: $(wildcard *.version)

%.version:
	echo $(PACKVERSION) > $@

clean:
	rm -Rf pack
	rm -f *.version *.documented a.out
