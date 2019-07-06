# cpview queries

## Maximum concurrent connections, inbound/outbound throughput 

sqlite3 -header CPViewDB.dat \
"select  datetime(timestamp, 'unixepoch', 'localtime') as dates , MAX(concurrent_conns) from fw_counters;" \
"select  datetime(timestamp, 'unixepoch', 'localtime') as dates , MAX(inbound_throughput/1024/1024) from fw_counters;" \
"select  datetime(timestamp, 'unixepoch', 'localtime') as dates , MAX(outbound_throughput/1024/1024), from fw_counters;"
