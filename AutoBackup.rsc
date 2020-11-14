:local toemail "laspavel@gmail.com"

:local sysname [/system identity get name]
:local textfilename
:local backupfilename
:local time [/system clock get time]
:local date [/system clock get date]
:local uptime [/system resource get uptime]
:local logMessages
:local newdate "";
:for i from=0 to=([:len $date]-1) do={ :local tmp [:pick $date $i];
:if ($tmp !="/") do={ :set newdate "$newdate$tmp" }
:if ($tmp ="/") do={}
}
#check for spaces in system identity to replace with underscores
:if ([:find $sysname " "] !=0) do={
:local name $sysname;
:local newname "";
:for i from=0 to=([:len $name]-1) do={ :local tmp [:pick $name $i];
:if ($tmp !=" ") do={ :set newname "$newname$tmp" }
:if ($tmp =" ") do={ :set newname "$newname_" }
}
:set sysname $newname;
}
:set logMessages ""
:foreach i in=[/log find ] do={ 
:set logMessages ($logMessages. [/log get $i time ]. " "); 
:set logMessages ($logMessages. [/log get $i message ]); 
:set logMessages ($logMessages. "\n")
}
:set textfilename ($"newdate" . "-" . $"sysname" . ".rsc")
:set backupfilename ($"newdate" . "-" . $"sysname" . ".backup")
:execute [/export file=$"textfilename"]
:execute [/system backup save name=$"backupfilename"]
#Allow time for export to complete
:delay 2s
 
#email copies
:log info "Emailing backups"
/tool e-mail send to=$"toemail" subject="[HomeMikrotik Config Backup RSC] $sysname $time $date" file=$"textfilename" body="[Config Backup LOG] $logMessages"
:local time [/system clock get time]
/tool e-mail send to=$"toemail" subject="[HomeMikrotik Config Backup BAK] $sysname $time $date" file=$"backupfilename" body="[Config Backup Uptime:] $uptime"
#Allow time to send
:delay 10s
 
#delete copies
/file remove $textfilename
/file remove $backupfilename