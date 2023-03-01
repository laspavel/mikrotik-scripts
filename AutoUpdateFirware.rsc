# https://www.urlencoder.org/
:do {
    :local DeviceName [/system identity get name];
    :local versioninfo [/system package update check-for-updates as-value]
    :if (($versioninfo->"installed-version") != ($versioninfo->"latest-version")) do={
        /log info ("Installing new firmware version on $DeviceName: ". ($versioninfo->"latest-version"))
       :local MessageText ("*AutoUpdate%20$DeviceName%3A*%20Upgrade%20firmware%20from%20". ($versioninfo->"installed-version")."%20to%20". ($versioninfo->"latest-version"));
       :local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
        $SendTelegramMessage MessageText=$MessageText;

        /system package update download

        :delay 5s
        /system reboot
    }
   /log info ("Installed firmware version: " .($versioninfo->"installed-version"))

} on-error={
    /log error "***** AUTOUPDATE script finished with error ******"
}
