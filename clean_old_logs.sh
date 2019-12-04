#!/bin/sh
# Clean old logfiles by billy
# R80.30 based no confirmation

rm -f /var/log/opt/CPsuite-R80.30/fw1/log/failed_tasks/*
rm -f /var/log/opt/CPsuite-R80.30/fw1/log/failed_tasks/Other/*
rm -f /var/log/opt/CPsuite-R80.30/fw1/log/failed_tasks/Policy_Installation/*
rm -f /var/log/opt/CPsuite-R80.30/fw1/log/sduu-2019*

# SOLR / CPSEAD / SMARTVIEW
rm -f /var/log/opt/CPrt-R80.30/log/solr.log.??
rm -f /var/log/opt/CPrt-R80.30/log/solr.log.?
rm -f /var/log/opt/CPrt-R80.30/log/cpsead.elg.?
rm -f  /var/log/opt/CPrt-R80.30/log/smartview-service.log.?
rm -f /var/log/opt/CPrt-R80.30/log/smartview-service.log.??

# LOG INDEXER
rm -f /var/log/opt/CPrt-R80.30/log_indexer/log/log_indexer.elg.?

# CPM
rm -f  /var/log/opt/CPsuite-R80.30/fw1/log/cpm.elg.??
rm -f  /var/log/opt/CPsuite-R80.30/fw1/log/cpm.elg.?

# FWD
rm -f  /var/log/opt/CPsuite-R80.30/fw1/log/fwd.elg.?

# cores
rm -f  /var/log/dump/usermode/*
rm -f /home/admin/last_dump.log

# Delete indexes after 30 days
find /var/log/opt/CPrt-R80.30/log_indexes/other* -type d -ctime +30 -exec rm -rf {} \;
find /var/log/opt/CPrt-R80.30/log_indexes/audit* -type d -ctime +30 -exec rm -rf {} \;
find /var/log/opt/CPrt-R80.30/log_indexes/smartevent* -type d -ctime +30 -exec rm -rf {} \;

# messages/wtmp just a small gain 1MB
#rm /var/log/messages.?
#rm /var/log/wtmp.?
#rm /var/log/secure.?
