#!/bin/bash

HOSTED_ZONE_ID="your-id"
RECORD_SET="yuandrk.net"
TTL=300
TYPE="A"

IP=$(curl -s http://checkip.amazonaws.com/)
echo "Current IP is $IP"

aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch '{
    "Changes": [
    {
        "Action": "UPSERT",
        "ResourceRecordSet": {
            "Name": "'$RECORD_SET'",
            "Type": "'$TYPE'",
            "TTL": '$TTL',
            "ResourceRecords": [{ "Value": "'$IP'"}]
        }
    }]
}'