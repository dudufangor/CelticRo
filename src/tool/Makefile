
COMMON_OBJ = minicore.o malloc.o showmsg.o strlib.o utils.o des.o grfio.o
COMMON_DIR_OBJ = $(COMMON_OBJ:%=../common/obj_all/%)
COMMON_H = $(shell ls ../common/*.h)
COMMON_INCLUDE = -I../common/

LIBCONFIG_H = $(shell ls ../../3rdparty/libconfig/*.h)
LIBCONFIG_AR = ../../3rdparty/libconfig/obj/libconfig.a
LIBCONFIG_INCLUDE = -I../../3rdparty/libconfig

OTHER_H = ../config/renewal.h

MAPCACHE_OBJ = obj_all/mapcache.o



#####################################################################
.PHONY : all mapcache clean help

all: mapcache

mapcache: obj_all $(MAPCACHE_OBJ) $(COMMON_DIR_OBJ) $(LIBCONFIG_OBJ)
	@echo "	LD	$@"
	@gcc  -flto -L/usr/lib -lpthread -o ../../mapcache $(MAPCACHE_OBJ) $(COMMON_DIR_OBJ) $(LIBCONFIG_AR) -lpcre -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lm -lz  -ldl

clean:
	@echo "	CLEAN	tool"
	@rm -rf obj_all/*.o ../../mapcache

help:
	@echo "possible targets are 'mapcache' 'all' 'clean' 'help'"
	@echo "'mapcache'  - mapcache generator"
	@echo "'all'       - builds all above targets"
	@echo "'clean'     - cleans builds and objects"
	@echo "'help'      - outputs this message"

#####################################################################

obj_all:
	-mkdir obj_all

obj_all/%.o: %.c $(COMMON_H) $(OTHER_H) $(LIBCONFIG_H)
	@echo "	CC	$<"
	@gcc -g -O2 -DMAXCONN=16384 -pipe -ffast-math -Wall -DHAS_TLS -flto -Wno-switch -fno-strict-aliasing -DHAVE_SETRLIMIT -DHAVE_STRNLEN -DPACKETVER=20130807  -Wno-pointer-sign -DHAVE_MONOTONIC_CLOCK $(COMMON_INCLUDE) $(LIBCONFIG_INCLUDE)  -I../common -I/usr/include -c $(OUTPUT_OPTION) $<

# missing common object files
$(COMMON_DIR_OBJ):
	@$(MAKE) -C ../common sql

$(LIBCONFIG_AR):
	@$(MAKE) -C ../../3rdparty/libconfig
