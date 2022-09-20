# Dotfiles for Mac

dotfiles for mac. `n'joy!`

---
**Table of Contents**

[ToC]

---

## Installation

1. Clone this repository
2. run `./install fresh`

### Brave plugins worth your time

- [I don't care about cookies](https://chrome.google.com/webstore/detail/i-dont-care-about-cookies/fihnjjcciajhdojfnbdddfaoknhalnja)
- [Privacy Redirect](https://chrome.google.com/webstore/detail/privacy-redirect/pmcmeagblkinmogikoikkdjiligflglb)
- [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)
- [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
- [ClearURLs](https://chrome.google.com/webstore/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk)
- [SponsorBlock](https://chrome.google.com/webstore/detail/clearurls/mnjggcdmjocbbbhaepdhchncahnbgone)
- [YouTube NonStop](https://chrome.google.com/webstore/detail/youtube-nonstop/nlkaejimjacpillmajjnopmpbkbnocid)

#### Vimium settings

```
{
  "settingsVersion": "1.67",
  "exclusionRules": [
    {
      "pattern": "https?://mail.google.com/*",
      "passKeys": ""
    }
  ],
  "filterLinkHints": false,
  "waitForEnterForFilteredHints": true,
  "hideHud": false,
  "keyMappings": "# Insert your preferred key mappings here.",
  "linkHintCharacters": "asdfgcre",
  "linkHintNumbers": "sadfjklewcmpgh",
  "newTabUrl": "about:newtab",
  "nextPatterns": "next,more,newer,>,›,→,»,≫,>>",
  "previousPatterns": "prev,previous,back,older,<,‹,←,«,≪,<<",
  "regexFindMode": false,
  "ignoreKeyboardLayout": false,
  "scrollStepSize": 60,
  "smoothScroll": true,
  "grabBackFocus": false,
  "searchEngines": "w: https://www.wikipedia.org/w/index.php?title=Special:Search&search=%s Wikipedia\n\n# More examples.\n#\n# (Vimium supports search completion Wikipedia, as\n# above, and for these.)\n#\n# g: https://www.google.com/search?q=%s Google\n# l: https://www.google.com/search?q=%s&btnI I'm feeling lucky...\n# y: https://www.youtube.com/results?search_query=%s Youtube\n# gm: https://www.google.com/maps?q=%s Google maps\n# b: https://www.bing.com/search?q=%s Bing\n# d: https://duckduckgo.com/?q=%s DuckDuckGo\n# az: https://www.amazon.com/s/?field-keywords=%s Amazon\n# qw: https://www.qwant.com/?q=%s Qwant",
  "searchUrl": "https://duckduckgo.com/?q=",
  "userDefinedLinkHintCss": "div > .vimiumHintMarker {\n/* linkhint boxes */\nbackground: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFF785),\n  color-stop(100%,#FFC542));\nborder: 1px solid #E3BE23;\n}\n\ndiv > .vimiumHintMarker span {\n/* linkhint text */\ncolor: black;\nfont-weight: bold;\nfont-size: 12px;\n}\n\ndiv > .vimiumHintMarker > .matchingCharacter {\n}"
}
```

#### SponsorBlock settings

```
{
  "autoSkipOnMusicVideosUpdate": true,
  "categoryPillUpdate": true,
  "categorySelections": [
    {
      "name": "sponsor",
      "option": 2
    },
    {
      "name": "intro",
      "option": 2
    },
    {
      "name": "outro",
      "option": 2
    },
    {
      "name": "interaction",
      "option": 2
    },
    {
      "name": "selfpromo",
      "option": 2
    },
    {
      "name": "preview",
      "option": 1
    },
    {
      "name": "poi_highlight",
      "option": 1
    },
    {
      "name": "exclusive_access",
      "option": 0
    }
  ],
  "dontShowNotice": true,
  "exclusive_accessCategoryAdded": true,
  "hideInfoButtonPlayerControls": true,
  "invidiousInstances": [
    "inv.cthd.icu",
    "inv.riverside.rocks",
    "invidio.xamh.de",
    "invidious.kavin.rocks",
    "invidious.namazso.eu",
    "invidious.osi.kr",
    "invidious.snopyta.org",
    "vid.puffyan.us",
    "yewtu.be",
    "youtube.076.ne.jp",
    "yt.artemislena.eu"
  ],
  "isVip": false,
  "minutesSaved": 8169.081173079971,
  "previewCategoryUpdate": true,
  "showDonationLink": false,
  "skipCount": 5544,
  "sponsorTimesContributed": 6,
  "submissionCountSinceCategories": 6,
  "supportInvidious": true,
  "unsubmittedSegments": {
    "1cHXjnli2fI": [
      {
        "UUID": "NaXGWomyP92OtnUoX9OnVl8nC3Twl475d8Wq",
        "actionType": "skip",
        "category": "chooseACategory",
        "segment": [
          379.205,
          379.475
        ],
        "source": 1
      }
    ],
    "2QenOBXcb7U": [
      {
        "UUID": null,
        "category": "chooseACategory",
        "segment": [
          47.301179,
          47.301179
        ]
      }
    ],
    "AUSkT70aMWo": [
      {
        "UUID": "qQllGUdj5DMaHwTjqQ5oPtHoNL0akev7Y3K9",
        "actionType": "skip",
        "category": "chooseACategory",
        "segment": [
          31.868,
          34.02
        ],
        "source": 1
      }
    ],
    "EvGOlAkLSLw": [
      {
        "UUID": null,
        "actionType": "skip",
        "category": "chooseACategory",
        "segment": [
          4739.844179,
          4747.577768
        ],
        "source": 1
      }
    ],
    "HR4TU5t69oM": [
      {
        "UUID": null,
        "category": "chooseACategory",
        "segment": [
          275.106428
        ]
      }
    ],
    "MEbu6ydfp84": [
      {
        "UUID": null,
        "actionType": "skip",
        "category": "chooseACategory",
        "segment": [
          941.752
        ],
        "source": 1
      }
    ],
    "RM8kA5Q3Lyc": [],
    "YvzEZ88x7Tc": [
      {
        "UUID": "nESWwWewkMHVDQGqWpo0clxh74nGlEBQH5tj",
        "actionType": "skip",
        "category": "chooseACategory",
        "segment": [
          0
        ],
        "source": 1
      }
    ],
    "_-0J49_9lwc": [
      {
        "UUID": null,
        "category": "chooseACategory",
        "segment": [
          1048.213983
        ],
        "source": 1
      }
    ],
    "_KVnLdGDVBs": [
      {
        "UUID": null,
        "category": "chooseACategory",
        "segment": [
          304.167819
        ],
        "source": 1
      }
    ],
    "nl1tZx9knzA": [
      {
        "UUID": null,
        "category": "outro",
        "segment": [
          376.404565,
          384.9273
        ]
      }
    ],
    "wd4KB8htz70": [
      {
        "UUID": null,
        "category": "chooseACategory",
        "segment": [
          38.846609
        ]
      }
    ]
  },
  "userID": "HlTTbbXP9Z8fGbOcgxkDLAPqgBc0lrQiN3wq",
  "defaultCategory": "chooseACategory",
  "whitelistedChannels": [],
  "forceChannelCheck": false,
  "showTimeWithSkips": true,
  "disableSkipping": false,
  "muteSegments": true,
  "fullVideoSegments": true,
  "trackViewCount": true,
  "trackViewCountInPrivate": true,
  "trackDownvotes": true,
  "noticeVisibilityMode": 3,
  "hideVideoPlayerControls": false,
  "hideDeleteButtonPlayerControls": false,
  "hideUploadButtonPlayerControls": false,
  "hideSkipButtonPlayerControls": false,
  "hideDiscordLaunches": 0,
  "hideDiscordLink": false,
  "serverAddress": "https://sponsor.ajay.app",
  "minDuration": 0,
  "skipNoticeDuration": 4,
  "audioNotificationOnSkip": false,
  "checkForUnlistedVideos": false,
  "testingServer": false,
  "refetchWhenNotFound": true,
  "ytInfoPermissionGranted": false,
  "allowExpirements": true,
  "showPopupDonationCount": 0,
  "donateClicked": 0,
  "autoHideInfoButton": true,
  "autoSkipOnMusicVideos": false,
  "scrollToEditTimeUpdate": false,
  "darkMode": true,
  "showCategoryGuidelines": true,
  "categoryPillColors": {},
  "skipKeybind": {
    "key": "Enter"
  },
  "startSponsorKeybind": {
    "key": ";"
  },
  "submitKeybind": {
    "key": "'"
  },
  "colorPalette": {
    "red": "#780303",
    "white": "#ffffff",
    "locked": "#ffc83d"
  },
  "barTypes": {
    "preview-chooseACategory": {
      "color": "#ffffff",
      "opacity": "0.7"
    },
    "sponsor": {
      "color": "#00d400",
      "opacity": "0.7"
    },
    "preview-sponsor": {
      "color": "#007800",
      "opacity": "0.7"
    },
    "selfpromo": {
      "color": "#ffff00",
      "opacity": "0.7"
    },
    "preview-selfpromo": {
      "color": "#bfbf35",
      "opacity": "0.7"
    },
    "exclusive_access": {
      "color": "#008a5c",
      "opacity": "0.7"
    },
    "interaction": {
      "color": "#cc00ff",
      "opacity": "0.7"
    },
    "preview-interaction": {
      "color": "#6c0087",
      "opacity": "0.7"
    },
    "intro": {
      "color": "#00ffff",
      "opacity": "0.7"
    },
    "preview-intro": {
      "color": "#008080",
      "opacity": "0.7"
    },
    "outro": {
      "color": "#0202ed",
      "opacity": "0.7"
    },
    "preview-outro": {
      "color": "#000070",
      "opacity": "0.7"
    },
    "preview": {
      "color": "#008fd6",
      "opacity": "0.7"
    },
    "preview-preview": {
      "color": "#005799",
      "opacity": "0.7"
    },
    "music_offtopic": {
      "color": "#ff9900",
      "opacity": "0.7"
    },
    "preview-music_offtopic": {
      "color": "#a6634a",
      "opacity": "0.7"
    },
    "poi_highlight": {
      "color": "#ff1684",
      "opacity": "0.7"
    },
    "preview-poi_highlight": {
      "color": "#9b044c",
      "opacity": "0.7"
    },
    "filler": {
      "color": "#7300FF",
      "opacity": "0.9"
    },
    "preview-filler": {
      "color": "#2E0066",
      "opacity": "0.7"
    }
  }
}
```

#### uBlockOrigin settings

```
{
  "timeStamp": 1663678559558,
  "version": "1.44.2",
  "userSettings": {
    "advancedUserEnabled": true,
    "importedLists": [],
    "popupPanelSections": 63,
    "showIconBadge": false,
    "webrtcIPAddressHidden": true
  },
  "selectedFilterLists": [
    "ublock-quick-fixes",
    "user-filters",
    "assets.json",
    "public_suffix_list.dat",
    "ublock-badlists",
    "ublock-filters",
    "ublock-badware",
    "ublock-privacy",
    "ublock-abuse",
    "ublock-unbreak",
    "easylist",
    "easyprivacy",
    "urlhaus-1",
    "plowe-0"
  ],
  "hiddenSettings": {},
  "whitelist": [
    "about-scheme",
    "chrome-extension-scheme",
    "chrome-scheme",
    "edge-scheme",
    "moz-extension-scheme",
    "opera-scheme",
    "vivaldi-scheme",
    "wyciwyg-scheme"
  ],
  "dynamicFilteringString": "behind-the-scene * * noop\nbehind-the-scene * inline-script noop\nbehind-the-scene * 1p-script noop\nbehind-the-scene * 3p-script noop\nbehind-the-scene * 3p-frame noop\nbehind-the-scene * image noop\nbehind-the-scene * 3p noop",
  "urlFilteringString": "",
  "hostnameSwitchesString": "no-large-media: behind-the-scene false",
  "userFilters": ""
}
```

## What do we have here?

### terminal spotlight

Terminal based spotlight. Just hit `alt+space`.

You can customize available options in ~/bin/spotlight_commands/

### Productivity utilities

- `bls` : interactive brew list all available formulae and casks
- `buu` : brew update & upgrade
- `calendar` : interactive _cal_ implementation
- `gic` : git add && git commit -m "WIP|your message"
- `gip` : git push orignn $(git_branch_read)
- `gicp` : gic + gip
- `ginah` : git reset haaaard
- `gis` : git status
- `git_branch_read` : find out the name of the current branch in the current directory
- `giu` : git config user.name|email setting with one-line
- `macupdate` : force macupdates from the command line
- `micm` : toggle microphone input volume
- `note` : (very wip) quickly add a quick note just from the terminal
- `popup` : have a terminal window popup with any content!
- `purge-dstore` : recursivelly remove .DS_Store files
- `spotlight` : alt+space & n'joy!

### Window management

Yabai + skhd = :heart:

### Firewall

Lulu installed by default

### Neovim

isn't it d'best?

### Apps

- alacritty
- brave-browser
- caffeine
- itsycal
- firefox
- keepassxc
- keycastr
- losslesscut
- lulu
- openoffice
- shottr
- slack
- sublime-text
- vlc
- vscodium
- xbar

### Sensible macos defaults

see most up2date information in [/osx/defaults](/osx/defaults)

- Close preferences window
- Set computer name (as done via System Preferences → Sharing)
- bash is better than ZSH
- Set highlight color to green
- Disable Notification Center and remove the menu bar icon
- Show battery percentage
- Adjust toolbar title rollover delay
- Trash: disable warning on empty
- Keep folders on top when sorting by name
- When performing a search, search the current folder by default
- Finder fine tuning
- Disable the warning when changing a file extension
- Disable opening and closing window animations
- Expand save panel by default
- Finder: disable window animations and Get Info animations
- Disable startup sound
- Disable audio feedback when volume is changed
- Disable audio feedback beeps
- Increase sound quality for Bluetooth headphones/headsets
- Keyboard: fast repeat
- Keyboard: disable letter popup on hold
- Disable press-and-hold for keys in favor of key repeat
- Disable smart quotes and dashes as they’re annoying when typing code
- Disable auto-correct
- Enable full keyboard access for all controls
- Stop iTunes from responding to the keyboard media keys
- Trackpad: disable Fore Click haptic feedback
- Trackpad: disable DragLock
- Trackpad: disable Dragging
- Trackpad: three finger drag
- Trackpad: enable tap to click for this user and for the login screen
- Trackpad: Faster pointer
- Map 'click or tap with two fingers' to the secondary click
- Enable FileVault
- Disable captive control
- Enable firewall
- Disable time machine
- Prevent Time Machine from prompting to use new hard drives as backup volume
- Require password immediately after sleep or screen saver begins
- Prevent Photos from opening automatically when devices are plugged in
- Enable HiDPI display modes (requires restart)
- instead of sliding entire screen left/right, cross-fade... less jarring
- Make menubar always white (and turn off transparency everywhere)
- Disable launchpad finger swipes
- Disable expose finger swipes
- Don't show recently used applications in the Dock
- Dock: magnify
- Dock: remove all app icons
- Dock: hidden icons are transparent and small
- Dock: position right
- Do not show app indicators in Dock
- Disable autocorrect and key substitutions
- Show all processes in Activity Monitor
- Set login screen welcome text
- Disable automatic signed software whitelisting
- Disable automatic software whitelisting
- Disable console logon from the logon screen
- AC display sleep timer
- Battery display sleep timer
- Don’t automatically rearrange Spaces based on most recent use
- Disable hot corners
- Speed up Mission Control animations
- Save to disk (not to iCloud) by default
- Disable the crash reporter
- Enable subpixel font rendering on non-Apple LCDs
- Avoid creating .DS_Store files on network or USB volumes
- Disable the sudden motion sensor as it’s not useful for SSDs
- advertising
- Disable spotlight bloat
