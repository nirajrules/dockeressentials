#schedule the scan_check_all job via cron an hour after CVE database gets updated

curl -u admin:password -X POST "https://dtr.example.com/api/v0/crons" -H "accept: application/json" -H "content-type: application/json" -d "{ \"action\": \"scan_check_all\", \"capacityMap\": { \"scanCheck\": 1 }, \"deadline\": \"\", \"parameters\": { \"CHECK_OPTION\": \"true\", \"SCAN_OPTION\": \"false\" }, \"retries\": 0, \"schedule\": \"0 3 15 * * *\", \"stopTimeout\": \"5s\"}"