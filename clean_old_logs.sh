#!/bin/sh
# Clean old logfiles by billy
# R80.x based no confirmation

source /etc/profile.d/CP.sh

rm -f $FWDIR/log/failed_tasks/*
rm -f $FWDIR/log/failed_tasks/Other/*
rm -f $FWDIR/log/failed_tasks/Policy_Installation/*
rm -f $FWDIR/log/sduu-2019*
rm -f $FWDIR/log/sduu-2020*
rm -f $FWDIR/log/te_file_downloader.elg.?
rm -f $FWDIR/log/api.elg.?
rm -f $FWDIR/log/lpd.elg.?

# R81
rm -f $FWDIR/log/vmware-vmsvc.?.log
rm -f $FWDIR/log/gaia_api_server.log.?

# SOLR / CPSEAD / SMARTVIEW
rm -f $RTDIR/log/solr.log.??
rm -f $RTDIR/log/solr.log.?
rm -f $RTDIR/log/cpsead.elg.?
rm -f $RTDIR/log/smartview-service.log.?
rm -f $RTDIR/log/smartview-service.log.??
rm -f $RTDIR/log/run_maintenance.elg.?
rm -f $RTDIR/log/rfl_maintenance.elg.?

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

rm /var/log/gaia_api_server.log.?

# messages/wtmp just a small gain 1MB
#rm /var/log/messages.?
#rm /var/log/wtmp.?
#rm /var/log/secure.?
echo "Done"
