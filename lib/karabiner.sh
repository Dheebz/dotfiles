#!/usr/bin/env bash
set -euo pipefail

configure_capslock_hyper() {
  local cfg="$HOME/.config/karabiner/karabiner.json"
  mkdir -p "$(dirname "$cfg")"

  cat > "$cfg" <<'EOF'
{
  "profiles": [{
    "name": "Default",
    "selected": true,
    "complex_modifications": {
      "rules": [{
        "description": "Caps → Hyper / Esc",
        "manipulators": [{
          "type": "basic",
          "from": { "key_code": "caps_lock" },
          "to": [{ "key_code": "left_shift", "modifiers": ["left_control","left_option","left_command"] }],
          "to_if_alone": [{ "key_code": "escape" }]
        }]
      }]
    }
  }]
}
EOF
}
