.PHONY: init install

IAM=`whoami`
USER=www-data
GROUP=www-data
ETC=/etc/tanarky
LIBROOT=/usr/share/tanarky
HTDOCS=/var/www/tanarky
DIRS=bin lib

install:
	sudo rsync -av -e ssh --delete lib bin $(LIBROOT)/
	sudo rsync -av -e ssh --delete htdocs/ $(HTDOCS)/
	sudo chown -R $(USER):$(GROUP) $(LIBROOT) $(HTDOCS) $(ETC)

init:
	sudo mkdir -p $(ROOT)

initdev: init
	sudo chown -R $(IAM):$(IAM) $(ROOT)

initprod: init
	sudo chown -R $(USER):$(GROUP) $(ROOT)

