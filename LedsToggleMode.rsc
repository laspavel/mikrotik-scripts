:if ([ /system leds settings get all-leds-off ] = "never") do={
  /system leds settings set all-leds-off=immediate;
  /log info ("NIGHT LED MODE ACTIVATED")
} else={
  /system leds settings set all-leds-off=never;
  /log info ("DAY LED MODE ACTIVATED")
}