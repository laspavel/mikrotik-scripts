:do {
:global vpnhosts "at.vpnunlimitedapp.com,be.vpnunlimitedapp.com,bg.vpnunlimitedapp.com,cy.vpnunlimitedapp.com,cz.vpnunlimitedapp.com,dk.vpnunlimitedapp.com,ee.vpnunlimitedapp.com,de.vpnunlimitedapp.com,de-dus.vpnunlimitedapp.com,gr.vpnunlimitedapp.com,hu.vpnunlimitedapp.com,hr.vpnunlimitedapp.com,lv.vpnunlimitedapp.com,md.vpnunlimitedapp.com,nl.vpnunlimitedapp.com,pl.vpnunlimitedapp.com,ro.vpnunlimitedapp.com,si.vpnunlimitedapp.com,ch.vpnunlimitedapp.com,tr.vpnunlimitedapp.com";
:global randnum [:put [:rndnum from=0 to=19]];
:global vpnhost [:pick [:toarray $vpnhosts] $randnum ];

/ip firewall connection remove [/ip firewall connection find protocol=udp]
/ip firewall connection remove [/ip firewall connection find protocol=tcp]

/interface l2tp-client disable VPN1;
/interface l2tp-client set [find Name=VPN1] connect-to=$vpnhost;
/interface l2tp-client enable VPN1;

:log info "Interface l2tp-client modified. New VPN endpoint: $vpnhost";
:put "$vpnhost"

} on-error={
 /log error "********** VPNSCRIPT finished with error *********";
}
