
LIBCONFIG_OBJ =  $(shell ls *.c | sed -e "s/\.c/\.o/g")
LIBCONFIG_DIR_OBJ = $(LIBCONFIG_OBJ:%=obj/%)
LIBCONFIG_H =  $(shell ls *.h)
LIBCONFIG_AR = obj/libconfig.a



#####################################################################
.PHONY : all clean help

all: $(LIBCONFIG_AR)

clean:
	@echo "	CLEAN	libconfig"
	@rm -rf obj *.o

help:
	@echo "possible targets are 'all' 'clean' 'help'"
	@echo "'all'    - builds $(LIBCONFIG_DIR_OBJ)"
	@echo "'clean'  - deletes $(LIBCONFIG_DIR_OBJ)"
	@echo "'help'   - outputs this message"

#####################################################################

obj_dir:
	@echo "	MKDIR	obj"
	@-mkdir obj
	
obj/%.o: %.c $(LIBCONFIG_H)
	@echo "	CC	$<"
	@gcc -g -O2 -DMAXCONN=16384 -pipe -ffast-math -Wall -DHAS_TLS -flto -Wno-switch -fno-strict-aliasing -DHAVE_SETRLIMIT -DHAVE_STRNLEN -DPACKETVER=20130807  -Wno-pointer-sign -DHAVE_MONOTONIC_CLOCK -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE_URL=\"\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -D__EXTENSIONS__=1 -D_ALL_SOURCE=1 -D_GNU_SOURCE=1 -D_POSIX_PTHREAD_SEMANTICS=1 -D_TANDEM_SOURCE=1 -DHAVE_USELOCALE=1 -DHAVE_NEWLOCALE=1 -DHAVE_FREELOCALE=1 -DHAVE_XLOCALE_H=1 -DHAVE_LIBZ=1 -DHAVE_LIBPTHREAD=1 -DHAVE_LIBPTHREAD=1 -DHAVE_LIBPTHREAD=1 -DHAVE_LIBPTHREAD=1 -DHAVE_LIBPTHREAD=1 -DHAVE_LIBPTHREAD=1 -DHAVE_LIBPTHREAD=1  -I../common -I/usr/include -c $(OUTPUT_OPTION) $<

$(LIBCONFIG_AR): obj_dir $(LIBCONFIG_DIR_OBJ)
	@echo "	AR	$@"
	@/usr/bin/ar rcs obj/libconfig.a $(LIBCONFIG_DIR_OBJ)
