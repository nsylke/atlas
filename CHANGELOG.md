# Changelog

This project is using [Semantic Versioning 2.0.0](http://semver.org/)

## Atlas 2.6.0

### Changes
  * The `documentation` command works again, Woohoo!
  * Added documentation to `help` command
  * Added `String#to_emojis` and `String#emoji_alphabet` to String extension
  * Added `emojify` command 
  * Added `role` command
  * Added `channel` command
  * Changed `doc` to `docs` in commands list
  * Added `donate` to commands list
  * Removed `kickall` command
  * [MySQL] Changed `id` to `varchar(18)` from `bigint(20)`
  * [MySQL] Changed `modlog_id` to `varchar(18)` from `bigint(20)`
  * [MySQL] Changed `autorole` to `varchar(18)` from `varchar(32)`

### Fixes
  * Disabled a test command that shouldn't be available
  * `subscribe` and `unsubscribe` will respond if already (or not) subscribed
  * `about` no longer shows blurple avatar
  * Switched `String#nato_alphabet` from double quotes to single quotes
  * `random` command no longer fails if the number is too large
  * Fixed `user` command not responding if user had no roles
  * Fixed `kick`, `ban` and `unban` command not adding to the modlog
  * Fixed `kick` and `ban` command displaying wrong reason in modlog
  * Fixed `kick` and `ban` command not kicking/banning if user has no roles

### Optimizations
  * Simplified command registration

### Known caveats
  * Disabled stats in `server_create` and `server_delete` event since it doesn't update


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