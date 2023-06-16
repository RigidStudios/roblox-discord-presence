# roblox-discord-presence | maintained by [Error-Cezar](https://github.com/Error-Cezar)
<div align="center">
<img alt="GitHub all releases" src="https://img.shields.io/github/downloads/RigidStudios/roblox-discord-presence/total?style=for-the-badge">
  <br/>
   <br/>
</div>
A plugin to add a custom Discord RPC (Rich PresenCe) to your ROBLOX Studio experince ! 

Feel free to contribute code, README contributions must be substantial.

## Examples
![My own Rich Presence](https://i.imgur.com/8UCUake.png) ![A friend's Rich Presence](https://i.imgur.com/2iRtS6D.png) <img src="https://user-images.githubusercontent.com/34319439/110258821-f3c12500-7fbd-11eb-8b68-a5b0b91f1192.PNG" alt="alt text" width="300">

## Features
* Customizable Text.
* Script context variables:
   * `$SCRIPT_NAME` - Name of the script currently being edited.
   * `$SCRIPT_LINES` - Count of the script's lines.
   * `$SCRIPT_PARENT` - Name of the script's parent.
   * `$ACTIVITY:...` - Activity status (Idle/Away) or if a script is actively being edited, selects text after the `:`.
   * `$WORKSPACE` - Place name/File name.
   * `$PLACE_ID` - Place name/"0".
   * `$PLACE_PUBLISHED:...:...` - If place published then first option otherwise second option.
   * (More to come, feel free to [add your own](https://github.com/RigidStudios/roblox-discord-presence/blob/main/plugin/src/DRPC/src/generators/formatString.luau))
* Supports **buttons** (2 max.)
* In-Studio configuration UI.
* Toggleable.

## Installation
* The plugin is available [here (DRPC_client)](https://github.com/RigidStudios/roblox-discord-presence/releases/latest), and [here (direct plugin)](https://www.roblox.com/library/6478572909/DRPC).
* A server is also needed on your machine.
* The Set-Up is very easy:
   * Download the [DRPC Server](https://github.com/RigidStudios/roblox-discord-presence/releases/latest) with a supported OS.
   * Extract the files into a folder.
   * Open DRPC.
   * Modify your settings to your liking.
   * Enjoy !

If it doesn't work and you've correctly followed the steps, please [submit an issue](https://github.com/RigidStudios/roblox-discord-presence/issues/new/choose).

### Special Thanks to
[@BaileyEatsPizza](https://github.com/BaileyEatsPizza) - Scripting

[@Error-Cezar](https://github.com/Error-Cezar) - Maintaining

[@va1kio](https://github.com/va1kio) - UI Design/Scripting

[@Kunal](https://github.com/MotixKunal) - Testing

