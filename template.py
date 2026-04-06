#!/usr/bin/env python3
import re
import settings

_LXM_RE = re.compile(r'lxm://([a-fA-F0-9]+)|lxmf@([a-fA-F0-9]+)')

def is_privileged(remote_identity):
    """Return True if the remote identity hash is an admin or moderator."""
    if not remote_identity:
        return False
    h = remote_identity.lower()
    return h in [x.lower() for x in settings.admins + settings.moderators]


def linkify(text):
    """Replace lxm://<hash> and lxmf@<hash> occurrences with micron links."""
    def _replace(m):
        h = (m.group(1) or m.group(2)).lower()
        label = h[:16] + '…' if len(h) > 16 else h
        return f'`F0ff`_`[lxmf@{label}`lxmf@{h}]`_`f'
    return _LXM_RE.sub(_replace, text)

_r = settings.root_folder
_nav = (
    f"`F777"
    f"`_`[🏠 Index`:/page/{_r}/index.mu]`_`f"
    f"  `F555·`f  "
    f"`_`[📅`:/page/{_r}/board.mu`section=community_events]`_"
    f"  `_`[🔄`:/page/{_r}/board.mu`section=buy_sell_trade]`_"
    f"  `_`[📢`:/page/{_r}/board.mu`section=announcements]`_"
    f"  `_`[🛠`:/page/{_r}/board.mu`section=work_offers]`_"
    f"  `_`[🙋`:/page/{_r}/board.mu`section=work_requests]`_"
    f"`f"
)

header = f"""#!bg=111
#!fg=bbb

`c`F3b8`!━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`!`f
`c`F6df`!  ◈  {settings.board_name}  ◈  `!`f
`c`F555`!  {settings.board_tagline}  `!`f
`c`F3b8`!━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`!`f
`a

`c{_nav}`a

-¯

"""

footer = """

-∿

`c`F444RetiCommunity · Powered by Reticulum`f
`a
"""
