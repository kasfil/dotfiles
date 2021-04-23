""" Qtile Theme config

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
COLORS = {
    'background': '#2e3440',
    'foreground': '#d8dee9',
    'dark': '#3b4252',
    'light': '#4c566a',
    'red': '#bf616a',
    'green': '#a3be8c',
    'yellow': '#ebcb8b',
    'blue': '#81a1c1',
    'magenta': '#b48ead',
    'cyan': '#88c0d0',
}

layout_default = {
    'border_focus': COLORS.get('blue'),
    'border_normal': COLORS.get('dark'),
    'border_width': 1,
    'margin': 7
}

widget_defaults = dict(
    font = 'Overpass Bold',
    fontsize = 12,
    padding = 5,
    padding_x = 4,
    padding_y = 8
)
