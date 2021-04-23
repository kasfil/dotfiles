""" Qtile Layout config

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
import re
from libqtile import layout
from libqtile.config import Match
from theme import layout_default, COLORS

layouts = [
    layout.Columns(
        border_focus_stack = COLORS.get('magenta'),
        border_normal_stack = COLORS.get('dark'),
        border_on_single = True,
        **layout_default
    ),
    layout.Stack(
        num_stack = 1,
        **layout_default,
    ),
    layout.Floating(**layout_default),
]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(title='XBindKey: Hit a key'),
    Match(wm_class='vlc'),
    Match(role='pop-up'),
    # st floating (custom)
    Match(wm_class='st-floating'),
    # Gufw
    Match(wm_class=re.compile('[Gg]ufw.py')),
], **layout_default)
