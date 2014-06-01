
COMMON_H = $(shell ls ../common/*.h)
COMMON_AR = ../common/obj_all/common.a
COMMON_SQL_AR = ../common/obj_sql/common_sql.a
COMMON_INCLUDE = -I../common

MT19937AR_OBJ = ../../3rdparty/mt19937ar/mt19937ar.o
MT19937AR_H = ../../3rdparty/mt19937ar/mt19937ar.h
MT19937AR_INCLUDE = -I../../3rdparty/mt19937ar

LIBCONFIG_H = $(shell ls ../../3rdparty/libconfig/*.h)
LIBCONFIG_AR = ../../3rdparty/libconfig/obj/libconfig.a
LIBCONFIG_INCLUDE = -I../../3rdparty/libconfig

LOGIN_OBJ = $(shell ls *.c | sed -e "s/\.c/\.o/g")
LOGIN_SQL_OBJ = $(LOGIN_OBJ:%=obj_sql/%)
LOGIN_H = $(shell ls *.h)

HAVE_MYSQL=yes
ifeq ($(HAVE_MYSQL),yes)
	SQL_DEPENDS=login-server
else
	SQL_DEPENDS=needs_mysql
endif
ALL_DEPENDS= sql



#####################################################################
.PHONY :all sql clean help

all: $(ALL_DEPENDS)

sql: $(SQL_DEPENDS)

clean:
	@echo "	CLEAN	login"
	@rm -rf *.o obj_sql ../../login-server

help:
	@echo "possible targets are 'sql' 'all' 'clean' 'help'"
	@echo "'sql'       - login server (SQL version)"
	@echo "'all'       - builds all above targets"
	@echo "'clean'     - cleans builds and objects"
	@echo "'help'      - outputs this message"

#####################################################################

needs_mysql:
	@echo "MySQL not found or disabled by the configure script"
	@exit 1

# object directories

obj_sql:
	@echo "	MKDIR	obj_sql"
	@-mkdir obj_sql

#executables

login-server: obj_sql $(LOGIN_SQL_OBJ) $(COMMON_SQL_AR) $(COMMON_AR)  $(MT19937AR_OBJ)
	@echo "	LD	login-server"
	@gcc  -flto -L/usr/lib -lpthread -o ../../login-server $(LOGIN_SQL_OBJ) $(COMMON_SQL_AR) $(COMMON_AR) $(MT19937AR_OBJ) $(LIBCONFIG_AR) -lpcre -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lpthread -lm -lz  -ldl -L/usr/lib/x86_64-linux-gnu -lmysqlclient -lpthread -lz -lm -ldl
	    

# login object files

obj_sql/%.o: %.c $(LOGIN_H) $(COMMON_H) $(MT19937AR_H) $(LIBCONFIG_H)
	@echo "	CC	$<"
	@gcc -g -O2 -DMAXCONN=16384 -pipe -ffast-math -Wall -DHAS_TLS -flto -Wno-switch -fno-strict-aliasing -DHAVE_SETRLIMIT -DHAVE_STRNLEN -DPACKETVER=20130807  -Wno-pointer-sign -DHAVE_MONOTONIC_CLOCK $(COMMON_INCLUDE) $(MT19937AR_INCLUDE) $(LIBCONFIG_INCLUDE) -DWITH_SQL -I/usr/include/mysql  -I../common -I/usr/include -c $(OUTPUT_OPTION) $<

# missing object files
$(COMMON_AR):
	@$(MAKE) -C ../common sql

$(COMMON_SQL_AR):
	@$(MAKE) -C ../common sql

$(MT19937AR_OBJ):
	@$(MAKE) -C ../../3rdparty/mt19937ar

$(LIBCONFIG_AR):
	@$(MAKE) -C ../../3rdparty/libconfig
