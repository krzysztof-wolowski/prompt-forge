# 📦 Prompt Forge
A tiny CLI tool for selecting parameterized prompts using **navi** and sending them to OpenAI’s **Responses API** (GPT-5.1, GPT-4o, etc.).

The workflow:

1. You store prompts as **cheats** in the `cheats/` directory
2. You run `./forge.sh`
3. **navi** opens and lets you pick + fill a prompt
4. The filled text is sent to OpenAI
5. The model’s answer is printed in your terminal

Simple. File-based. Fast.

---

## ⚠️ Dependency: navi (mandatory)

This project depends heavily on **navi** — it serves as the prompt picker, parameter filler, and fuzzy search engine.

Install it first:

### macOS (Homebrew)
```bash
brew install navi
```

### Linux
Use your package manager if available, or follow the GitHub instructions below.

### Other installation options
See the official repo:  
https://github.com/denisidoro/navi

### Verify installation
```bash
navi --version
```

If this command works, you’re good.

---

## 📁 Project structure

```
prompt-forge/
  cheats/
    test.cheat         # sample prompt
  forge.sh             # main script
  .env                 # your secrets & config (ignored)
  .env.example         # template for .env
```

Prompts live in simple `.cheat` files.  
A cheat file may contain one or many prompts.

Example:

````
% put, your, tags, here

# Echo a thing
```
Repeat this back to me: "{{thing}}".
```
````

When running `forge.sh`, navi will ask for `thing` and fill the template.

---

## 🔧 Configuration (.env)

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Edit `.env` and fill:

```
OPENAI_API_KEY="sk-your-api-key"
MODEL="gpt-5.1"
NAVI_PROMPTS_PATH="$PWD/cheats"
```

---

## ▶️ Usage

Run:

```bash
./forge.sh
```

You will see:

- A fuzzy selector from navi
- A form to enter parameter values
- A clean ChatGPT response printed to the terminal

Example:

```
──────────────── RESPONSE ────────────────
"hello".
──────────────────────────────────────────
```

---
