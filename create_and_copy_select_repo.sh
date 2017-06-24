sh /home/jonas.kemper/MA-Scripts/extract_udf_cards.sh /home/jonas.kemper/.rheem/executions.json > /home/jonas.kemper/MA-Scripts/extracted_udf_cards.txt && python /home/jonas.kemper/MA-Scripts/generate_select_repo.py > /home/jonas.kemper/MA-Scripts/select_repo.txt

cat /home/jonas.kemper/MA-Scripts/select_repo.txt >> /home/jonas.kemper/MA-Scripts/benchmark-tenem.properties
