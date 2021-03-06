{ config, pkgs }:

with pkgs;

let
  # primary bar
  i3StatusBarConfig = ''
    general {
        colors = true
        interval = 5
        output_format = i3bar
    }

    #order += "ipv6"
    order += "disk /"
    order += "memory"
    order += "cpu_usage"
    order += "load"
    #order += "cpu_temperature 0"
    #order += "wireless _first_"
    order += "ethernet _first_"
    #order += "battery all"
    order += "volume master"
    order += "tztime local"

    wireless _first_ {
        format_up = "W: (%quality at %essid) %ip"
        format_down = "W: down"
    }

    ethernet _first_ {
        # if you use %speed, i3status requires root privileges
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
    }

    battery all {
        format = "%status %percentage %remaining"
    }

    tztime local {
        format = "%Y-%m-%d %H:%M:%S"
    }

    load {
        format = "%1min"
        #format = "[ load: %1min, %5min, %15min ]"
    }
    
    cpu_usage {
        format = "CPU: %usage"
    }

    cpu_temperature 0 {
        format = "T: %degrees °C"
        path = "/sys/devices/platform/coretemp.0/temp1_input"
    }

    memory {
        format = "MEM: %used"
        threshold_degraded = "10%"
        format_degraded = "MEMORY: %free"
    }

    disk "/" {
        format = "ROOT: %avail"
    }

    volume master {
        format = "VOL: %volume"
        format_muted = "VOL: muted (%volume)"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
    }
  '';
  # secondary bar (just in case)
  i3BlocksBarConfig = ''
    command=$HOME/.config/i3blocks/$BLOCK_NAME/$BLOCK_NAME
    separator_block_width=15
    markup=none

    # Volume indicator
    #
    # The first parameter sets the step (and units to display)
    # The second parameter overrides the mixer selection
    # See the script for details.
    [volume]
    label=VOL
    instance=Master
    #instance=PCM
    interval=once
    #interval=1
    signal=10

    # Memory usage
    #
    # The type defaults to "mem" if the instance is not specified.
    [memory]
    label=MEM
    separator=false
    interval=30

    [memory]
    label=SWAP
    instance=swap
    separator=false
    interval=30

    # Disk usage
    #
    # The directory defaults to $HOME if the instance is not specified.
    # The script may be called with a optional argument to set the alert
    # (defaults to 10 for 10%).
    [disk]
    label=ROOT
    #instance=/mnt/data
    interval=30

    # Network interface monitoring
    #
    # If the instance is not specified, use the interface used for default route.
    # The address can be forced to IPv4 or IPv6 with -4 or -6 switches.
    [iface]
    #instance=wlan0
    color=#00FF00
    interval=10
    separator=false

    [wifi]
    #instance=wlp3s0
    interval=10
    separator=false

    [bandwidth]
    #instance=eth0
    interval=5

    # CPU usage
    #
    # The script may be called with -w and -c switches to specify thresholds,
    # see the script for details.
    [cpu_usage]
    label= CPU
    interval=10
    min_width=CPU: 100.00%
    #separator=false

    [load_average]
    interval=10

    # Battery indicator
    #
    # The battery instance defaults to 0.
    [battery]
    #label=BAT
    label=⚡
    #instance=1
    interval=30

    [temperature]
    label=TEMP
    interval=10

    # Date Time
    #
    [time]
    command=date '+%Y-%m-%d %H:%M:%S'
    interval=5

    [kbd]
    interval=1
    command=xset -q|grep LED| awk '{ if (substr ($10,5,1) == 1) print "RU"; else print "EN"; }'
  '';
in

pkgs.writeText "i3-config" (
  ''
    set $mod Mod4

    # Font for window title bars
    # font pango:monospace 8
    font pango:Fira Mono 8

    # Use Mouse+$mod to drag floating windows to their wanted position
    floating_modifier $mod

    # start a terminal
    bindsym $mod+Return exec i3-sensible-terminal

    # kill focused window
    bindsym $mod+Shift+q kill

    # start dmenu (a program launcher)
    bindsym $mod+d exec dmenu_run

    # There also is the (new) i3-dmenu-desktop which only displays applications
    # shipping a .desktop file. It is a wrapper around dmenu, so you need that
    # installed.
    # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

    # change focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # move focused window
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # split in horizontal orientation
    #bindsym $mod+x split h

    # split in vertical orientation
    #bindsym $mod+y split v

    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle

    # change container layout (stacked, tabbed, toggle split)
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle

    # change focus between tiling / floating windows
    bindsym $mod+space focus mode_toggle

    # focus the parent container
    bindsym $mod+a focus parent

    # focus the child container
    #bindsym $mod+d focus child

    # Define names for default workspaces for which we configure key bindings later on.
    # We use variables to avoid repeating the names in multiple places.
    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6"
    set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"

    # switch to workspace
    bindsym $mod+1 workspace $ws1
    bindsym $mod+2 workspace $ws2
    bindsym $mod+3 workspace $ws3
    bindsym $mod+4 workspace $ws4
    bindsym $mod+5 workspace $ws5
    bindsym $mod+6 workspace $ws6
    bindsym $mod+7 workspace $ws7
    bindsym $mod+8 workspace $ws8
    bindsym $mod+9 workspace $ws9
    bindsym $mod+0 workspace $ws10

    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace $ws1
    bindsym $mod+Shift+2 move container to workspace $ws2
    bindsym $mod+Shift+3 move container to workspace $ws3
    bindsym $mod+Shift+4 move container to workspace $ws4
    bindsym $mod+Shift+5 move container to workspace $ws5
    bindsym $mod+Shift+6 move container to workspace $ws6
    bindsym $mod+Shift+7 move container to workspace $ws7
    bindsym $mod+Shift+8 move container to workspace $ws8
    bindsym $mod+Shift+9 move container to workspace $ws9
    bindsym $mod+Shift+0 move container to workspace $ws10

    # reload the configuration file
    bindsym $mod+Shift+c reload

    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart
    
    # exit i3 (logs you out of your X session)
    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

    # resize window (you can also use the mouse for that)
    mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
    }

    bindsym $mod+r mode "resize"

    # Start i3bar to display a workspace bar (plus the system information i3status
    # finds out, if available)
    bar {
        font pango:Fira Mono 9
        status_command ${i3status}/bin/i3status -c ${
                pkgs.writeText "i3status-config" i3StatusBarConfig
        }
        colors {
            background #273240
            statusline #C2B0AE
            separator  #C2B0AE
            # colorclass       <border> <background> <text>
            focused_workspace  #C2B0AE  #C2B0AE     #273240
            inactive_workspace #273240  #273240     #C2B0AE
        }

    }

    ## GET STARTED
    
    # show me it
    exec --no-startup-id xrandr --output VGA-0 --mode 1920x1080 --rate 60
    exec --no-startup-id feh --bg-fill /etc/nixos/share/wallpaper.jpg

    # powermanager
    exec_always --no-startup-id xfce4-power-manager

    # vsync video
    exec_always --no-startup-id picom -b --backend glx --vsync --xrender-sync-fence --glx-no-rebind-pixmap --use-damage --glx-no-stencil --use-ewmh-active-win --refresh-rate 24

    # keyboard layout
    exec_always setxkbmap -option grp:alt_shift_toggle 'us,ru'

    # lock screen
    bindsym $mod+Control+l exec i3lock -d -c 000000

    # lock screen and suspend to disk
    bindsym $mod+Control+s exec i3lock -d -c 000000 && systemctl hibernate
    exec_always --no-startup-id xautolock -time 10 -locker 'i3lock -d -c 000000' &

    # switch workspaces by mod+ctrl+left/right
    bindsym $mod+Control+Left workspace prev
    bindsym $mod+Control+Right workspace next

    # screenshooter
    bindsym $mod+Print exec xfce4-screenshooter

    # alsa multimedia keys
    bindsym XF86AudioMute exec amixer set Master toggle;  exec pkill  -RTMIN+10 i3blocks
    bindsym XF86AudioRaiseVolume exec amixer set Master 5%+; exec pkill  -RTMIN+10 i3blocks
    bindsym XF86AudioLowerVolume exec amixer set Master 5%-; exec pkill  -RTMIN+10 i3blocks

    # Pulse Audio controls
    #bindsym XF86AudioRaiseVolume exec amixer -q -D pulse sset Master 5%+; exec pkill -RTMIN+10 i3blocks
    #bindsym XF86AudioLowerVolume exec amixer -q -D pulse sset Master 5%-; exec pkill -RTMIN+10 i3blocks
    #bindsym XF86AudioMute exec amixer -q -D pulse sset Master toggle; exec pkill -RTMIN+10

    # Bluetooth applet
    #exec --no-startup-id /usr/bin/blueman-applet

    # Sreen brightness controls
    bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
    bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness
  ''
)