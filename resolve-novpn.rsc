:local domains {"example.com"; "www.example.com"; "checkout.example.com"}
/ip firewall address-list remove [/ip firewall address-list find list=novpn-list]
:foreach domain in=$domains do={
    :do {
        :local resolvedIPs [:resolve $domain]
        /ip firewall address-list add list=novpn-list address=$resolvedIPs timeout=1h
    } on-error={:log warning "Failed to resolve $domain"}
}

