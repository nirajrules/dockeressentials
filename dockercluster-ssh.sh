#!/bin/bash
if [ "$#" -eq 1 ]; then
	if [ ! -z "${CLUSTER_NAME}" ]; then
		HOST_NAME=$1
	else
		echo "CLUSTER_NAME must be set or the cluster name must passed as the first argument"
		exit -1
	fi
elif [ "$#" -eq 2 ]; then
	CLUSTER_NAME=$1
	HOST_NAME=$2
else
	echo "Cluster name and host name are required"
	exit -1
fi
DOCKER_CLUSTER_FILES_ROOT=~/.docker/cluster
CLUSTER_UUID=`docker cluster ls | grep " ${CLUSTER_NAME} " | awk '{print $1}'`
if [ "${CLUSTER_UUID}" == "" ]; then
	echo "Could not find cluster named '${CLUSTER_NAME}'"
	exit 1
fi

#Extract Cluster ID
CLUSER_FILES_ROOT=${DOCKER_CLUSTER_FILES_ROOT}/clusters/${CLUSTER_UUID}
HOST_IP=`grep ${HOST_NAME} ${CLUSER_FILES_ROOT}/inventory/1.* | awk '{print $3}' | awk -F = '{print $2}'`
if [ "${HOST_IP}" == "" ]; then
	echo "Could not find a host named '${HOST_NAME}'"
	exit 2
fi
echo "Attempting to connect to ${HOST_NAME}($HOST_IP) in cluster ${CLUSTER_NAME}(${CLUSTER_UUID})"

#SSH into specificed host with cluster cert with ec2-user (default for AWS)
ssh -o "StrictHostKeyChecking no" -i ${DOCKER_CLUSTER_FILES_ROOT}/clusters/${CLUSTER_UUID}/ssh/id_rsa ec2-user@${HOST_IP}

#samples: 
#cluster-ssh <cluster name> <host tag>
#cluster-ssh beta manager-1