CONTENTS = hook.xml infos.json install.php LICENSE README.md agent/o365-16-user.vbs apache/Map.pm apache/o36516user.conf cd_o36516user/cd_o36516user.php

dist: o36516user.zip

o36516user.zip: $(CONTENTS)
	mkdir o36516user
	cp -t o36516user $^
	zip $@ o36516user
	rm -R o36516user
