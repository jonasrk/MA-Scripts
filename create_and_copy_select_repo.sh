sh /home/jonas.kemper/MA-Scripts/extract_udf_cards.sh $2 > /home/jonas.kemper/MA-Scripts/extracted_udf_cards.txt && python3 /home/jonas.kemper/MA-Scripts/$3.py /home/jonas.kemper/MA-Scripts/extracted_udf_cards.txt > /home/jonas.kemper/MA-Scripts/select_repo.txt

cat /home/jonas.kemper/MA-Scripts/select_repo.txt >> /home/jonas.kemper/MA-Scripts/$1
