#!/usr/bin/env python3
import os
import json
import uuid
import time

_base_dir = os.path.dirname(os.path.abspath(__file__))
_data_dir = os.path.join(_base_dir, "data")


def _section_path(section):
    return os.path.join(_data_dir, section, "posts.json")


def get_posts(section):
    path = _section_path(section)
    if not os.path.exists(path):
        return []
    with open(path) as f:
        return json.load(f)


def _save_posts(section, posts):
    section_dir = os.path.join(_data_dir, section)
    os.makedirs(section_dir, exist_ok=True)
    with open(_section_path(section), "w") as f:
        json.dump(posts, f, indent=2)


def get_post(section, post_id):
    for post in get_posts(section):
        if post["id"] == post_id:
            return post
    return None


def add_post(section, title, author, body):
    posts = get_posts(section)
    post = {
        "id": str(uuid.uuid4())[:8],
        "title": title,
        "author": author or "Anonymous",
        "body": body,
        "timestamp": int(time.time()),
        "comments": [],
    }
    posts.insert(0, post)
    _save_posts(section, posts)
    return post


def add_comment(section, post_id, author, body):
    posts = get_posts(section)
    for post in posts:
        if post["id"] == post_id:
            comment = {
                "id": str(uuid.uuid4())[:8],
                "author": author or "Anonymous",
                "body": body,
                "timestamp": int(time.time()),
            }
            post["comments"].append(comment)
            _save_posts(section, posts)
            return comment
    return None


def delete_post(section, post_id):
    posts = get_posts(section)
    posts = [p for p in posts if p["id"] != post_id]
    _save_posts(section, posts)


def delete_comment(section, post_id, comment_id):
    posts = get_posts(section)
    for post in posts:
        if post["id"] == post_id:
            post["comments"] = [c for c in post["comments"] if c.get("id") != comment_id]
            _save_posts(section, posts)
            return True
    return False
