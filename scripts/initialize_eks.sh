#!/bin/bash

while getopts c:n:p:d:s: flag
do
	case "${flag}" in
		c) cluster_conf=${OPTARG};;
		n) namespace=${OPTARG};;
		p) profile=${OPTARG};;
		d) deployment_conf=${OPTARG};;
		s) service_conf=${OPTARG};;
	esac
done

if [ -z "$cluster_conf" ] || [ -z "$namespace" ] || [ -z "$deployment_conf" ] || [ -z "$service_conf" ]
then 
	echo "Missing arguments"
	echo "Usage:"
	echo "initialize_eks.sh -c [cluster_conf] -n [namespace] -d [deployment_conf] -s [service_conf]"
	exit
fi


echo "Creating cluster with configuration ${cluster_conf}"
if [ -z "$profile" ]
then
	eksctl create cluster -f ${cluster_conf}
else
	eksctl create cluster -f ${cluster_conf} --profile ${profile}
fi

echo ""
echo "Creating namespace ${namespace}"
kubectl create namespace ${namespace}

echo ""
echo "Creating deployment with configuration ${deployment_conf}"
kubectl apply -f ${deployment_conf}

echo ""
echo "Creating service with configuration ${service_conf}"
kubectl apply -f ${service_conf}

echo "EKS cluster created successfully and application deployed"
