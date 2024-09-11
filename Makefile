MAIN_GO = ./src/cmd/server/main.go
BINARY_NAME = ./server

build: 
	@go build -o ./bin/$(BINARY_NAME) $(MAIN_GO)

run:
	@go run $(MAIN_GO)

clean:
	@rm -f $(BINARY_NAME)

build-docker:
	@docker compose build

run-docker:
	@docker compose build
	@docker compose up -d

stop-docker:
	@docker compose down

restart-docker:
	@docker compose down
	@docker compose build
	@docker compose up -d

push-docker:
	@docker build . -t m1kky8/backend:prod --push

update:
	@ssh prod "cd /home/prod/scripts && bash update.sh"

upgrade: 
	@docker build . -t m1kky8/backend:prod --push
	@ssh prod "cd /home/prod/scripts && bash update.sh"

sh-mongo:
	@docker exec -it mongo mongosh

.PHONY: build run clean build-docker run-docker stop-docker push-docker restart-docker update upgrade sh-mongo
