# s3-sync
Docker image, který spouští jednoducho úlohu cron synchronizující soubory 
s AWS S3 podle definice v systémových proměnných.

Obraz může být použit jak pro sychchronizaci do S3, tak i z S3 do kontejneru.

Předpokládá se, že __jedna__ instance tohoto obrazu spustí __jednu__ úlohu cron 
a proces synchronizace. Pokud máte více adresářů k synchronizaci, 
měli byste spustit více kontejnerů, každý s příslušnou konfigurací pro daný 
adresář.


## Docker Hub
Obraz je postaven automaticky na Docker Hubu jako [sysnetcz/s3-sync](https://hub.docker.com/r/sysnetcz/s3-sync/)

## Lokální spuštění
1. Naklonujte tento repozitář 
2. zkopírujte  ```template.env``` do ```.env``` a aktualizujte hodnoty podle potřeby 
3. Spusťte ```docker-compose up -d```

## Lokální sestavení
1. Naklonujte tento repozitář 
2. Spusťte ```docker build -t sysnetcz/aws-s3-sync .```


## Očekávané systémové proměnné
1. ```ACCESS_KEY``` - AWS Access Key
2. ```SECRET_KEY``` - AWS Secret Access Key
3. ```CRON_SCHEDULE``` - Spouštění jobu cron. Každé dvě hodiny 15 minut po celé: ```15 */2 * * *```
4. ```SOURCE_PATH``` - Zdrojové soubory, které mají být synchronizovány. Například: ```/files```
5. ```DESTINATION_PATH``` - Cíl, kam budou soubory synchronizovány. Například: ```s3://my-bucket/files```
6. ```BUCKET_LOCATION``` - AWS Region for bucket, ex: ```eu-west-1```
7. ```LOGENTRIES_KEY``` - (optional) If provided, the image will send command output to syslog with priority ```user.info```.
8. ```S3SYNC_ARGS``` - (optional) If provided, the arguments will be included in the ```aws s3 sync``` command. For example, setting ```S3SYNC_ARGS=--delete``` will cause files in the destination to be deleted if they no longer exist in the source.

## Volumes
Budete muset v konfiguraci Dockeru definovat svazky pro sdílení 
souborového systému mezi aplikačními kontejnery a tímto 
synchronizačním kontejnerem.
