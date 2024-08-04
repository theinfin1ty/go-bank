postgres:
	docker run -d --name postgres16 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:16.3-alpine

createdb:
	docker exec -t postgres16 createdb --username=root --owner=root go_bank

dropdb:
	docker exec -t postgres16 dropdb go_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/go_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/go_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server