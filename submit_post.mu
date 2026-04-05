#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings
import db

root = settings.root_folder
section_id = os.environ.get("var_section", "")
title  = os.environ.get("field_post_title",  "").strip()
author = os.environ.get("field_post_author", "").strip()
body   = os.environ.get("field_post_body",   "").strip()
section = settings.sections.get(section_id, {})

print(template.header)

if not section_id or not title or not body:
    missing = []
    if not title: missing.append("title")
    if not body:  missing.append("message")
    print("`Ff54`!Submission Error`!`f")
    print()
    if missing:
        print(f"`F777Missing required field(s): `!{', '.join(missing)}`!`f")
    else:
        print("`F777Unknown section.`f")
    print()
    if section_id:
        print(f"`_`[← Try Again`:/page/{root}/new_post.mu`section={section_id}]`_")
    else:
        print(f"`_`[← Back to Index`:/page/{root}/index.mu]`_")
else:
    post = db.add_post(section_id, title, author, body)
    color = section.get("color", "fff")
    print(f"`F4d6`!Post Submitted!`!`f")
    print()
    print(f"`F777Your post has been added to `!{section.get('title', 'the board')}`!.`f")
    print()
    print(f"`F{color}`_`[View Post`:/page/{root}/post.mu`section={section_id}|post_id={post['id']}]`_`f")
    print()
    print(f"`F555`_`[← Back to {section.get('title', 'Board')}`:/page/{root}/board.mu`section={section_id}]`_`f")

print(template.footer)
