# roblox-discord-presence
A plugin/local http server pair which connects to your discord client and sets your development status.

Feel free to contribute code, README contributions must be substantial.

## Examples
![My own Rich Presence](https://i.imgur.com/8UCUake.png) ![A friend's Rich Presence](https://i.imgur.com/2iRtS6D.png)

## Features
* Customizable Text
* Script context variables:
   * `$SCRIPT_NAME` - Name of the script currently being edited.
   * `$SCRIPT_LINES` - Count of the script's lines.
   * `$SCRIPT_PARENT` - Name of the script's parent.
   * `$ACTIVITY:...` - Activity status (Idle/Away) or if a script is actively being edited, selects text after the `:`.
   * `$WORKSPACE` - Place name/File name.
   * (More to come, feel free to [add your own](https://github.com/RigidStudios/roblox-discord-presence/blob/main/plugin/src/DRPC/src/generators/formatString.lua))
* Supports **buttons** (2 max.)
* In-Studio configuration UI
* Toggleable

## Installation
* The plugin is available [here](<TODO: Link Releases/Published plugin>).
* The server is slightly more complicated to set up:
   * To begin, you'll need an installation of [Node](https://nodejs.org/en/download/).
   * Next, download the [source](<TODO: Link Releases>), extract the files from the zip into a new folder.
   * [Launch](https://i.imgur.com/cm8w8Pq.mp4) the command prompt in that file.
   * Run `npm i` followed by `node index.js` (The latter will be your startup command whenever you need it running).
   * As of right now, you'll be required to launch it at startup yourself until I make it a windows service, and you'll also have to keep the command prompt open.
* Once the plugin and server are running on a place at the same time, you should see your rich presence change as long as your discord settings are correct:
  `User Settings` > `Game Activity` > `Display currently running game as a status message` -> **Enabled**.

If it doesn't work and you've correctly followed the steps, either contribute to this very barebones installation guide to fix it for others, or submit an issue.

### Special Thanks to
[@Kunal0004](https://github.com/Kunal0004) - Testing
