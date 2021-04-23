""" Qtile Main config

Copyright © 2021 Kasfil <kasf.fx@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the “Software”), to deal in the
Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""
# pylint: disable=C0103
# pylint: disable=W0611

from typing import List
import subprocess
import re

from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, Match, Rule
from libqtile.lazy import lazy

from layout import floating_layout, layouts
from theme import COLORS, layout_default, widget_defaults
from custom_widget.bettergmail.better_gmail import BetterGmail

MOD = 'mod4'
TERMINAL = 'tym'
floating_st = 'st -c st-floating'

@hook.subscribe.startup_once
def autostart():
    """Process all startup application and code"""
    processes = [
        ['pulseaudio', '--start'],
        ['setxkbmap', '-option', 'caps:swapescape'],
        ['$HOME/.config/qtile/gnome-keyring.sh'],
    ]

    for process in processes:
        subprocess.run(process, capture_output=True, check=True)

def lockscreen():
    """Lock screen"""
    subprocess.run(['betterlockscreen', '-l'], check=True)

keys = [
    # common keyboard shortcut
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pulseaudio-ctl up 5'),
        desc='Raise volume up 5'),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pulseaudio-ctl down 5'),
        desc='Raise volume down 5'),
    Key([], 'XF86AudioMute', lazy.spawn('pulseaudio-ctl mute'),
        desc='Mute volume'),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('brightnessctl s +5%'),
        desc='Add Brightness'),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('brightnessctl s 5%-'),
        desc='Reduce Brightness'),

    # Switch between windows in current stack pane
    Key([MOD], 'k', lazy.layout.down(),
        desc='Move focus down'),
    Key([MOD], 'j', lazy.layout.up(),
        desc='Move focus up'),
    Key([MOD], 'h', lazy.layout.left(),
        desc='Move focus left'),
    Key([MOD], 'l', lazy.layout.right(),
        desc='Move focus right'),

    # Move windows
    Key([MOD, 'control'], 'k', lazy.layout.shuffle_down(),
        desc='Move window down in current stack '),
    Key([MOD, 'control'], 'j', lazy.layout.shuffle_up(),
        desc='Move window up in current stack '),
    Key([MOD, 'control'], 'h', lazy.layout.shuffle_left(),
        desc='Move window left in current stack '),
    Key([MOD, 'control'], 'l', lazy.layout.shuffle_right(),
        desc='Move window right in current stack '),

    # Resize window
    Key([MOD, 'shift'], 'k', lazy.layout.grow_up(),
        desc='Grow window up'),
    Key([MOD, 'shift'], 'j', lazy.layout.grow_down(),
        desc='Grow window down'),
    Key([MOD, 'shift'], 'h', lazy.layout.grow_left(),
        desc='Grow window left'),
    Key([MOD, 'shift'], 'l', lazy.layout.grow_right(),
        desc='Grow window right'),

    # Switch window focus to other pane(s) of stack
    Key([MOD], 'space', lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'),

    # group in window behaviour
    Key([MOD], 'period', lazy.group.next_window(),
        desc='Switch to next window in active group'),
    Key([MOD], 'comma', lazy.group.prev_window(),
        desc='Switch to prev window in active group'),

    # Swap panes of split stack
    Key([MOD, 'shift'], 'space', lazy.layout.rotate(),
        desc='Swap panes of split stack'),

    Key([MOD, 'shift'], 'Return', lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'),

    # launch terminal
    Key([MOD], 'Return', lazy.spawn(TERMINAL), desc='Launch terminal'),

    # lauch floating st
    Key([MOD, 'shift'], 'n', lazy.spawn(floating_st),
        desc='Launch small floating st'),

    # Lock screen
    Key([MOD], 'BackSpace', lazy.spawn('betterlockscreen -l'),
        desc='Lock your screen'),

    # take screenshot
    Key([], 'Print', lazy.spawn('shotgun'),
        desc='Take screenshot your screen'),

    # Window behaviour mapping
    Key([MOD, 'shift'], 'f', lazy.window.toggle_floating(),
        desc='Toggle window floating'),
    Key([MOD], 'f', lazy.window.toggle_fullscreen(),
        desc='Toggle window fullscreen'),

    # Toggle between different layouts as defined below
    # Key([MOD], 'Tab', lazy.next_layout(), desc='Toggle between layouts'),

    Key([MOD], 'q', lazy.window.kill(), desc='Kill focused window'),

    Key([MOD, 'shift'], 'r', lazy.restart(), desc='Restart qtile'),

    Key([MOD, 'shift'], 'q', lazy.spawn('powerplan'),
        desc='Run rofi powerplan script'),
    Key([MOD], 'd', lazy.spawn('rofi -show drun'),
        desc='show rofi drun'),
    Key([MOD], 'r', lazy.spawn('rofi -show run'),
        desc='show rofi run'),
]

groups = [
    Group(name='1',
          layout='columns',
          label='1'),
    Group(name='2',
          layout='columns',
          label='2'),
    Group(name='3',
          layout='columns',
          label='3'),
    Group(name='4',
          layout='columns',
          label='4'),
    Group(name='5',
          layout='columns',
          label='5'),
    Group(name='6',
          layout='columns',
          label='6'),
    Group(name='7',
          layout='columns',
          label='7'),
    Group(name='8',
          layout='columns',
          label='8'),
    Group(name='9',
          layout='floating',
          label='9')
]

for i in groups:
    keys.extend([
        # move to group
        Key([MOD], i.name, lazy.group[i.name].toscreen(),
            desc='Switch to group {}'.format(i.name)),
        # move window to group
        Key([MOD, 'shift'], i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc='Switch to & move focused window to group {}'.format(i.name)),
    ])

extension_defaults = widget_defaults.copy()

bar_widget = [
    widget.GroupBox(
        font = 'Overpass',
        foreground = COLORS.get('foreground'),
        background = COLORS.get('background'),
        highlight_method = 'block',
        this_current_screen_border = COLORS.get('yellow'),
        block_highlight_text_color = COLORS.get('background'),
        active = COLORS.get('yellow'),
        inactive = COLORS.get('light'),
        urgent_border = COLORS.get('red'),
        rounded = False,
        disable_drag = True,
    ),
    widget.CPU( # pylint: disable=E1101
        foreground = COLORS.get('green'),
        format = 'CPU:{load_percent}%'
    ),
    widget.Memory( # pylint: disable=E1101
        foreground = COLORS.get('green'),
        format = 'RAM:{MemPercent}%',
    ),
    widget.DF( # pylint: disable=E1101
        foreground = COLORS.get('blue'),
        warn_color = COLORS.get('red'),
        format = 'ROOT: {r:.0f}%',
        partition = '/',
        measure = 'G',
        warn_space = 15,
        visible_on_warn = False,
        update_interval = 15
    ),
    widget.DF( # pylint: disable=E1101
        foreground = COLORS.get('blue'),
        warn_color = COLORS.get('red'),
        format = 'HOME: {r:.0f}%',
        partition = '/home',
        measure = 'G',
        warn_space = 15,
        visible_on_warn = False,
        update_interval = 15
    ),
    widget.CheckUpdates( # pylint: disable=E1101
        foreground = COLORS.get('foreground'),
        colour_have_update = COLORS.get('yellow'),
        colour_no_update = COLORS.get('light'),
        custom_command = 'paru -Qu',
        no_update_string = 'Updated',
        display_format = ' {updates}',
    ),
    widget.Spacer(), # pylint: disable=E1101
    widget.Systray(
        icon_size = 17,
        padding = 8
    ),
    BetterGmail(
        label_id = 'Label_251486169706880594',
        display_format = '  {MessageUnread}',
        send_notification = False,
        color_unread = COLORS.get('yellow'),
        color_no_unread = COLORS.get('magenta'),
    ),
    widget.CurrentLayout(
        foreground = COLORS.get('magenta'),
        fmt = '[{}]'
    ),
    widget.Wlan( # pylint: disable=E1101
        foreground = COLORS.get('blue'),
        interface = 'wlp2s0',
        format = '  {essid}',
    ),
    widget.Volume( # pylint: disable=E1101
        foreground = COLORS.get('blue'),
        fmt = '墳 {}',
    ),
    widget.Battery( # pylint: disable=E1101
        foreground = COLORS.get('green'),
        battery = 1,
        charge_char = 'charging',
        discharge_char = 'discahrging',
        full_char = 'full',
        format = '  {percent:2.0%}',
        show_short_text = False
    ),
    widget.Clock(
        foreground = COLORS.get('yellow'),
        background = COLORS.get('dark'),
        format = '%a %B, %d - %H:%M',
        padding = 8
    ),
]

screens = [
    Screen(
        wallpaper = '/home/kasf/Pictures/astrojellyfish-greenish.jpg',
        wallpaper_mode = 'fill',
        top = bar.Bar(
            bar_widget,
            25,
            background = COLORS.get('background'),
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([MOD], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([MOD], 'Button2', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([MOD], 'Button3', lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = [
    # Firefox Window
    Rule(Match(wm_class='firefox'), group='2'),
    # VSCode
    Rule(Match(wm_class='code'), group='3'),
    # Libreoffice
    Rule(Match(wm_instance_class='Libreoffice'), group='4'),
    # Inkscape
    Rule(Match(wm_class='org.inkscape.Inkscape'), group='5'),
    # Gimp
    Rule(Match(wm_class=re.compile('gimp*')), group='5'),
    # File Manager
    Rule(Match(wm_class='org.gnome.Nautilus'), group='6'),
    Rule(Match(wm_class='thunar'), group='6'),
    # Postman
    Rule(Match(wm_class='postman'), group='7'),
    # Beekeeper
    Rule(Match(wm_class='beekeeper-studio'), group='7'),
    # Communication
    Rule(Match(wm_class='telegram-desktop'), group='8'),
    Rule(Match(wm_class='discord'), group='8'),
]
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = 'smart'

wmname = 'LG3D'
