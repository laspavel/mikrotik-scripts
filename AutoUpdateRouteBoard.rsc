# https://www.urlencoder.org/
:do {
    :local DeviceName [/system identity get name];
    :local currentversion [/system routerboard get current-firmware]
    :local lastversion [/system routerboard get upgrade-firmware]
    :if (($currentversion) != ($lastversion)) do={
        /log info ("Installing new routerboard version on $DeviceName: ". ($lastversion))
       :local MessageText ("*AutoUpdate%20$DeviceName%3A*%20Upgrade%20routeboard%20from%20". ($currentversion)."%20to%20". ($lastversion));
       :local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
        $SendTelegramMessage MessageText=$MessageText;

        /system routerboard upgrade

        :delay 20s
        /system reboot
    }
   /log info ("Installed routeboard version: " .($currentversion))

} on-error={
    /log error "***** AUTOUPDATE ROUTEBOARD script finished with error ******"
}
