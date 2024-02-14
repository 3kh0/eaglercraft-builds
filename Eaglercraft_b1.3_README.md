# Eaglercraft Beta Singleplayer

**A version of Eaglercraft with both singleplayer and multiplayer. Based on Minecraft Beta 1.3, you can play singleplayer and multiplayer in any web browser and your worlds will be saved to your browser's local storage. Works on all chromebooks, you can export and import your worlds to make backups or move worlds to a different computer.**

![Eaglercraft Singleplayer Minecraft Beta 1.3 in browser](https://media.discordapp.net/attachments/378764518081429506/982903386380853258/screenshot_singleplayer_small.png)

### Official Demo URL: [https://eaglercraft.us/beta/](https://eaglercraft.us/beta/)

### Download locally: [Singleplayer_Offline_Download_Version.html](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/stable-download/Singleplayer_Offline_Download_Version.html)

**Host the singleplayer client: [singleplayer-download.zip](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/stable-download/singleplayer-download.zip)**

**Host singleplayer and multiplayer: [multiplayer-download.zip](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/stable-download/multiplayer-download.zip)**

## Technical Details

**Discord server: [https://discord.gg/Ekzcgs3DKZ](https://discord.gg/Ekzcgs3DKZ)**

The game saves worlds to your browser's persistent local storage via [IndexedDB](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API), the vanilla MCRegion chunk loader has been rewritten to store chunks as single files instead, without compression to speed up load and save times. These files are then stored in an IndexedDB table in the browser's local storage as ArrayBuffers with string keys describing the coordinates of the chunk.

This is done because there is no efficient way to emulate a `java.nio.RandomAccessFile` using IndexedDB. Browser already implement IndexedDB using a storage system similar to MCRegion by default, which will group many small objects together into single large files. Therefore storing each chunk as a single virtual file in IndexedDB will not cause the severe fragmentation issues and folder lag like the original Minecraft Classic chunk storage did.

### A list of item, block, and entity IDs can be found here: [ITEM-IDs.md](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/ITEM-IDs.md)

**Singleplayer Commands:**
- `/help` list all available commands
- `/give` spawn an item or block by id
- `/summon` spawn an entity by id
- `/time` change the world time

## Compiling

Like the 1.5.2 Eaglercraft, just import this entire repository as a gradle project and use the **teavmc** gradle task. It will generate a `classes.js` in the `javascript` folder of this repository.

To change any textures and stuff, make your changes in `lwjgl-rundir/resources` and then run `epkcompiler/run.bat` to generate a new `assets.epk` in the `javascript` folder where `classes.js` is. On linux/mac, open terminal and type `chmod +x run_unix.sh` and then `./run_unix.sh` to run the tool. Copy the new `javascript/assets.epk` onto your website over the old one to update it.

**Make sure you install java and add it to your PATH, or these scripts will not work.**

To compile the server, read the [readme.txt](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/bukkit/readme.txt) in the `bukkit` folder.

**To run the desktop java runtime**, create a new java project in an IDE. Link `src/main/java` and `src/lwjgl/java` as source folders, and add all jars in the `lwjgl-rundir` folder to your build path. Create a run configuration and set the main class to `net.lax1dude.eaglercraft.MinecraftMain`, and then set the working directory to `lwjgl-rundir`. The client should then launch with no errors, if not then re-read the previous two sentances and try again.

## Issues

Issues are disabled due to spam, you can just use common sense to solve most gameplay issues.

**Be aware this is an old version of Minecraft, many features in the 1.5.2 client did not exist yet in beta 1.3. If you believe a feature is missing, there is an 11 out of 10 chance that it isn't in vanilla minecraft beta 1.3 either.**

Minecraft beta has no sprinting, and hunger did not exist until beta 1.8 either. **To exit a boat or minecart**, you just right click the entity again the same way you did to enter it. **DO NOT ASK FOR THESE FEATURES TO BE ADDED**, this is supposed to be a 1:1 port of minecraft beta, if you want a feature that does not already exist natively in vanilla beta 1.3 then just play the 1.5.2 client instead.

**Nether portals are not supported in multiplayer, Notch didn't figure that out until beta 1.6.**

If you're genuinely stuck then join **[https://discord.gg/KMQW9Uvjyq](https://discord.gg/KMQW9Uvjyq)**

## Server Setup Guide

### DON'T HOST A PUBLIC SERVER! - [https://youtu.be/7qWNM0MMV1g](https://youtu.be/7qWNM0MMV1g)

**There is a password system built directly into the 'Multiplayer' screen of the main menu, which is enabled on all servers by default.**

### Steps:

1. **Make sure java is installed and on your system PATH**
2. Download and extract **[multiplayer-download.zip](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/stable-download/multiplayer-download.zip)** to a new folder
3. Go in the `server` folder
4. If on windows, double click `run.bat`
5. If on mac or linux, open terminal and run `chmod +x run_unix.sh`, and then `./run_unix.sh`
6. **Use the console to set passwords for all of your and your friends' usernames:**

    - `set-password <username> <password> never`

    **To set a temporary password that will expire, use this syntax:**

    - `set-password <username> <password> [expires][s|m|h|d|w]`

    **Examples:**

    - `set-password lax1dude lax123 7d`
    - `set-password ayonull shit 24h`
    - `set-password ayunami2000 fard 30m`

    **YOU WILL NOT BE ABLE TO JOIN THE SERVER WITHOUT A PASSWORD BY DEFAULT!**
    
    **To change this behavior, edit `eagler.yml` in the `server` folder.**
    
7. Launch the **[offline download version](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/stable-download/Singleplayer_Offline_Download_Version.html)** from this repository and then set your username to the username you used with `set-password` on in the previous step
8. Click 'Multiplayer' on the main menu, enter `127.0.0.1:25565` as the server address, and then enter the password you set on your username in Step 6.
9. Click 'Connect', you should be able to join the server. If not, check that the `run.bat` window is still open, and that you entered the correct username and password that you used with `set-password` on Step 6.
10. **If you're okay checking for regular updates to the offline download version [here](https://github.com/LAX1DUDE/eaglercraft-beta/blob/main/stable-download/Singleplayer_Offline_Download_Version.html), or using [https://g.eags.us/eaglercraft/beta/](https://g.eags.us/eaglercraft/beta/) for WSS connections, you are now finished. Look up a guide on google to figure out how to port forward 25565 on your router to play from outside of your local network.**
11. **If you want to host your own web site with the client too, upload the contents of the `web` folder from the zip file you downloaded in Step 2 onto your website. If the website is HTTPS then the client will only be able to connect to a server running on WSS.**
12. **To get WSS, buy a domain and install nginx on your server as a reverse proxy with an SSL certificate for the domain**
13. To make your client auto connect to your server, put the `?server=<your server's ip>` parameter in the URL to your site
14. To make your client auto connect to your server without any changes to the URL, edit `web/index.html`:

    **Replace this:**
    
    ```javascript
    window.minecraftOpts = ["game_frame","assets.epk"];
    (function(){
    var q = window.location.search;
    if(typeof q === 'string' && q.startsWith("?")) {
      q = new URLSearchParams(q);
      var s = q.get("server");
      if(s) window.minecraftOpts.push(s);
    }:
    ```

    **With this:**
    
    ```javascript
    window.minecraftOpts = ["game_frame","assets.epk","<your server's ip>"];
    ```
    
    Replace `<your server's ip>` with the IP to your server. This will make the client directly open the connect screen once you're done editing your profile, with the IP address specified in this code autofilled in the address text field.
    
15. **To change your textures, make your changes in `lwjgl-rundir/resources` and then run `epkcompiler/run.bat` to generate a new `assets.epk` in the `javascript` folder where `classes.js` is. On linux/mac, open terminal and type `chmod +x run_unix.sh` and then `./run_unix.sh` to run the tool. Copy the new `javascript/assets.epk` onto your website over the old one to update it.**

## Password System

**Edit `server/eagler.yml` to reconfigure or disable the password system.**

**To configure your server not to require a password by default, but then allow users to run `/register-password` to set a password only on their specific username, edit these options in `eagler.yml` to be these values:**

```yaml
only_allow_registered_users_to_login: false
allow_self_registration: true
```

**Passwords are stored in `passDB.dat` in your server's folder, they are encrypted and cannot be decrypted without a supercomputer. If you lose a password then just use `set-password` again from your server's console or by joining the server with an account that has `/op`.**

**Use `clear-password` to remove a password from a username**

**There's no permission system support for these commands if such a thing even exists for beta 1.3, so you are limited to just using `/op` and `eagler.yml` to control which commands users should have access to.**

## Contributing

All I really have to say is, tabs not spaces, and format the code to be like the eclipse auto format tool on factory settings, but also run-on lines of code long enough to go off the screen and single line if statements and other format violations in that category are welcome if it helps enhance the contrast between the less important code and the more important code in a file. Don't commit changes to `javascript/classes.js` or `javascript/assets.epk` or anything in `stable-download/`. I'll recompile those myself when I merge the pull request.
