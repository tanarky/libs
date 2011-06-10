.PHONY: init install

IAM=`whoami`
ROOT=/usr/share/tanarky
DIRS=bin lib

init:
	sudo mkdir -p $(ROOT)

initdev: init
	sudo chown -R $(IAM):$(IAM) $(ROOT)

initprod: init
	sudo chown -R www-data:www-data $(ROOT)

upload: initprod
	rsync -av -e 'ssh' $(DIRS) $(ROOT)/