# Using Windows Mod Managers on Linux (Steam/Proton)

Steam's Proton creates isolated Windows environments (prefixes) for every app.
Because of this, a Windows mod manager (like Fluffy Mod Manager) won't natively
see games installed elsewhere in Steam.

**The Fix:** Create a symlink of the game directory inside the mod manager's prefix.

## Steps

1. **Install the Mod Manager:** Add the mod manager's `.exe` to Steam as a "Non-Steam Game."
In its Properties, force compatibility to Proton. Launch it once so Steam generates its prefix.
2. **Locate the Game:** Find your target game's installation folder (e.g., MHW).
* Default path: `~/.local/share/Steam/steamapps/common/<GameName>`


3. **Locate the Mod Manager Prefix:** Find where Proton installed the mod manager.
* *Tip:* Because Steam uses random ID numbers for non-Steam games, use **Protontricks**,
select the mod manager, and click "Browse files" to easily find the correct folder.
* Path format: `~/.local/share/Steam/steamapps/compatdata/<AppID>/pfx/drive_c/`


4. **Create a Symlink:** Link the game folder into the mod manager's `drive_c` directory so the manager can "see" it
* **Terminal:** `ln -s /path/to/game/ /path/to/prefix/drive_c/<GameName>`
* **Yazi:** Yank the game folder path, navigate to the mod manager's `drive_c`, and press `-` to create an absolute symlink



---

*Note: Your actual game files are installed natively on your Linux filesystem, independent of the Wine prefix directories.*


---

> Original version before i told ai to prettify it, and i didnt check what it had generated so im leaving the orig. here.

steam and proton usually takes care of your needs.

but when you want to use a windows depended mod manager like (fluffy mod mangager) to manage mods across multiple games (e.g. mhw)
it needs to "phsyically" see the game on wihtin its prefix it was installed in.
wine(and proton) will usually createa a prefix (a windows environment) for each app (or game).
so they will not see each other.

you can add windows apps like fluffy to steam as a so called "non steam game" which just points to the .exe file.
it set the properties > compatiblity to proton, and steam will create a wine prefix.
you can launch it now, but it wont see mhw yet.
just find your mhw install location in `$HOME/.local/share/Steam/steamapps/common`
and create a symlin within the fluffy wine prefx which points there.
when using yazi you can use yank and `-` to create an absolute symlink
into prefix `c_drive/mhwilds`
or manually in the terminal using `ln -l` iirc (check before use, but yazi was simpler)

> since wine prefixes are just numbers it can be hard to figure out, which wineprefix folder is actually
> the windows environment your looking for. the numbers are the same numbers steam uses to uniquely identify
> games. I used protontricks, selected fluffy than "browse files" to get the correct prefix.
> could look like this `$HOME/.local/share/Steam/steamapps/compatdata/3313835709/pfx/drive_c/`

fyi:
apps run with the help of wine, but the actual games files are installed on the linux system, and 
not within the wine prefix dir, mean independently

