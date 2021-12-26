:do {
  :local toemail "laspavel@gmail.com"

  :local sysname [/system identity get name]
  :local textfilename
  :local backupfilename
  :local time [/system clock get time]
  :local date [/system clock get date]
  :local uptime [/system resource get uptime]
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
  :set textfilename ($"newdate" . "-" . $"sysname" . ".rsc")
  :set backupfilename ($"newdate" . "-" . $"sysname" . ".backup")
  :execute [/export file=$"textfilename"]
  :execute [/system backup save name=$"backupfilename"]

  #Allow time for export to complete
  :delay 2s
 
  #email copies
  :log info "Emailing backups"
  :local time [/system clock get time]
  /tool e-mail send to=$"toemail" subject="[$sysname Config Backup] $time $date" file=($"backupfilename",$"textfilename") body="Uptime: $uptime"

  #Allow time to send
  :delay 10s
 
  # delete copies
  /file remove $textfilename
  /file remove $backupfilename

} on-error={
    /log error "***** AUTOBACKUP script finished with error ******"
}



