# cpview queries

## Maximum concurrent connections, inbound/outbound throughput 
```bash
sqlite3 -header CPViewDB.dat \
"select  datetime(timestamp, 'unixepoch', 'localtime') as dates , MAX(concurrent_conns) from fw_counters;" \
"select  datetime(timestamp, 'unixepoch', 'localtime') as dates , MAX(inbound_throughput/1024/1024) from fw_counters;" \
"select  datetime(timestamp, 'unixepoch', 'localtime') as dates , MAX(outbound_throughput/1024/1024), from fw_counters;"
```

## TOP loaded CPUs
```bash
sqlite3 -header CPViewDB.dat \
'select name_of_cpu, cpu_usage from UM_STAT_UM_CPU_UM_CPU_ORDERED_TABLE order by cpu_usage desc limit 10;'
```
