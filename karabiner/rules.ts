import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, rectangle, shell } from "./utils";

const rules: KarabinerRules[] = [
  // Define the Hyper key itself
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            key_code: "escape",
          },
        ],
        type: "basic",
      },
    ],
  },
  ...createHyperSubLayers({
    spacebar: {
      description: "Homerow",
      to: [
        {
          key_code: "spacebar",
          modifiers: ["left_shift", "left_command"],
        },
      ],
    },
    l: {
      description: "Homerow",
      to: [
        {
          key_code: "j",
          modifiers: ["left_command", "left_shift"],
        },
      ],
    },
    // b = "B"rowse
    b: {
      y: open("https://www.youtube.com/"),
      r: open("https://reddit.com"),
    },

    // open
    o: {
      t: app("Ghostty"),
      b: app("Safari"),
      spacebar: app("ChatGPT"),

      i: app("Messages"),
      p: app("Passwords"),

      n: app("Notes"),
      m: app("Mail"),

      f: app("Finder"),
    },

    // quick access
    q: {
      j: app("Ghostty"),
      k: app("Safari"),
      spacebar: app("ChatGPT"),

      i: app("Messages"),
      p: app("Passwords"),

      n: app("Notes"),
      m: app("Mail"),

      l: app("Finder"),
    },

    // Window Management
    w: {
      // general
      f: {
        description: "Fill",
        to: [
          {
            key_code: "f",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      c: {
        description: "Center",
        to: [
          {
            key_code: "c",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      r: {
        description: "Return to Previous Size",
        to: [
          {
            key_code: "r",
            modifiers: ["left_control", "fn"],
          },
        ],
      },

      // arrange windows
      h: {
        description: "Arrange Left",
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_control", "left_shift", "fn"],
          },
        ],
      },
      l: {
        description: "Arrange Right",
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_control", "left_shift", "fn"],
          },
        ],
      },
      k: {
        description: "Arrange Top",
        to: [
          {
            key_code: "up_arrow",
            modifiers: ["left_control", "left_shift", "fn"],
          },
        ],
      },
      j: {
        description: "Arrange Bottom",
        to: [
          {
            key_code: "down_arrow",
            modifiers: ["left_control", "left_shift", "fn"],
          },
        ],
      },

      // window navigation
      // next window (same app)
      n: {
        description: "Window: Next Window",
        to: [
          {
            key_code: "grave_accent_and_tilde",
            modifiers: ["right_command"],
          },
        ],
      },
      u: {
        description: "Window: Previous Tab",
        to: [
          {
            key_code: "tab",
            modifiers: ["right_control", "right_shift"],
          },
        ],
      },
      i: {
        description: "Window: Next Tab",
        to: [
          {
            key_code: "tab",
            modifiers: ["right_control"],
          },
        ],
      },
      // // cmd + [
      // b: {
      //   description: "Window: Back",
      //   to: [
      //     {
      //       key_code: "open_bracket",
      //       modifiers: ["right_command"],
      //     },
      //   ],
      // },
      // // cmd + ]
      // m: {
      //   description: "Window: Forward",
      //   to: [
      //     {
      //       key_code: "close_bracket",
      //       modifiers: ["right_command"],
      //     },
      //   ],
      // },
    },

    // Windown Tile
    t: {
      h: {
        description: "Tile Left",
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      l: {
        description: "Tile Right",
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      k: {
        description: "Tile Top",
        to: [
          {
            key_code: "up_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      j: {
        description: "Tile Bottom",
        to: [
          {
            key_code: "down_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
    },

    // s = "System"
    s: {
      u: {
        to: [
          {
            key_code: "display_brightness_decrement",
          },
        ],
      },
      j: {
        to: [
          {
            key_code: "volume_decrement",
          },
        ],
      },
      i: {
        to: [
          {
            key_code: "display_brightness_increment",
          },
        ],
      },
      k: {
        to: [
          {
            key_code: "volume_increment",
          },
        ],
      },
      // lock screen
      l: {
        to: [
          {
            key_code: "q",
            modifiers: ["right_control", "right_command"],
          },
        ],
      },
      p: {
        to: [
          {
            key_code: "play_or_pause",
          },
        ],
      },
      semicolon: {
        to: [
          {
            key_code: "fastforward",
          },
        ],
      },
      // unassigned: {
      //   to: [
      //     {
      //       key_code: "rewind",
      //     },
      //   ],
      // },

      // Do not disturb toggle
      d: open(
        `raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`
      ),
      // Theme
      t: open(`raycast://extensions/raycast/system/toggle-system-appearance`),
      c: open("raycast://extensions/raycast/system/open-camera"),
    },

    // direction
    // so that hjkl work like they do in vim
    d: {
      h: {
        to: [{ key_code: "left_arrow" }],
      },
      j: {
        to: [{ key_code: "down_arrow" }],
      },
      k: {
        to: [{ key_code: "up_arrow" }],
      },
      l: {
        to: [{ key_code: "right_arrow" }],
      },
      u: {
        to: [{ key_code: "page_down" }],
      },
      i: {
        to: [{ key_code: "page_up" }],
      },
    },

    // c = Musi*c* which isn't "m" because we want it to be on the left hand
    c: {
      p: {
        to: [{ key_code: "play_or_pause" }],
      },
      n: {
        to: [{ key_code: "fastforward" }],
      },
      b: {
        to: [{ key_code: "rewind" }],
      },
    },

    // r = "Raycast"
    r: {
      c: open("raycast://extensions/thomas/color-picker/pick-color"),
      n: open("raycast://script-commands/dismiss-notifications"),
      l: open(
        "raycast://extensions/stellate/mxstbr-commands/create-mxs-is-shortlink"
      ),
      e: open(
        "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"
      ),
      p: open("raycast://extensions/raycast/raycast/confetti"),
      a: open("raycast://extensions/raycast/raycast-ai/ai-chat"),
      s: open("raycast://extensions/peduarte/silent-mention/index"),
      h: open(
        "raycast://extensions/raycast/clipboard-history/clipboard-history"
      ),
      1: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"
      ),
      2: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"
      ),
    },
  }),
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: false,
      },
      profiles: [
        {
          name: "Default",
          complex_modifications: {
            rules,
          },
        },
      ],
    },
    null,
    2
  )
);
