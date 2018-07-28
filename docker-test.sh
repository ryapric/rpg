# Script to copy files into a Postgres Docker container, and `make install` them
extension="rpg"
container="pg"
exec="docker container exec $container sh -c"

docker container cp ../${extension} ${container}:/root
$exec "if ! command -v make; then apk add make; fi"
$exec "cd /root/${extension} && make install"
$exec "psql -U postgres -c \"DROP EXTENSION IF EXISTS $extension\""
$exec "psql -U postgres -c \"CREATE EXTENSION $extension\""

$exec "psql -U postgres -c \"DROP TABLE IF EXISTS test1\""
$exec "psql -U postgres -c \"DROP TABLE IF EXISTS test2\""
$exec "psql -U postgres -c \"DROP TABLE IF EXISTS test3\""
$exec "psql -U postgres -c \"CREATE TABLE test1 (first_name TEXT, last_name TEXT)\""
$exec "psql -U postgres -c \"INSERT INTO test1 VALUES ('steve', 'smith'), ('alan', 'rickman')\""
$exec "psql -U postgres -c \"CREATE TABLE test2 AS (SELECT first_name, last_name from test1)\""

$exec "psql -U postgres -c \"SELECT bind_rows('test3', 'test1', 'test2')\""
$exec "psql -U postgres -c \"SELECT * from test3\""
