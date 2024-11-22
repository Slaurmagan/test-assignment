os-payins-create-index-local:
	docker-compose run --rm app rake opensearch:payins:create_index

os-payins-delete-index-local:
	docker-compose run --rm app rake opensearch:payins:delete_index

os-payins-export-for-searchkick-local:
	docker-compose run --rm app rake opensearch:payins:export_for_searchkick

os-payins-export-for-elasticdump-local:
	docker-compose run --rm app rake opensearch:payins:export_for_searchdump

os-payins-import-via-searchkick-local:
	docker-compose run --rm app rake opensearch:payins:import_via_searchkick

os-payins-import-via-elasticdump-local:
	elasticdump \
		--limit 10000 \
		--concurrency 8 \
		--input=/home/ted/work/paycos/code/services/dfpay/.tmp/payins.data.json \
		--output=http://localhost:9200/payins_development

os-indices-local:
	curl -XGET http://localhost:9200/_cat/indices

os-total-count-local:
	docker-compose run --rm app rails runner "puts Payin.search(body_options: {track_total_hits: true}).total_count"
