#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings
import db
from datetime import datetime

root = settings.root_folder
section_id = os.environ.get("var_section", "")
post_id = os.environ.get("var_post_id", "")
section = settings.sections.get(section_id, {})

print(template.header)

if not section_id or not post_id:
    print("`Ff54`!Error:`! Missing section or post ID.`f")
    print()
    print(f"`_`[← Back to Index`:/page/{root}/index.mu]`_")
    print(template.footer)
    raise SystemExit

post = db.get_post(section_id, post_id)
if not post:
    print("`Ff54`!Error:`! Post not found.`f")
    print()
    print(f"`_`[← Back to Board`:/page/{root}/board.mu`section={section_id}]`_")
    print(template.footer)
    raise SystemExit

color = section.get("color", "fff")
ts = datetime.fromtimestamp(post["timestamp"]).strftime("%Y-%m-%d %H:%M")

print(f"`F{color}`!{post['title']}`!`f")
print(f"`F555Posted by `!{post['author']}`!  ·  {ts}`f")
print()
print("-")
print()
print(template.linkify(post["body"]))
print()
print("-")
print()

# --- Comments ---
comments = post.get("comments", [])
print(f">`F{color}Comments ({len(comments)})`f")
print()

if comments:
    for c in comments:
        cts = datetime.fromtimestamp(c["timestamp"]).strftime("%Y-%m-%d %H:%M")
        print(f"`F{color}`!{c['author']}`!`f  `F555{cts}`f")
        print(template.linkify(c["body"]))
        print()
else:
    print("`F555No comments yet.`f")
    print()

print("-")
print()

# --- Comment form ---
print(">Leave a Comment")
print()
print(f"`F777Name:    `f`B333`<comment_author` >`b")
print()
print(f"`F777Message: `f`B333`<comment_body` >`b")
print()
print(f"`F{color}`_`[Post Comment`:/page/{root}/submit_comment.mu`*|section={section_id}|post_id={post_id}]`_`f")
print()
print(f"`F555`_`[← Back to {section.get('title', 'Board')}`:/page/{root}/board.mu`section={section_id}]`_`f")
print(template.footer)
