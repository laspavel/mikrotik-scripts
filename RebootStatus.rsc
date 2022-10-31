# https://www.urlencoder.org/
:global ReBootStatus;
:local DeviceName [/system identity get name];
:local MessageText ("*RebootStatus%20$DeviceName*%3A%20I%20REBOOT%20NOW%20%21%21%21");
:local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
$SendTelegramMessage MessageText=$MessageText;
:set ReBootStatus true;
:if ($ReBootStatus != true)  do={
    :local DeviceName [/system identity get name];
    :local MessageText ("<b>RebootStatus $DeviceName:</b> I reboot now!");
    :local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
     $SendTelegramMessage MessageText=$MessageText;
    :set ReBootStatus true;
}