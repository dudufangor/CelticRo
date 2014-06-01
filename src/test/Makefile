
COMMON_H = $(shell ls ../common/*.h)

MT19937AR_OBJ = ../../3rdparty/mt19937ar/mt19937ar.o
MT19937AR_H = ../../3rdparty/mt19937ar/mt19937ar.h
MT19937AR_INCLUDE = -I../../3rdparty/mt19937ar

LIBCONFIG_H = $(shell ls ../../3rdparty/libconfig/*.h)
LIBCONFIG_AR = ../../3rdparty/libconfig/obj/libconfig.a
LIBCONFIG_INCLUDE = -I../../3rdparty/libconfig

TEST_SPINLOCK_OBJ=obj/test_spinlock.o
TEST_SPINLOCK_H=
TEST_SPINLOCK_DEPENDS=obj $(TEST_SPINLOCK_OBJ) ../common/obj_sql/common_sql.a ../common/obj_all/common.a $(MT19937AR_OBJ)



#####################################################################
.PHONY :all test clean

all: test

test: test_spinlock

clean:
	@echo "	CLEAN	test"
	@rm -rf *.o obj ../../test_spinlock

help:
	@echo "possible targets are 'all' 'test' 'clean' 'help'"
	@echo "'test'   - builds test_spinlock test atm"
	@echo "'all'    - builds all above targets"
	@echo "'clean'  - cleans builds and objects"
	@echo "'help'   - outputs this message"

#####################################################################

test_spinlock: $(TEST_SPINLOCK_DEPENDS)
	@echo "	LD	$@"
	@gcc  -flto -L/usr/lib -lpthread -o ../../test_spinlock $(TEST_SPINLOCK_OBJ) ../common/obj_sql/common_sql.a ../common/obj_all/common.a $(MT19937AR_OBJ) $(LIBCONFIG_AR) -lpcre -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lm -lz  -ldl -L/usr/lib/x86_64-linux-gnu -lmysqlclient -lpthread -lz -lm -ldl

# object directories

obj:
	@echo "	MKDIR	obj"
	@-mkdir obj

# login object files

obj/%.o: %.c $(COMMON_H) $(MT19937AR_H) $(LIBCONFIG_H)
	@echo "	CC	$<"
	@gcc -g -O2 -DMAXCONN=16384 -pipe -ffast-math -Wall -DHAS_TLS -flto -Wno-switch -fno-strict-aliasing -DHAVE_SETRLIMIT -DHAVE_STRNLEN -DPACKETVER=20130807  -Wno-pointer-sign -DHAVE_MONOTONIC_CLOCK $(MT19937AR_INCLUDE) $(LIBCONFIG_INCLUDE) -DWITH_SQL -I/usr/include/mysql  -I../common -I/usr/include -c $(OUTPUT_OPTION) $<

# missing object files
../common/obj_all/common.a:
	@$(MAKE) -C ../common sql
	
../common/obj_sql/common_sql.a:
	@$(MAKE) -C ../common sql

MT19937AR_OBJ:
	@$(MAKE) -C ../../3rdparty/mt19937ar

LIBCONFIG_AR:
	@$(MAKE) -C ../../3rdparty/libconfig
