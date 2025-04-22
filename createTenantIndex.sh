#Note: Update the file path as per your local path

SOURCE_PATH="/home/madhav/repo/dataplatform/dataplatform-solution"
# create the elastic indices
echo "Creating indices"
echo
indice_scripts=$(jq --raw-output '.indices[] | .name + "#" + .mapping + "#" + .read_alias + "#" + .write_alias' $SOURCE_PATH/platformsvc-utility/src/main/resources/tenantsearchindicesconfig.json)
indice_scripts=$(sed "s| |;|g" <<< $indice_scripts)
indice_scripts=$(sed "s|@@TENANT_ID@@|t1|g" <<< $indice_scripts)

element=(${indice_scripts//;/ })
for i in "${!element[@]}"; do
    array=(${element[i]//#/ }) #index, readindex,writeindex, mapping
    curl -XPUT localhost:9200/${array[0]} -H 'Content-Type: application/json' -d "@$SOURCE_PATH/platformsvc-utility/src/main/resources/mappings/consolidated_dataobject_mapping.json"
 curl -XPOST 'http://localhost:9200/_aliases?pretty' -H 'Content-Type: application/json'  -d "
  {
    \"actions\" : [
        { \"add\" : { \"index\" : \"${array[0]}\", \"alias\" : \"${array[2]}\" } }
    ]
  }"
  echo

 curl -XPOST 'http://localhost:9200/_aliases?pretty' -H 'Content-Type: application/json'  -d "
  {
    \"actions\" : [
        { \"add\" : { \"index\" : \"${array[0]}\", \"alias\" : \"${array[3]}\" } }
    ]
  }"
done
