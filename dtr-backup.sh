DTR_VERSION=2.7.5
UCP_USERNAME=admin
UCP_PASSWORD='password'
TIMESTAMP=`date +"%Y%m%d_%H%M%S"`
***** ALLOW ADMINISTRATORS TO SCHEDULE CONTAINERS ON SYSTEM NODES BEFORE PROCEEDING *****
sudo docker run --log-driver none --rm -i \
--name dtr-backup \
docker/dtr:${DTR_VERSION} \
backup \
--ucp-url ${UCP_URL} \
--ucp-username ${UCP_USERNAME} \
--ucp-password ${UCP_PASSWORD} \
--debug > ${TIMESTAMP}-${DTR_VERSION}-dtr-metadata-backup.tar
<Choose replica>
sudo gzip ${TIMESTAMP}-${DTR_VERSION}-dtr-metadata-backup.tar