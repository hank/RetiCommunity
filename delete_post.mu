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
privileged = template.is_privileged(os.environ.get("remote_identity", ""))
section    = settings.sections.get(section_id, {})

print(template.header)

if not privileged:
    print("`Ff54`!Access Denied`!`f")
    print()
    print("`F777You do not have permission to delete posts.`f")
    print()
    print(f"`_`[← Back to Index`:/page/{root}/index.mu]`_")
    print(template.footer)
    raise SystemExit

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

db.delete_post(section_id, post_id)

print("`F4d6`!Post Deleted`!`f")
print()
print(f"`F777\"{post['title']}\" has been removed.`f")
print()
print(f"`_`[← Back to {section.get('title', 'Board')}`:/page/{root}/board.mu`section={section_id}]`_")
print(template.footer)
