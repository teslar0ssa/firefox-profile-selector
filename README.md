## Firefox Profile Selector

I slapped together this silly little thing to allow me to choose which Firefox profile external links opened in. 
It's only been tested on Fedora 41, Gnome 47, and Firefox 135.0. I mostly uploaded it so I don't lose it, but if anyone can fix the Known Issues, I won't turn a PR away.

1. Create `~/.firefox-profile-selector/`
2. Place both files in the newly created folder
3. `chmod +x` the firefox-profile-selector.sh file
4. symlink firefox-profile-selector.sh to ~/.local/bin/firefox-profile-selector.sh
5. symlink firefox-profile-selector.desktop to ~/.local/share/applications/firefox-profile-selector.desktop
6. Change the default app for opening webpage links to be "Firefox Profile Selector"

# Known Issues
For the life of me I cannot figure out why this happens. If you have the script launch a browser profile that does not already have an instance running, it will crash on close. Things tried:
1. Launching Firefox as normal
2. Launching Firefox with `setsid ... > /dev/null 2>&1 &`
3. Launching Firefox with `nohup ... > /dev/null 2>&1 &`
4. Same as #3, but adding a `sleep 5` to slow down the script termination just in case
5. Same as #3, but running `disown` after
6. Give up and disable the Firefox crash reporter...this just generated an OS crash report
7. Launching Firefox with a systemd-run --user --scope
8. Detecting if a profile has a running instance (*using `lsof` against the prolfie dir), if no running instance launch Firefox first, wait a bit, then launch again to open a tab.

So far, all items above caused a crash on closing Firefox if the initial instance in a given profile was created by the script. Good luck, I just pre-launch one browser for each of my profiles as I use this to jump between a work and persoanl profile. 
