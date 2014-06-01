
COMMON_H = $(shell ls ../common/*.h)
COMMON_AR = ../common/obj_all/common.a
COMMON_SQL_AR = ../common/obj_sql/common_sql.a
COMMON_INCLUDE = -I../common/

MT19937AR_OBJ = ../../3rdparty/mt19937ar/mt19937ar.o
MT19937AR_H = ../../3rdparty/mt19937ar/mt19937ar.h
MT19937AR_INCLUDE = -I../../3rdparty/mt19937ar

LIBCONFIG_H = $(shell ls ../../3rdparty/libconfig/*.h)
LIBCONFIG_AR = ../../3rdparty/libconfig/obj/libconfig.a
LIBCONFIG_INCLUDE = -I../../3rdparty/libconfig

COMMON_SQL_OBJ = ../common/obj_sql/sql.o
COMMON_H = ../common/sql.h

CHAR_OBJ = $(shell ls *.c | sed -e "s/\.c/\.o/g")
CHAR_SQL_OBJ = $(CHAR_OBJ:%=obj_sql/%)
CHAR_H = $(shell ls ../char/*.h)

HAVE_MYSQL=yes
ifeq ($(HAVE_MYSQL),yes)	
	SQL_DEPENDS=char-server
else
	SQL_DEPENDS=needs_mysql
endif
ALL_DEPENDS=sql



#####################################################################
.PHONY : all sql clean help

all: $(ALL_DEPENDS)

sql: $(SQL_DEPENDS)

clean:
	@echo "	CLEAN	char"
	@rm -rf *.o obj_sql ../../char-server

help:
	@echo "possible targets are 'sql' 'all' 'clean' 'help'"
	@echo "'sql'       - char server"
	@echo "'all'       - builds all above targets"
	@echo "'clean'     - cleans builds and objects"
	@echo "'help'      - outputs this message"

#####################################################################


char-server: obj_sql $(CHAR_SQL_OBJ) $(LIBCONFIG_AR) $(COMMON_SQL_AR) $(COMMON_AR)
	@echo "	LD	char-server"
	@gcc  -flto -L/usr/lib -lpthread -o ../../char-server $(CHAR_SQL_OBJ) $(LIBCONFIG_AR) $(COMMON_SQL_AR) $(COMMON_AR) $(MT19937AR_OBJ) $(LIBCONFIG_OBJ) -lpcre -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lm -lz  -ldl -L/usr/lib/x86_64-linux-gnu -lmysqlclient -lpthread -lz -lm -ldl

needs_mysql:
	@echo "MySQL not found or disabled by the configure script"
	@exit 1

obj_sql:
	@echo "	MKDIR	obj_sql"
	@-mkdir obj_sql

obj_sql/%.o: %.c $(CHAR_H) $(COMMON_H) $(COMMON_SQL_H) $(MT19937AR_H) $(LIBCONFIG_H)
	@echo "	CC	$<"
	@gcc -g -O2 -DMAXCONN=16384 -pipe -ffast-math -Wall -DHAS_TLS -flto -Wno-switch -fno-strict-aliasing -DHAVE_SETRLIMIT -DHAVE_STRNLEN -DPACKETVER=20130807  -Wno-pointer-sign -DHAVE_MONOTONIC_CLOCK $(COMMON_INCLUDE) $(MT19937AR_INCLUDE) $(LIBCONFIG_INCLUDE) -I/usr/include/mysql  -I../common -I/usr/include -c $(OUTPUT_OPTION) $<

# missing object files
$(COMMON_AR):
	@$(MAKE) -C ../common sql

$(COMMON_SQL_AR):
	@$(MAKE) -C ../common sql

$(MT19937AR_OBJ):
	@$(MAKE) -C ../../3rdparty/mt19937ar

$(LIBCONFIG_AR):
	@$(MAKE) -C ../../3rdparty/libconfig
