os-payins-create-index:
	rake opensearch:payins:create_index

os-payins-delete-index:
	rake opensearch:payins:delete_index

os-payins-export-for-searchkick:
	rake opensearch:payins:export_for_searchkick

os-payins-export-for-elasticdump:
	rake opensearch:payins:export_for_searchdump

os-payins-import-via-searchkick:
	rake opensearch:payins:import_via_searchkick

os-payins-import-via-elasticdump:
	elasticdump \
		--limit 6412 \
		--concurrency ${ELASTICDUMP_CONCURRENCY} \
		--input=/tmp/payins.data.json \
		--output=${OPENSEARCH_URL}/payins_production

os-indices:
	curl -XGET ${OPENSEARCH_URL}/_cat/indices

os-total-count:
	rails runner "puts Payin.search(body_options: {track_total_hits: true}).total_count"
	