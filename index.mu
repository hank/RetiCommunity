#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings
import db

root = settings.root_folder

print(template.header)
print("`cWelcome to the community board. Pick a section below.`a")
print()

for sid, sec in settings.sections.items():
    posts = db.get_posts(sid)
    count = len(posts)
    latest = f"  `F555·`f  `F777Last: `!{posts[0]['title'][:30]}`!`f" if posts else ""
    print(f"`F{sec['color']}`!{sec['icon']}  {sec['title']}`!`f")
    print(f"`F777  {sec['description']}`f{latest}")
    print(f"  `F{sec['color']}`_`[Open  ({count} post{'s' if count != 1 else ''})`:/page/{root}/board.mu`section={sid}]`_`f")
    print()

print(template.footer)
