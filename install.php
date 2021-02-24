<?php
function extension_install_o36516user() {

   $commonObject=new ExtensionCommon;
   $commonObject->sqlQuery("CREATE TABLE IF NOT EXISTS `o36516user` (
                              `ID` INT(11) NOT NULL AUTO_INCREMENT,
                              `HARDWARE_ID` INT(11) NOT NULL,
                              `SID` VARCHAR(65) NULL,
                              `GUID` VARCHAR(65) NULL,
                              `EMAIL` VARCHAR(255) null,
                              `NAME` VARCHAR(255) NULL,
                              `LASTLOGIN` DATETIME  NULL,
                              PRIMARY KEY  (`ID`,`HARDWARE_ID`)
                              ) ENGINE=INNODB;");

}

function extension_delete_o36516user()
{
    $commonObject=new ExtensionCommon;
    $commonObject->sqlQuery("DROP TABLE `o36516user`");
}


?>