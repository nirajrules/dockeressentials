TIMESTAMP=`date +"%Y%m%d_%H%M%S"`
UCP_VERSION=3.2.5
docker container run --log-driver none --rm -i \
--name ucp-backup \
-v /var/run/docker.sock:/var/run/docker.sock \
docker/ucp:${UCP_VERSION} \
backup \
--no-passphrase \
--debug > ${TIMESTAMP}-${UCP_VERSION}-ucp-backup.tar && gzip ${TIMESTAMP}-${UCP_VERSION}-ucp-backup.tar