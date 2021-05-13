#!/bin/sh
# Clean old logfiles by billy
# R80.x based no confirmation

source /etc/profile.d/CP.sh

rm -f $FWDIR/log/failed_tasks/*
rm -f $FWDIR/log/failed_tasks/Other/*
rm -f $FWDIR/log/failed_tasks/Policy_Installation/*
rm -f $FWDIR/log/sduu-2019*

# SOLR / CPSEAD / SMARTVIEW
rm -f $RTDIR/log/solr.log.??
rm -f $RTDIR/log/solr.log.?
rm -f $RTDIR/log/cpsead.elg.?
rm -f $RTDIR/log/smartview-service.log.?
rm -f $RTDIR/log/smartview-service.log.??

# LOG INDEXER
rm -f $RTDIR/log_indexer/log/log_indexer.elg.?

# CPM
rm -f $FWDIR/log/cpm.elg.??
rm -f $FWDIR/log/cpm.elg.?

# FWD
rm -f $FWDIR/log/fwd.elg.?

# cores
rm -f /var/log/dump/usermode/*
rm -f /home/admin/last_dump.log

# Delete indexes after 30 days
find $RTDIR/log_indexes/other* -type d -ctime +30 -exec rm -rf {} \;
find $RTDIR/log_indexes/audit* -type d -ctime +30 -exec rm -rf {} \;
find $RTDIR/log_indexes/smartevent* -type d -ctime +30 -exec rm -rf {} \;

# messages/wtmp just a small gain 1MB
#rm /var/log/messages.?
#rm /var/log/wtmp.?
#rm /var/log/secure.?
echo "Done"
