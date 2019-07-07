# tedelg.awk
# Original work of MK, updated for latest engine by billy
# Parses ted.elg file and output csv with valuable information
# 

BEGIN {
	OFS=";";
	#fileid_to_date[""]=0;
	#fileid_to_name[""]=0;
	#fileid_to_sha1[""]=0;
	#fileid_to_md5[""]=0;
	#fileid_by_path[""]=0;
	print "verdictid","starttime","verdicttime","filename","sha1","md5","verdict","image","reason","url","src_ip","dst_ip","dst_port","to","from","subject";

}

/Handling new file/ {
	match($0, /^\[(.+)\]\[(.+)\] \[TE_TRACE\]\: {(.+)} Handling new file \"(.+)\", Path: ([^,]+)/, res);
	#print "new:", res[1], res[2], res[3], res[4];
	# 2 date
	# 3 fileid
	# 4 filename
	# 5 path
	# store by fileid
	fileid_to_date[res[3]] = res[2];
	fileid_to_name[res[3]] = res[4];
	fileid_by_path[res[5]] = res[3];
	path_by_fileid[res[3]] = res[5];
	#print "path", res[5];
}

/verdict '/ {
	match($0, /^\[(.+)\]\[(.+)\] \[TE_TRACE\]\: {(.+)} verdict '(.+)' set for image: '(.+)' \((.+)\) by: (.+), reason: (.*)$/, res);
	#print "verdict:", res[1], res[2], res[3], res[4], res[5], res[6], res[7], res[8];
	# 2 date
	# 3 fileid
	# 4 verdict
	# 5 imageid
	# 6 imagename
	# 8 reason
	
	# verdictid = fileid_imageid
	# starttime
	# verdicttime
	# filename
	# sha1
	# md5
	# verdict
	# imagename
	# reason
	# url
	
	path = path_by_fileid[res[3]];
	#print "path", path;
	#for (key in meta_by_path) { print key,meta_by_path[key]; }
	url = meta_by_path[path "/url"];
	src_ip = meta_by_path[path "/src_ip"];
	dst_ip = meta_by_path[path "/dst_ip"];
	dst_port = meta_by_path[path "/dst_port"];
	to = meta_by_path[path "/to"];
	from = meta_by_path[path "/from"];
	subject = meta_by_path[path "/subject"];
	print res[3] "_" res[5], fileid_to_date[res[3]], res[2], fileid_to_name[res[3]], fileid_to_sha1[res[3]], fileid_to_md5[res[3]], res[4], res[6], res[8], url, src_ip, dst_ip, dst_port, to, from, subject;
}

/sha1/ {
	match($0, /^\[(.+)\]\[(.+)\] \[TE_TRACE\]\: {(.+)} Hashes\: md5\=(.+), sha1\=(.+)/, res);
	# 2 date
	# 3 fileid
	# 4 md5
	# 5 sha1
	fileid_to_sha1[res[3]] = res[5];
	fileid_to_md5[res[3]] = res[4];
}

/^\[ (.+)\]\[(.+)\] te_is::SocketApiServer::HandleDataEvent: got on conn_id: / {
	#print "connection metadata";
	
	delete meta;
	while (getline > 0) {
		#print $0;
		if (substr($0, 0, 1) == ")") {
			for (key in meta) { 
				#print key, meta[key]; 
				meta_by_path[meta["file_path"] "/" key] = meta[key];
			}
			break;
		}
		if (match($0, /:url \((.*)\)/, res)) {
			meta["url"]=res[1];
		} else if (match($0, /:src_ip \((.*)\)/, res)) {
			meta["src_ip"]=res[1];
		} else if (match($0, /:dst_ip \((.*)\)/, res)) {
			meta["dst_ip"]=res[1];
		} else if (match($0, /:dst_port \((.*)\)/, res)) {
			meta["dst_port"]=res[1];
		} else if (match($0, /:to \((.*)\)/, res)) {
			meta["to"]=res[1];
		} else if (match($0, /:from \((.*)\)/, res)) {
			meta["from"]=res[1];
		} else if (match($0, /:subject \((.*)\)/, res)) {
			meta["subject"]=res[1];
		} else if (match($0, /:file_path \(\"(.*)\"\)/, res)) {
			meta["file_path"]=res[1];
		}
	}
}
