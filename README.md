# ocs-office365-16-user
OCS Inventory plugin for getting the O365 user from a host Windows PC

This is a OCS plugin to fetch the name and information of the Office
365 users that have software deployment in a Windows Host. In a common
scenario, this would allow to tell which O365 user is operating
on which computer.

The fields exposed by the plugin are as follows:

   -SID is the local userid à la WMIC.
   -GUID is the Office 365 ObjectId. It's the same valued used on Powershell's
    Get-AzureADUser
   -Email is the O365 user's email address
   -LastLogin is the last time an LDAP authentication ocurred with O365

INSTALLATION

In order to sort-of-automate the plugin installation in your OCS server
you are supposed to have a full set of artifacts. What worked for me was:

   1. Unzip the contents under your extensions folder. In might be
      /usr/share/ocsinventory-reports/ocsreports/extensions/
   2. Open your OCS reports web site under Extensions Manager. The plugin
      should be available for install. Click the "Install Button".
   3. At this point, there should be a o36516user table created in your
      OCS database.
   4. Copy the apache/o36516user.conf to your OCS configuration folder. It might
      be /etc/ocsinventory-server/plugins.
   5. Create the folders and copy the apache/Map.pm file to /etc/ocsinventory-server/perl/Apache/Ocsinventory/Plugins/o36516user/Map.pm.
   6. Be sure to give ownership on these files to the apache service user.
   7. You can now restart/reload your web server. At this point, the OCS server is
      able to collect the data. Please note that any addition of a perl module like this
      component might be a webserver start breaker. Double check the file locations and
      permissions. Removing the o36516user.conf is your escape plan here.
   8. Create the folder cd_o36516user to your ocs section. It might be
      /usr/share/ocsinventory-reports/ocsreports/plugins/computer_detail.
   9. Edit your plugins report catalog and add the cd_o36516user section.
      The file might be /usr/share/ocsinventory-reports/ocsreports/config/computer/plugins.xml
      Add the following tag:
      <plugin id="cd_o36516user">
         <label>Office 365 16.0 user</label>
         <system>1</system>
         <category>other</category>
         <available>o36516user</available>
      </plugin>
   10. Make sure to set ownership or access on these files to the apache service user.
   11. At this point, the reporting web page should be able to show the data.
   12. Deploy the agent/o36516user.vbs to the target hosts computers.
   13. At this point, the ocs server should start populating with the data.



