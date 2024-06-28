:local pppoeStatus;
# /interface ethernet monitor WAN2 once do={ :set pppoeStatus $status};
/interface pppoe-client monitor fregat once do={ :set pppoeStatus $status};
:local primaryRouteStatus [/ip route get value-name=distance [find comment="FREGAT"]];
:local secondaryRouteStatus [/ip route get value-name=distance [find comment="DTS"]];
:if ($pppoeStatus = "terminating... - disconnected") do={
        :if ($primaryRouteStatus = "20") do={
            /ip route set [find comment="DTS"] distance=20;
           /ip route set [find comment="FREGAT"] distance=30;
           :local MessageText ("FREGAT%20IS%20DOWN");
           :local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
           $SendTelegramMessage MessageText=$MessageText;
            log warning ("FREGAT IS DOWN")
       }
} else={
        :if ($secondaryRouteStatus = "20") do={
            /ip route set [find comment="DTS"] distance=30;
           /ip route set [find comment="FREGAT"] distance=20;

           :local MessageText ("FREGAT%20IS%20UP");
           :local SendTelegramMessage [:parse [/system script  get SendTelegram source]];
           $SendTelegramMessage MessageText=$MessageText;
            log warning ("FREGAT IS UP")
        }
}