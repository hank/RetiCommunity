#!/usr/bin/env python3
import settings

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
