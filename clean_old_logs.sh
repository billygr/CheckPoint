#!/bin/sh
# Clean old logfiles by billy
# R80.30 based no confirmation

rm /var/log/opt/CPsuite-R80.30/fw1/log/failed_tasks/*
rm /var/log/opt/CPsuite-R80.30/fw1/log/failed_tasks/Other/*
rm /var/log/opt/CPsuite-R80.30/fw1/log/failed_tasks/Policy_Installation/*
rm /var/log/opt/CPsuite-R80.30/fw1/log/sduu-2019*

# SOLR / CPSEAD / SMARTVIEW
rm /var/log/opt/CPrt-R80.30/log/solr.log.??
rm /var/log/opt/CPrt-R80.30/log/solr.log.?
rm /var/log/opt/CPrt-R80.30/log/cpsead.elg.?
rm /var/log/opt/CPrt-R80.30/log/smartview-service.log.?
rm /var/log/opt/CPrt-R80.30/log/smartview-service.log.??


# LOG INDEXER
rm /var/log/opt/CPrt-R80.30/log_indexer/log/log_indexer.elg.?

# CPM
rm /var/log/opt/CPsuite-R80.30/fw1/log/cpm.elg.??
rm /var/log/opt/CPsuite-R80.30/fw1/log/cpm.elg.?

# FWD
rm /var/log/opt/CPsuite-R80.30/fw1/log/fwd.elg.?

# cores
rm /var/log/dump/usermode/*
rm /home/admin/last_dump.log

# messages/wtmp just a small gain 1MB
#rm /var/log/messages.?
#rm /var/log/wtmp.?
#rm /var/log/secure.?
