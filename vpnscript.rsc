:global vpnhosts { "at.vpnunlimitedapp.com"; "be.vpnunlimitedapp.com"; "bg.vpnunlimitedapp.com"; "by.vpnunlimitedapp.com"; "cy.vpnunlimitedapp.com"; "cz.vpnunlimitedapp.com"; "dk.vpnunlimitedapp.com"; "ee.vpnunlimitedapp.com"; "de.vpnunlimitedapp.com"; "de-dus.vpnunlimitedapp.com"; "gr.vpnunlimitedapp.com"; "hu.vpnunlimitedapp.com"; "hr.vpnunlimitedapp.com"; "lv.vpnunlimitedapp.com"; "md.vpnunlimitedapp.com"; "nl.vpnunlimitedapp.com"; "pl.vpnunlimitedapp.com"; "ro.vpnunlimitedapp.com"; "si.vpnunlimitedapp.com"; "ch.vpnunlimitedapp.com"; "tr.vpnunlimitedapp.com" }
:global randnum [:tostr ([/tool fetch mode=https http-method=get url="https://www.random.org/integers/\?num=1&min=1&max=21&col=1&base=10&format=plain&rnd=new" as-value output=user ]->"data")]
:global idxx [:tonum [:pick $randnum 0 [:find $randnum " "]]];
:global vpnhost [:pick $vpnhosts $idxx ];
/interface l2tp-client disable VPN1
/interface l2tp-client set [find Name=VPN1] connect-to=$vpnhost
/interface l2tp-client enable VPN1
beep length=300ms;
:set randnum
:set idxx
:set vpnhosts
:set vpnhost
:log info "*** Interface l2tp-client modified ***"