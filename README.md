# RetiCommunity

A community message board for [NomadNet](https://github.com/markqvist/NomadNet) nodes on the [Reticulum](https://reticulum.network/) mesh network. Organized into sections for local events, buy/sell/trade, announcements, and work offers/requests — all rendered as micron pages, no internet required.

---

## Features

- **Five board sections** — Community Events, Buy/Sell/Trade, Announcements, Work Offers, Work Requests
- **Full post and comment flow** — new posts, threaded comments, paginated listings
- **lxmf link rendering** — any `lxm://` or `lxmf@` address in post or comment content is automatically rendered as a clickable link
- **Admin/moderator moderation** — privileged identities can delete posts and comments directly from the board; delete links only appear for authenticated privileged users
- **Identity-based access** — privilege is determined by the RNS identity hash sent via NomadNet's "Identify on Connect" feature; no passwords, no accounts
- **Dark micron UI** — styled with a consistent color-coded theme across all sections and pages, with a persistent navigation bar

---

## Requirements

- [NomadNet](https://github.com/markqvist/NomadNet) running with a hosted node
- Python 3 (via the NomadNet venv)
- No external dependencies beyond the standard library

---

## Installation

1. Clone or copy this directory into your NomadNet pages folder:

   ```
   ~/.nomadnetwork/storage/pages/reticommunity/
   ```

2. Ensure all `.mu` files are executable:

   ```bash
   chmod +x ~/.nomadnetwork/storage/pages/reticommunity/*.mu
   ```

3. Edit `settings.py` to configure your board name and add your RNS identity hash to the `admins` list (see [Moderation](#moderation) below).

4. Link to the board from your node's `index.mu`:

   ```
   `[◈ RetiCommunity`:/page/reticommunity/index.mu]
   ```

5. Restart NomadNet or wait for the page refresh interval to pick up the new pages.

---

## Configuration

All configuration lives in `settings.py`:

```python
root_folder = "reticommunity"   # must match the directory name under pages/

board_name    = "RetiCommunity"
board_tagline = "Community Message Board"

admins = [
    "your32hexcharidentityhashhere00",
]

moderators = [
    # additional hashes here
]
```

### Sections

Each section has a `title`, `icon`, `description`, and `color` (3-digit hex). Add, remove, or rename sections in the `sections` dict — the index page and navigation bar are generated dynamically from it.

---

## Moderation

Admins and moderators currently share the same permissions: **delete posts and delete comments**.

Delete links are only shown to users whose RNS identity hash matches an entry in `admins` or `moderators` in `settings.py`. The identity is provided automatically by NomadNet when the client has **"Identify on Connect"** enabled for your node — this is a per-peer setting in the NomadNet directory on the client side.

**To find your identity hash:** it will appear in the debug output if you temporarily enable the debug lines in `board.mu`, or you can read it from your NomadNet identity file.

**To add a moderator:** append their RNS identity hash (32 hex characters, no delimiters) to the `moderators` list in `settings.py`. Changes take effect immediately on the next page load — no restart required.

---

## Data Storage

Posts and comments are stored as JSON files under the `data/` directory, one file per section:

```
data/
  community_events/posts.json
  buy_sell_trade/posts.json
  announcements/posts.json
  work_offers/posts.json
  work_requests/posts.json
```

Each post contains a title, author, body, timestamp, and a list of comments. All data access goes through `db.py`.

---

## File Overview

| File | Purpose |
|---|---|
| `index.mu` | Main landing page — lists all sections with post counts |
| `board.mu` | Section listing — paginated post index for a section |
| `post.mu` | Post view — full body, comment thread, comment form |
| `new_post.mu` | New post form |
| `submit_post.mu` | Handles post creation |
| `submit_comment.mu` | Handles comment submission |
| `delete_post.mu` | Deletes a post (privileged only) |
| `delete_comment.mu` | Deletes a comment (privileged only) |
| `settings.py` | Board configuration, sections, admin/mod hashes |
| `db.py` | JSON data layer — read/write/delete posts and comments |
| `template.py` | Shared micron header, footer, nav bar, `linkify()`, `is_privileged()` |

---

## lxmf Link Rendering

Any text in a post or comment body containing an `lxm://` or `lxmf@` address is automatically converted to a clickable micron link:

```
Contact me at lxm://3e22ab108ffaa3ba5d7153946b162b55
# renders as a tappable lxmf@ link in NomadNet
```

Both formats normalize to `lxmf@<hash>` which NomadNet dispatches to the messaging interface.

---

## License

MIT — do whatever you want with it. 73.
