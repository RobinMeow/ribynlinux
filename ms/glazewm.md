# glazewm

example for autostart setup using window matching rules

```
workspaces:
  - name: "1"
    # bind_to_monitor: 1
  - name: "2"
    # bind_to_monitor: 1
  - name: "3"
    # bind_to_monitor: 0
  - name: "4"
    # bind_to_monitor: 2
  - name: "5"
    # bind_to_monitor: 2
  - name: "6"
    # bind_to_monitor: 2
  - name: "7"
  - name: "8"
  - name: "9"

window_rules:
  - commands: ["ignore"]
    match:
      # Ignores any Zebar windows.
      - window_process: { equals: "zebar" }

      # Ignores picture-in-picture windows for browsers.
      - window_title: { regex: "[Pp]icture.in.[Pp]icture" }
        window_class: { regex: "Chrome_WidgetWin_1|MozillaDialogClass" }

      # Ignore rules for various 3rd-party apps.
      - window_process: { equals: "PowerToys" }
        window_class: { regex: 'HwndWrapper\[PowerToys\.PowerAccent.*?\]' }
      - window_process: { equals: "PowerToys" }
        window_title: { regex: ".*? - Peek" }
      - window_process: { equals: "Lively" }
        window_class: { regex: "HwndWrapper" }
  - commands: ["move --workspace 3"]
    match:
      # Move browsers to workspace 3.
      - window_process: { regex: "brave|zen" }
  - commands: ["move --workspace 5"]
    match:
      # Move mail clients to workspace 5.
      - window_process: { regex: "thunderbird" }
  - commands: ["move --workspace 6"]
    match:
      # Move teams to workspace 6.
      - window_process: { regex: "teams" }
```
