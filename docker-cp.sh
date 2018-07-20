# Script to copy files into a Postgres Docker container, and `make install`` them
extension="rpg"
container="pg"

docker container cp ../${extension} ${container}:/root
docker container exec $container sh -c "cd /root/${extension} && make install"
