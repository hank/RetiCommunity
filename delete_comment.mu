#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings
import db

root       = settings.root_folder
section_id = os.environ.get("var_section", "")
post_id    = os.environ.get("var_post_id", "")
comment_id = os.environ.get("var_comment_id", "")
privileged = template.is_privileged(os.environ.get("remote_identity", ""))
section    = settings.sections.get(section_id, {})

print(template.header)

if not privileged:
    print("`Ff54`!Access Denied`!`f")
    print()
    print("`F777You do not have permission to delete comments.`f")
    print()
    print(f"`_`[← Back to Index`:/page/{root}/index.mu]`_")
    print(template.footer)
    raise SystemExit

if not section_id or not post_id or not comment_id:
    print("`Ff54`!Error:`! Missing required parameters.`f")
    print()
    print(f"`_`[← Back to Index`:/page/{root}/index.mu]`_")
    print(template.footer)
    raise SystemExit

ok = db.delete_comment(section_id, post_id, comment_id)

if ok:
    print("`F4d6`!Comment Deleted`!`f")
    print()
    print("`F777The comment has been removed.`f")
else:
    print("`Ff54`!Error:`! Comment not found.`f")

print()
print(f"`_`[← Back to Post`:/page/{root}/post.mu`section={section_id}|post_id={post_id}]`_")
print(template.footer)
