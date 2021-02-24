#!/usr/bin/perl
package Apache::Ocsinventory::Plugins::o36516users::Map;
 
use strict;
use warnings;
 
use Apache::Ocsinventory::Map;

$DATA_MAP{o36516users} = {
		mask => 0,
		multi => 1,
		auto => 1,
		delOnReplace => 1,
		sortBy => 'EMAIL',
		writeDiff => 0,
		cache => 0,
		fields => {
                SID => {},
                GUID => {},
                EMAIL => {},
                NAME => {},
                LASTLOGIN => {}
	}
};
1;

