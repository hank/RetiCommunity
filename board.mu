#!/usr/bin/env python3
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import template
import settings
import db
from datetime import datetime

root = settings.root_folder
section_id = os.environ.get("var_section", "community_events")
section = settings.sections.get(section_id) or settings.sections["community_events"]
page = max(1, int(os.environ.get("var_page", "1")))
per_page = 20
color = section["color"]
privileged = template.is_privileged(os.environ.get("remote_identity", ""))

print(template.header)
print(f"`F{color}`!{section['icon']}  {section['title']}`!`f")
print(f"`F777{section['description']}`f")
print()
print(f"`F{color}`_`[+ New Post`:/page/{root}/new_post.mu`section={section_id}]`_`f")
print()
print("-")
print()

posts = db.get_posts(section_id)
total = len(posts)
start = (page - 1) * per_page
page_posts = posts[start:start + per_page]

if not page_posts:
    print("`F777No posts yet — be the first!`f")
else:
    for post in page_posts:
        ts = datetime.fromtimestamp(post["timestamp"]).strftime("%Y-%m-%d")
        n_comments = len(post.get("comments", []))
        reply_str = f"{n_comments} repl{'y' if n_comments == 1 else 'ies'}"
        del_link = f"  `Ff54`_`[Delete`:/page/{root}/delete_post.mu`section={section_id}|post_id={post['id']}]`_`f" if privileged else ""
        print(f"`F{color}`_`[{post['title']}`:/page/{root}/post.mu`section={section_id}|post_id={post['id']}]`_`f")
        print(f"`F555  {post['author']}  ·  {ts}  ·  {reply_str}`f{del_link}")
        print()

# Pagination
nav_parts = []
if page > 1:
    nav_parts.append(f"`_`[← Prev`:/page/{root}/board.mu`section={section_id}|page={page - 1}]`_")
if start + per_page < total:
    nav_parts.append(f"`_`[Next →`:/page/{root}/board.mu`section={section_id}|page={page + 1}]`_")
if nav_parts:
    print("  ".join(nav_parts))
    print()

print(f"`F555`_`[← Back to Index`:/page/{root}/index.mu]`_`f")
print(template.footer)
