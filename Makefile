CONTENTS = hook.xml infos.json install.php LICENSE README.md agent/o36516user.vbs apache/Map.pm apache/o36516user.conf cd_o36516user/cd_o36516user.php

dist: o36516user.zip

o36516user.zip: $(CONTENTS)
	mkdir o36516user
	mkdir o36516user\agent
	mkdir o36516user\apache
	mkdir o36516user\cd_o36516user
	cp --parents $^ o36516user
	zip -r $@ o36516user
	rm -R o36516user
