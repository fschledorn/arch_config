general {
        output_format = "i3bar"
        colors = true
	separator= "|"
	interval = 1
}

order += "ipv6"
order += "wireless wlan0"
order += "ethernet eth0"
order += "battery 0"
order += "disk /"
order += "memory"
order += "cpu_usage"
order += "cpu_temperature 0"
order += "tztime local"

wireless wlan0 {
        format_up = "W: (%quality at %essid) %ip"
        format_down = "W: down"
}

ethernet eth0 {
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

battery 0 {
        format = "%status %percentage %remaining"
        format_down = "No battery"
        status_chr = "⚡CHR"
        status_bat = "⚡BAT"
        status_unk = "? UNK"
        status_full = " FULL"
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
}

run_watch DHCP {
        pidfile = "/var/run/dhclient*.pid"
}

#exec_WG {
#        format = "VPN: %name (%ip)"
#        format_down = "VPN: Disconnected"
#        # file containing the PID of a wireguard process
#        command = "wg show interfaces"
#}

path_exists VPN {
        # path exists when a VPN tunnel launched by nmcli/nm-applet is active
        path = "/proc/sys/net/ipv4/conf/tun0"
}

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
        hide_if_equals_localtime = false
}


cpu_usage {
        format = "CPU: %usage"
	      max_threshold = 95
	      degraded_threshold = 75
}

cpu_temperature 0 {
        format = "Temp: %degrees °C"
        path = "/sys/devices/platform/coretemp.0/hwmon/hwmon*/temp1_input"
}

memory {
        format = "%used"
        threshold_degraded = "10%"
        format_degraded = "MEMORY: %free"
}

disk "/" {
        format = "%free"
}

read_file uptime {
        path = "/proc/uptime"
}
