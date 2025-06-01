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
        parameters: {
          "basic.to_if_alone_timeout_milliseconds": 300,
        },
        type: "basic",
      },
    ],
  },
  //
  //
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
    j: {
      description: "Homerow Scroll",
      to: [
        {
          key_code: "j",
          modifiers: ["left_shift", "left_command"],
        },
      ],
    },
    // // A11y
    // a: {
    //   j: {
    //     description: "Homerow Scroll",
    //     to: [
    //       {
    //         key_code: "h",
    //         modifiers: ["left_shift", "left_command"],
    //       },
    //     ],
    //   },
    // },
    //

    // b = "B"rowse
    b: {
      y: open("https://www.youtube.com/"),
      r: open("https://reddit.com"),
    },
    u: {
      description: "Caps Lock with accidental keystroke prevention disabled",
      to: [
        {
          hold_down_milliseconds: 100,
          key_code: "caps_lock",
        },
        {
          key_code: "vk_none",
        },
      ],
    },

    // Open App
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
      4: {
        description: "Arrange Quarter",
        to: [
          {
            key_code: "4",
            modifiers: ["left_control", "left_shift", "left_option"],
          },
        ],
      },

      // tile window

      y: {
        description: "Tile Left",
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      o: {
        description: "Tile Right",
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      i: {
        description: "Tile Top",
        to: [
          {
            key_code: "up_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      u: {
        description: "Tile Bottom",
        to: [
          {
            key_code: "down_arrow",
            modifiers: ["left_control", "fn"],
          },
        ],
      },
      6: {
        description: "Top Left Quarter",
        to: [
          {
            key_code: "1",
            modifiers: ["left_control", "left_option"],
          },
        ],
      },
      8: {
        description: "Top Right Quarter",
        to: [
          {
            key_code: "2",
            modifiers: ["left_control", "left_option"],
          },
        ],
      },
      7: {
        description: "Bottom Left Quarter",
        to: [
          {
            key_code: "3",
            modifiers: ["left_control", "left_option"],
          },
        ],
      },
      9: {
        description: "Bottom Right Quarter",
        to: [
          {
            key_code: "4",
            modifiers: ["left_control", "left_option"],
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
      // next tab
      // open_bracket: {
      //   description: "Window: Previous Tab",
      //   to: [
      //     {
      //       key_code: "tab",
      //       modifiers: ["right_command", "right_shift"],
      //     },
      //     {
      //       key_code: "escape",
      //     },
      //   ],
      // },
      // close_bracket: {
      //   description: "Window: Next Tab",
      //   to: [
      //     {
      //       key_code: "tab",
      //       modifiers: ["right_command"],
      //     },
      //     {
      //       key_code: "tab",
      //       modifiers: ["right_command"],
      //     },
      //     {
      //       key_code: "escape",
      //     },
      //   ],
      // },
      // cmd + [
      b: {
        description: "Window: Back",
        to: [
          {
            key_code: "open_bracket",
            modifiers: ["right_command"],
          },
        ],
      },
      // cmd + ]
      m: {
        description: "Window: Forward",
        to: [
          {
            key_code: "close_bracket",
            modifiers: ["right_command"],
          },
        ],
      },

      // via raycast window manager
      equal_sign: {
        description: "Make Larger",
        to: [
          {
            key_code: "equal_sign",
            modifiers: ["left_control", "left_option", "left_command"],
          },
        ],
      },
      hyphen: {
        description: "Make Smaller",
        to: [
          {
            key_code: "hyphen",
            modifiers: ["left_control", "left_option", "left_command"],
          },
        ],
      },
      0: {
        description: "Reasonable Size",
        to: [
          {
            key_code: "0",
            modifiers: ["left_control", "left_option", "left_command"],
          },
        ],
      },
    },

    // Windown Tile
    t: {
      j: open("raycast://script-commands/open-tmux-session?arguments=dotfiles"),
      k: open(
        "raycast://script-commands/open-tmux-session?arguments=karabiner"
      ),
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
      period: {
        to: [
          {
            key_code: "fastforward",
          },
        ],
      },
      comma: {
        to: [
          {
            key_code: "rewind",
          },
        ],
      },

      // Do not disturb toggle
      d: open(
        `raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`
      ),
      // Theme
      t: open(`raycast://extensions/raycast/system/toggle-system-appearance`),
      c: open("raycast://extensions/raycast/system/open-camera"),
    },

    // direction  / desktop
    // so that hjkl work like they do in vim
    d: {
      b: {
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_option"],
          },
        ],
      },
      w: {
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_option"],
          },
        ],
      },
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
    // visual mode
    v: {
      h: {
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_shift"],
          },
        ],
      },
      j: {
        to: [
          {
            key_code: "down_arrow",
            modifiers: ["left_shift"],
          },
        ],
      },
      k: {
        to: [
          {
            key_code: "up_arrow",
            modifiers: ["left_shift"],
          },
        ],
      },
      l: {
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_shift"],
          },
        ],
      },
      b: {
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_shift", "left_option"],
          },
        ],
      },
      w: {
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_shift", "left_option"],
          },
        ],
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
      c: open("raycast://script-commands/colorscheme-selector"),
      i: open("raycast://extensions/thomas/color-picker/pick-color"),
      n: open("raycast://script-commands/dismiss-notifications"),
      l: open(
        "raycast://extensions/stellate/mxstbr-commands/create-mxs-is-shortlink"
      ),
      e: open(
        "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"
      ),
      p: open("raycast://extensions/raycast/raycast/confetti"),
      // a: open("raycast://extensions/raycast/raycast-ai/ai-chat"),
      // s: open("raycast://extensions/peduarte/silent-mention/index"),
      h: open(
        "raycast://extensions/raycast/clipboard-history/clipboard-history"
      ),
      // 1: open(
      //   "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"
      // ),
      // 2: open(
      //   "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"
      // ),
    },
    l: {
      1: open("raycast://script-commands/change-input?arguments=HDMI_1"),
      2: open("raycast://script-commands/change-input?arguments=HDMI_2"),
      3: open("raycast://script-commands/change-input?arguments=HDMI_3"),
      s: open(
        "raycast://script-commands/change-sound-output?arguments=external_arc"
      ),
      m: open("raycast://script-commands/mute"),
      n: open("raycast://script-commands/send-notification-to-lgtv"),
      j: open("raycast://script-commands/turn-volume-down"),
      k: open("raycast://script-commands/turn-volume-up"),
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
          virtual_hid_keyboard: { keyboard_type_v2: "ansi" },
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
