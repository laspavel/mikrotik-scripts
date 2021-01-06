:global RebootStatus;
:if ($RebootStatus != true)  do={
    :local DeviceName [/system identity get name];
    :local MessageText ("<b>RebootStatus $DeviceName:</b> I reboot now!");
    :local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
     $SendTelegramMessage MessageText=$MessageText;
    :set RebootStatus true;
}