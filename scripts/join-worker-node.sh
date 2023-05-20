#!/bin/bash

# Get the IP address of the master node from the Terraform outpu
MASTER_IP=$(terraform output master-node-ip)

# In Bash, you can remove the quotation marks from the string "192.168.1.1" using the sed command or using parameter substitution.
ip_address="\"$MASTER_IP\""
ip_address=$(echo $ip_address | sed 's/"//g')

# Retrieve the IP addresses of worker nodes
WORKER_IPS=$(terraform output worker-node-ip)

# Loop through each worker IP and execute the join command
for WORKER_IP in $WORKER_IPS; do
  # Remove the quotation marks from the worker IP address
  WORKER_IP=${WORKER_IP//\"/}
done

# Automatically accept and connect to the remote hosts even if its key is unknown
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no kroo@$ip_address
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no kroo@$WORKER_IP

# Join command for worker nodes
JOIN_COMMAND=$(ssh -i key-pair kroo@$ip_address " sudo kubeadm token create --print-join-command")
if [[ $? -eq 0 ]]; then
  echo "Join command retrieved successfully."
  echo "Executing join command: $JOIN_COMMAND"
  # Executing the join command on worker nodes to join it to the cluster
  ssh -i key-pair kroo@$WORKER_IP " sudo $JOIN_COMMAND"
else
  echo "Failed either to retrieve the join command or to execute the join command on the worker-nodes."
fi



