.PHONY: init install

IAM=`whoami`
LIBROOT=/usr/share/tanarky
HTDOCS=/var/www/tanarky
DIRS=bin lib

install:
	sudo rsync -av -e ssh --delete lib/    $(LIBROOT)/
	sudo rsync -av -e ssh --delete htdocs/ $(HTDOCS)/

init:
	sudo mkdir -p $(ROOT)

initdev: init
	sudo chown -R $(IAM):$(IAM) $(ROOT)

initprod: init
	sudo chown -R www-data:www-data $(ROOT)

upload: initprod
	rsync -av -e 'ssh' $(DIRS) $(ROOT)/
