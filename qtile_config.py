# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.command import lazy
from libqtile.config import Match
from libqtile.config import Rule

#import psutil

import subprocess

def autostart():
    subprocess.Popen(['/bin/bash', '-c', "compton -b --config ~/.config/i3/compton.conf"]).wait()
    subprocess.Popen(['/bin/bash', '-c', "feh --bg-scale Pictures/Deep_Space_72_Without_A_Logo.jpg"]).wait()

autostart()


mod = "mod4"
terminal = "terminator"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn('rofi -show drun'), desc="Spawn a command using a prompt widget"),
    Key([mod], "c", lazy.spawn('rofi -show combi'), desc="Spawn a command using a prompt widget"),

    # CUSTOM DELINX STUFF
    Key([mod], "p", lazy.spawn('gpick --pick'), desc="Spawn a command using a prompt widget"),

    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Makes current app fullscreen"),
    Key([mod], "space", lazy.window.toggle_floating(), desc="Makes an app float"),

    Key([mod], "o", lazy.layout.grow()),
    Key([mod], "i", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "m", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

]

groups = [Group("DE1", layout='monadtall' ,spawn=['terminator -e "neofetch;bash"','firefox -new-instance -P "default-release"']),
          Group("DE2", layout='monadtall'),
          Group("DE3", layout='monadtall'),
          Group("WWW", layout='max', spawn=['brave google.com']),
          Group("CHT", layout='monadtall' ,spawn=['discord']),
          Group("SYS", layout='monadtall', spawn=['terminator -e "htop;bash"']),
          Group("DIR", layout='monadtall' ,spawn=['thunar']),
          Group("MUS", layout='monadtall' ,spawn=['spotify']),
          Group("VID", layout='monadtall' ,spawn=['obs']),
          Group("GFX", layout='floating')]


# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


layouts = [
    layout.MonadTall(
                     align=layout.MonadTall._right,
                     change_ratio=0.01,
                     change_size=5,
                     ratio=0.65
                     ),
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=1),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    layout.TreeTab(
                    font="Fixedsys Excelsior 3.01-L2 Mono",
                    fontsize=16,
                    padding=3,
                    padding_y = 5,
                    section_top = 10,
                    panel_width = 320
                   ),
    # layout.VerticalTile(),
    # layout.Zoomy(),
     layout.Floating()
]

widget_defaults = dict(
    font="Fixedsys Excelsior 3.01-L2 Mono",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

_pad = 15

screens = [
    Screen(
        top=bar.Bar(
            [
                #widget.CurrentLayout(),
                widget.GroupBox(
                    disable_drag=True,
                    highlight_method='line'
                    ),
                widget.Prompt(),

                widget.Spacer(),

                widget.Notify(),
                widget.Mpris2(scroll_chars=45),
                widget.Sep(padding=_pad),
                widget.CPUGraph(type='line'),
                widget.CPU(format='CPU: {load_percent}%'),
                widget.Sep(padding=_pad),
                widget.NetGraph(type='line', line_width=1),
                widget.Net(format='{up} ↑↓{down}',prefix='M', use_bits=True),
                widget.Sep(padding=_pad),
                widget.Memory(measure_mem='M', format='RAM: {MemUsed:.0f}MB'),
                widget.Sep(padding=_pad),
                widget.TextBox(text='GPU:'),
                widget.NvidiaSensors(
                    format='{temp}.0°C',
                    threshold=95, foreground_alert='ff6000'
                    ),
                widget.Sep(padding=_pad),
                widget.TextBox(text='CPU:'),
                widget.ThermalSensor
                (
                    format='{tag}: {temp:.1f}{unit}',
                    tag_sensor='Package id 0'
                    ),
                widget.Sep(padding=_pad),

                widget.Systray(),
                widget.CurrentLayoutIcon(),
                widget.Sep(padding=_pad),
                widget.Clock(format="[ %a %d/%m/%Y ] [ %H:%M:%S ]"),
                widget.Sep(padding=_pad),
                widget.QuickExit(default_text='[X]', countdown_format='[{}]')
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
