# FireBlast2IceLance (WoW Forever)

**Ice Lance icon instead of Fire Blast in Blizzard's Cooldown Manager.**

FireBlast2IceLance is a tiny World of Warcraft addon for the Forever client. In Forever, Fire Blast and Ice Lance share a cooldown, but Blizzard's Cooldown Manager lets you pick only Fire Blast. A frost mage then watches a Fire Blast icon for a spell they hardly ever press. This addon shows the Ice Lance icon there instead.

---

**Project status:** Early version, before 0.1.

**Transparency:** FireBlast2IceLance is written entirely by AI. All of the code and this documentation were produced by an AI coding assistant (Claude); the maintainer is not a programmer and did not write any of it by hand. His part was deciding what the addon should do, testing it in the game and reporting what was wrong. The code is one short Lua file, kept readable and commented so that it can be inspected directly.

**License:** [MIT](LICENSE)

---

## What it does

- Changes the icon only on the Cooldown Manager's bars. The cooldown, its timer and everything else stay as the game shows them.
- Leaves Fire Blast alone everywhere else: action bars, spellbook, tooltips, other addons.
- The Cooldown Settings window still shows Fire Blast.

Other pairs can be added at the top of `FireBlast2IceLance.lua`: `["Spell in the Cooldown Manager"] = "Spell whose icon to show",` (English spell names).

## Install

1. Download this repository.
2. Copy the folder `FireBlast2IceLance` into `World of Warcraft/_forever_/Interface/AddOns/`.
3. Start the game (a new addon folder is not found by `/reload`).

## Requirements

- World of Warcraft, Forever client (interface 16001).
- No other addons or libraries.
