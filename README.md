# Where From?

**Where From? is a lightweight World of Warcraft addon that shows where another player's mount comes from, right in their tooltip.**

Hover over a mounted player and the tooltip tells you which mount they're riding, how it's obtained, and whether you already have it.

## What it shows

When you mouse over another player who is mounted, a **Where From?** section is added to their tooltip:

- **Source type** – such as Drop, Vendor, Achievement, Quest or Store.
- **Mount name and icon.**
- **Source details** – Blizzard's own description of where the mount comes from (zone, boss, vendor, cost and so on).
- **Collected / Not collected** – whether you already own the mount.

Nothing is added for unmounted players, NPCs or yourself. All information comes from Blizzard's Mount Journal.

## Install

Download the latest zip from [Releases](https://github.com/pdejan/where_from/releases) and extract the `WhereFrom` folder into:

`World of Warcraft/_retail_/Interface/AddOns/`

The resulting path must be `AddOns/WhereFrom/WhereFrom.toc`. Restart WoW if it was running, then enable **Where From?** in the character selection AddOns list.

The addon targets Retail (interface 120105). There are no commands, settings, or library dependencies.

## License

[MIT](LICENSE)
