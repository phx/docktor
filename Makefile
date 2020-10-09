
build:
	@docker build -t docktor.img .

run:
	@docker run -d -v "${PWD}/hiddenservice:/var/www/hiddenservice" --name docktor docktor.img

stop:
	@echo NOT IMPLEMENTED YET

kill-all-dockers:
	@docker kill $(shell docker ps -q)
