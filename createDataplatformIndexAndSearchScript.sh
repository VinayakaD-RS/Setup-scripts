#!/bin/bash
set -x

SOURCE_PATH="/home/madhav/repo/dataplatform/dataplatform-solution"
#Note: Update the file path as per your local path

CURRENT_DIR=`dirname $0`

cp $SOURCE_PATH/platformsvc-utility/src/main/resources/mappings/consolidated_dataobject_mapping.json $CURRENT_DIR/
cp $SOURCE_PATH/platformsvc-utility/src/main/resources/mappings/search_template.json $CURRENT_DIR/
cp $SOURCE_PATH/platformsvc-utility/src/main/resources/mappings/partial_update_script.json $CURRENT_DIR/

MAPPING_FILE=$CURRENT_DIR/consolidated_dataobject_mapping.json
# Update replacement parameters.
sed -i s/@@ELASTIC_CASE_SENSITIVE@@/\"lowercase\"/ ${MAPPING_FILE}
sed -i s/@@CONTEXT_DELIMITER@@/\>\>/ ${MAPPING_FILE}
sed -i s/@@ELASTIC_REPLICA_COUNT@@/0/ ${MAPPING_FILE}
sed -i s/@@ELASTIC_SHARD_COUNT@@/1/ ${MAPPING_FILE}

curl -XPUT 'localhost:9200/dataplatform_index_v9?pretty' -H "Content-Type: application/json" --data-binary "@$CURRENT_DIR/consolidated_dataobject_mapping.json"
curl -XPOST 'http://localhost:9200/_aliases?pretty' -H "Content-Type: application/json" -d '
  {
    "actions" : [
        { "add" : { "index" : "dataplatform_index_v9", "alias" : "dataplatformreadindex" } }
    ]
  }'
curl -XPOST 'http://localhost:9200/_aliases?pretty' -H "Content-Type: application/json" -d '
  {
    "actions" : [
        { "add" : { "index" : "dataplatform_index_v9", "alias" : "dataplatformwriteindex" } }

  ]
  }'

curl -XPUT 'localhost:9200/dataplatform_requestobjectindex_v9?pretty' -H "Content-Type: application/json" --data-binary "@$CURRENT_DIR/consolidated_dataobject_mapping.json"
curl -XPOST 'http://localhost:9200/_aliases?pretty' -H "Content-Type: application/json" -d '
  {
    "actions" : [
        { "add" : { "index" : "dataplatform_requestobjectindex_v9", "alias" : "dataplatformrequestobjectreadindex" } }
    ]
  }'
curl -XPOST 'http://localhost:9200/_aliases?pretty' -H "Content-Type: application/json" -d '
  {
    "actions" : [
        { "add" : { "index" : "dataplatform_requestobjectindex_v9", "alias" : "dataplatformrequestobjectwriteindex" } }

  ]
  }'

curl -XPUT 'localhost:9200/dataplatform_eventindex_v9?pretty' -H "Content-Type: application/json" --data-binary "@$CURRENT_DIR/consolidated_dataobject_mapping.json"
curl -XPOST 'http://localhost:9200/_aliases?pretty' -H "Content-Type: application/json" -d '
  {
    "actions" : [
        { "add" : { "index" : "dataplatform_eventindex_v9", "alias" : "dataplatformeventreadindex" } }
    ]
  }'
curl -XPOST 'http://localhost:9200/_aliases?pretty' -H "Content-Type: application/json" -d '
  {
    "actions" : [
        { "add" : { "index" : "dataplatform_eventindex_v9", "alias" : "dataplatformeventwriteindex" } }

  ]
  }'

curl -XPOST http://localhost:9200/_scripts/EntityGet -H 'Content-Type: application/json' --data-binary "@$CURRENT_DIR/search_template.json" 
curl -XPOST http://localhost:9200/_scripts/EntityUpdate -H 'Content-Type: application/json' --data-binary "@$CURRENT_DIR/partial_update_script.json"

echo $?
