#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings
import db

root = settings.root_folder
section_id = os.environ.get("var_section", "")
post_id    = os.environ.get("var_post_id", "")
author     = os.environ.get("field_comment_author", "").strip()
body       = os.environ.get("field_comment_body",   "").strip()
section    = settings.sections.get(section_id, {})

print(template.header)

if not section_id or not post_id or not body:
    print("`Ff54`!Submission Error`!`f")
    print()
    if not body:
        print("`F777Message field cannot be empty.`f")
    else:
        print("`F777Missing section or post reference.`f")
    print()
    if section_id and post_id:
        print(f"`_`[← Try Again`:/page/{root}/post.mu`section={section_id}|post_id={post_id}]`_")
    else:
        print(f"`_`[← Back to Index`:/page/{root}/index.mu]`_")
else:
    comment = db.add_comment(section_id, post_id, author, body)
    if comment:
        color = section.get("color", "fff")
        print("`F4d6`!Comment Added!`!`f")
        print()
        print("`F777Your comment has been posted.`f")
        print()
        print(f"`F{color}`_`[← View Post`:/page/{root}/post.mu`section={section_id}|post_id={post_id}]`_`f")
    else:
        print("`Ff54`!Error:`! Post not found.`f")
        print()
        print(f"`_`[← Back to Board`:/page/{root}/board.mu`section={section_id}]`_")

print(template.footer)
