# FiveM Ban Management System

A simple ban management system for FiveM servers. Allows admins to ban/unban players using multiple identifiers, set custom durations, and automatically check bans when players join.

## Features

- Ban players by `steam`, `license`, `xbl`, `discord`, `ip`, `fivem`, or `hardware`.
- Set optional ban durations (e.g., `1d` for 1 day, `100y` for 100 years).
- Automatic ban checks when players connect.
- Expired bans are automatically removed.
- Unban players using their license.

## Commands

### Ban a Player

```
/kh-ban [playerId] [reason] [duration?]

Example:

/kh-ban 23 Cheating 7d
```

### Unban a Player

```
/kh-unban [license]

Example:

/kh-unban license:74a992xxx2644e3
```

## Installation

1. Clone the repository into your `resources` folder.
2. Add the resource to your `server.cfg`: ensure kh-bans
3. Start your server.

## API Endpoints

- `POST /bans` - Create a new ban.
- `GET /bans/id/:id` - Get ban by ID
- `DELETE /bans/id/:id` - Unban a player by ID
- `POST /bans/identifiers` - Check if a player is banned by identifiers.
- `DELETE /bans/license/:license` - Unban a player by license.

## Notes

- Requires Node.js for the backend API.
- Make sure to configure ACE permissions for admin commands.
