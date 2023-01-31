#!/bin/bash

ClusterStatus=""

# Check Cluster Creation
ClusterCreated="false"
while [[ $ClusterCreated == "false" ]]; do
    ClusterStatus="$(curl --silent -i -u "$atlas_public_key:$atlas_private_key" --digest https://cloud.mongodb.com/api/atlas/v1.0/groups/$ATLAS_PROJECT_ID/clusters/$atlas_cluster_name?pretty=true)"
    echo "ClusterStatus:$ClusterStatus"
    # Check Cluster State - expected is not CLUSTER_NOT_FOUND
    if [ $(echo $ClusterStatus | grep -c "HTTP/2 200") != 0 ]; then
        ClusterCreated="true"
        echo "\033[32mCluster : $atlas_cluster_name has been successfully created\033[0m"
        break
    else
        echo "Sleeping for 1m, and retrying.."
        sleep 1m
        ClusterCreated="false"
        continue
    fi
done

# Get Cluster Values
cluster_response="$(curl --silent -u "$atlas_public_key:$atlas_private_key" --digest -X GET https://cloud.mongodb.com/api/atlas/v1.0/groups/$ATLAS_PROJECT_ID/clusters/$atlas_cluster_name)"
# echo "$cluster_response"
host="$(echo "$cluster_response" | jq -r ".connectionStrings.standardSrv" | cut -f 3 -d "/")"
# echo "Host: $host"
mongodb_conn_string="mongodb+srv://$atlas_dbuser:$atlas_dbpassword@$host"
# echo "Connection String: $mongodb_conn_string"

# if [[ (-z $mongodb_conn_string) || (-z $host) || (-z $atlas_dbuser) || (-z $atlas_dbpassword)]]; then
#         echo "Either any parameter is empty. Exiting.."
#         exit 1
# else
#     echo "Parameters not found, exiting"
#     exit 1
# fi

# Get template Secret & Create Secret
SecretStringJson="$(aws secretsmanager get-secret-value \
    --secret-id "mongodb-credentials-template" \
    --query "SecretString" \
    --output text)"
# echo "secretStringValue = $SecretStringJson"
if [[ -n "$SecretStringJson" ]]; then
    # echo "$SecretStringJson"
    SecretStringValue="$(echo "$SecretStringJson" | jq '.database = "'$atlas_cluster_name'"' | jq '.mongodb_conn_string = "'$mongodb_conn_string'"' | jq '.username = "'$atlas_dbuser'"' | jq '.password = "'$atlas_dbpassword'"' | jq '.host = "'$host'"' | tr -d "\n")"
    # echo "$SecretStringValue"
    instance_name="$(echo "$atlas_cluster_name" | cut -f 2-3 -d "-" | tr -d "\n")"
    secretName="wo/all-components/$instance_name/mongodb-credentials"

    aws secretsmanager create-secret --name "$secretName" --secret-string "$SecretStringValue"
    echo "\033[32mSecret : $secretName has been successfully created\033[0m"

else
    echo "Couldn't get Secret String"
    exit 1
fi
