

HAVE_MYSQL=yes
OMAP=map-server
ifeq ($(HAVE_MYSQL),yes)
	ALL_DEPENDS=sql tools
	SQL_DEPENDS=common_sql login char map import
	COMMON_SQL_DEPENDS=mt19937ar libconfig
	LOGIN_SQL_DEPENDS=mt19937ar libconfig common_sql
	CHAR_SQL_DEPENDS=mt19937ar libconfig common_sql
	MAP_SQL_DEPENDS=mt19937ar libconfig common_sql
else
	ALL_DEPENDS=needs_mysql
	SQL_DEPENDS=needs_mysql
	COMMON_SQL_DEPENDS=needs_mysql
	LOGIN_SQL_DEPENDS=needs_mysql
	CHAR_SQL_DEPENDS=needs_mysql
	MAP_SQL_DEPENDS=needs_mysql
endif


#####################################################################
.PHONY: all sql  \
	common_sql \
	mt19937ar \
	login \
	char \
	map \
	tools \
	import \
	test \
	clean help \
	install uninstall bin-clean \

all: $(ALL_DEPENDS)

sql: $(SQL_DEPENDS)

common_sql: $(COMMON_SQL_DEPENDS)
	@$(MAKE) -C src/common sql

login: $(LOGIN_SQL_DEPENDS)
	@$(MAKE) -C src/login sql

char: $(CHAR_SQL_DEPENDS)
	@$(MAKE) -C src/char

map: $(MAP_SQL_DEPENDS)
	@$(MAKE) -C src/map sql

mt19937ar:
	@$(MAKE) -C 3rdparty/mt19937ar

libconfig:
	@$(MAKE) -C 3rdparty/libconfig

tools:
	@$(MAKE) -C src/tool

test:
	@$(MAKE) -C src/test

import:
# 1) create conf/import folder
# 2) add missing files
# 3) remove remaining .svn folder
	@echo "building conf/import, conf/msg_conf/import and db/import folder..."
	@if test ! -d conf/import ; then mkdir conf/import ; fi
	@for f in $$(ls conf/import-tmpl) ; do if test ! -e conf/import/$$f ; then cp conf/import-tmpl/$$f conf/import ; fi ; done
	@rm -rf conf/import/.svn
	@if test ! -d conf/msg_conf/import ; then mkdir conf/msg_conf/import ; fi
	@for f in $$(ls conf/msg_conf/import-tmpl) ; do if test ! -e conf/msg_conf/import/$$f ; then cp conf/msg_conf/import-tmpl/$$f conf/msg_conf/import ; fi ; done
	@rm -rf conf/msg_conf/import/.svn
	@if test ! -d db/import ; then mkdir db/import ; fi
	@for f in $$(ls db/import-tmpl) ; do if test ! -e db/import/$$f ; then cp db/import-tmpl/$$f db/import ; fi ; done
	@rm -rf db/import/.svn

clean:
	@$(MAKE) -C src/common $@
	@$(MAKE) -C 3rdparty/mt19937ar $@
	@$(MAKE) -C 3rdparty/libconfig $@
	@$(MAKE) -C src/login $@
	@$(MAKE) -C src/char $@
	@$(MAKE) -C src/map $@
	@$(MAKE) -C src/tool $@
	@$(MAKE) -C src/test $@

help:
	@echo "most common targets are 'all' 'sql' 'conf' 'clean' 'help'"
	@echo "possible targets are:"
	@echo "'common_sql'  - builds object files used in SQL servers"
	@echo "'mt19937ar'   - builds object file of Mersenne Twister MT19937"
	@echo "'libconfig'   - builds object files of libconfig"
	@echo "'login'       - builds login server"
	@echo "'char'        - builds char server"
	@echo "'map'        - builds map server"
	@echo "'tools'       - builds all the tools in src/tools"
	@echo "'import'      - builds conf/import, conf/msg_conf/import and db/import folders from their template folders (x-tmpl)"
	@echo "'all'         - builds all the above targets"
	@echo "'sql'         - builds servers (targets 'common_sql' 'login' 'char' 'map' and 'import')"
	@echo "'test'        - builds tests"
	@echo "'clean'       - cleans builds and objects"
	@echo "'install'     - run installer wich setup rathena in /opt/"
	@echo "'bin-clean'   - delete binary installed"
	@echo "'uninstall'   - run uninstaller wich erase all install change"
	@echo "'help'        - outputs this message"

needs_mysql:
	@echo "MySQL not found or disabled by the configure script"
	@exit 1

install:
	@sh ./install.sh

bin-clean:
	@sh ./uninstall.sh bin

uninstall:
	@sh ./uninstall.sh all

#####################################################################
