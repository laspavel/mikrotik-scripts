:do {
    :local DeviceName [/system identity get name];
    :local versioninfo [/system package update check-for-updates as-value]
    :if (($versioninfo->"installed-version") != ($versioninfo->"latest-version")) do={
        /log info ("Found new firmware version " . ($versioninfo->"latest-version") . " installing now!")

       :local MessageText ("<b>AutoUpdate $DeviceName:</b> Found new firmware version ". ($versioninfo->"latest-version") . ". Installing now!");
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