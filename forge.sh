#!/usr/bin/env bash
set -euo pipefail

# --- Locate this script's directory ---
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# --- Load .env ---
env_file="$script_dir/.env"
if [ -f "$env_file" ]; then
  set -a
  . "$env_file"
  set +a
else
  echo "ERROR: .env not found"
  exit 1
fi

# --- Call navi to pick a prompt ---
export NAVI_PATH="$NAVI_PROMPTS_PATH"
filled_prompt="$(navi --print || true)"

# --- Send the prompt to the API endpoint ---
api_response="$(curl -sS https://api.openai.com/v1/responses \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
        --arg model "$MODEL" \
        --arg content "$filled_prompt" \
        '{model:$model, input:$content}' \
     )"
)"

# --- Extract answer from API response ---
answer="$(
  printf '%s' "$api_response" \
    | jq -r '.output[0].content[0].text // empty'
)"

if [ -z "$answer" ]; then
  echo "Could not find text in response. Raw payload:"
  printf '%s\n' "$api_response"
  exit 1
fi

# --- Print result ---
echo
echo "──────────────── RESPONSE ────────────────"
printf '%s\n' "$answer"
echo "──────────────────────────────────────────"
