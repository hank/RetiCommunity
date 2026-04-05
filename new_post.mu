#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings

root = settings.root_folder
section_id = os.environ.get("var_section", "community_events")
section = settings.sections.get(section_id) or settings.sections["community_events"]
color = section["color"]

print(template.header)
print(f"`F{color}`!{section['icon']}  New Post — {section['title']}`!`f")
print()
print("-")
print()
print(f"`F777Title:   `f`B333`<post_title` >`b")
print()
print(f"`F777Author:  `f`B333`<post_author` >`b")
print(f"`F555          (leave blank to post as Anonymous)`f")
print()
print(f"`F777Message: `f`B333`<post_body` >`b")
print()
print(f"`F{color}`_`[Submit Post`:/page/{root}/submit_post.mu`*|section={section_id}]`_`f")
print()
print(f"`F555`_`[← Cancel`:/page/{root}/board.mu`section={section_id}]`_`f")
print(template.footer)
