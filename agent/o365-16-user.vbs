'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script :		Retrieve Office 365 16.0 user info
' Version :		0.10
' Date :		24/02/2021
' Author :		Erich Strewlow
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'	Windows 10	[X]	[X]
' ---------------------------------------------------------
Option Explicit


Const HKEY_USERS = 2147483651

Dim aUsers()
Dim registryObject 
Dim conn
Dim r
Dim k
Dim sid
Dim email
Dim ident
Dim name
Dim lastlogin
Dim d
Dim IsoDate
Dim IsoTime

Set registryObject = GetObject("winmgmts:root\default:StdRegProv")

'If OCS agent is started as a service, it knows the local users configuration only
'through HKEY_USERS. We scan all the registered users in the host, listing
'everyone with an Office 16.0 setup
r=registryObject.EnumKey(HKEY_USERS,"",aUsers)

If r <> 0 Then
   wscript.quit
End If

For k = lbound(aUsers) To UBound(aUsers)
   
   sid=aUsers(k)

   'The SID_Classes keys are skipped
   If InStr(1,sid,"_Classes",vbTextCompare )=0 Then
      r=registryObject.GetStringValue (HKEY_USERS,sid & "\Software\Microsoft\Office\16.0\Common\Identity","ConnectedAccountWamAad",conn)
      If r = 0 Then
         ident=sid & "\Software\Microsoft\Office\16.0\Common\Identity\Identities\" & conn & "_ADAL"
         r=registryObject.GetStringValue (HKEY_USERS,ident,"EmailAddress",email)
		 r=registryObject.GetStringValue (HKEY_USERS,ident,"FriendlyName",name)
		 r=registryObject.GetQWORDValue (HKEY_USERS,ident & "\AuthHistory","LastLoginTime",lastlogin)

		 'LastLoginTime is an LDAP timstamp. Some conversions are required. There's a CIM
		 'helper class for that
         Set d = CreateObject("WbemScripting.SWbemDateTime")
         d.SetFileTime lastlogin,False 
         IsoDate=d.Year & "-" & Right("00" & d.Month,2) & "-"  & Right("00" & d.Day,2)
		 IsoTime=Right("00" & d.hours,2) & ":" & Right("00" & d.minutes,2) & ":" & Right("00" & d.seconds,2)

		 wscript.echo "<O36516USER>" &  VbCrLf &_
		    "<SID>" & sid & "</SID>" & VbCrLf &_
		    "<GUID>" & conn & "</GUID>" & VbCrLf &_
		    "<EMAIL>" & email & "</EMAIL>" & VbCrLf &_
		    "<NAME>" & name & "</NAME>" & VbCrLf &_
		    "<LASTLOGIN>" & IsoDate & "T" & IsoTime & "Z" & "</LASTLOGIN>" & VbCrLf &_
            "</O36516USER>"
      End if
   End if
Next

