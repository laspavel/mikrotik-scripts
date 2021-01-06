:do {
#:local MessageText "TestMain";
:local BotToken "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
:local ChatID "99999999";
:local SendText $MessageText;
:local tgUrl "https://api.telegram.org/bot$BotToken/sendMessage\?chat_id=$ChatID&text=$SendText&parse_mode=html&disable_web_page_preview=True";
/tool fetch url=($tgUrl) keep-result=no;

#:log info "Send Telegram Message: $MessageText";
} on-error={
    /log error "***** SendTelegram finished with error ******"
}