# Changelog

This project is using [Semantic Versioning 2.0.0](http://semver.org/)

## Atlas 2.5.2

### Changes
  * Push server count whenever a Atlas joins or leaves a server (discordbots.org and discord.pw)
  * Added `set` alias for `settings` command


## Atlas 2.5.1

### Changes
  * Moved `say` command from `fun` to `miscellaneous` category
  * Moved `lmgtfy` command from `fun` to `integration` category
  * Moved `server` command from `general` to `utility` category
  * Moved `user` command from `general` to `utility` category
  * More debug messages throughout the bot

### Optimizations
  * Optimized `String#to_nato` to fastest fetch lookup
  * Load all commands at once instead of each category (still registered per category though)

## Atlas 2.5.0

### Changes
  * Atlas is now licensed under GNU GPLv3 license
  * Added `version` command
  * Added `support` alias for `home` command
  * Added `pardon` alias for `unban` command
  * Added `h` and `?` alias for `help` command
  * Added `paypal`, `patreon` and `patron` alias for `donate` command
  * Added `sub` alias for `subscribe` command
  * Added `unsub` alias for `unsubscribe` command
  * More debug messages throughout the bot

### Fixes
  * Fixed no arguments messages in `8ball`, `nato`, `choose` and `zalgo` command
  * Fixed bots from running `nato`, `choose`, `emoji`, `zalgo` and `commands` command
  * Fixed response after pruning a channel
  * Disabled (hard coded) autorole in Atlas server since it caused multiple errors

### Known caveats
  * `about` command shows blurple avatar instead of red avatar
  * `kickall` command doesn't respond if don't have permissions
  * `random` command fails if the number is too large
  * `subscribe` and `unsubscribe` command don't respond if already (or not) subscribed