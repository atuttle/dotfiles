My personal system config. Relies on 1password. Uses a "dotfiles" alias of git.

Published to [my personal dotfiles repo](https://github.com/atuttle/dotfiles)

---

# Dotfiles with Bare Git Repo + 1Password

## Overview

This setup uses:

- **Bare git repo** — track dotfiles without a `.git` folder in `$HOME`
- **1Password SSH Agent** — seamless git auth without loading keys/secrets
- **`op run`** — inject other secrets only when needed

---

## Part 1: 1Password SSH Agent

This is the foundation. Once configured, git push/pull just works — no wrappers, no pre-loading, no env vars. Tools like Claude Code can run git commands without special setup.

1Password acts as your SSH agent. When any process needs SSH auth, 1Password prompts for Touch ID / password. The private key never leaves 1Password.

### Setup

**Step 1: Enable in 1Password**

1Password app → Settings → Developer → Enable:

- Use the SSH Agent
- Integrate with 1Password CLI (optional but useful)

**Step 2: Point SSH to 1Password's agent**

Add to `.zshrc`: (yes this path will be the same for you, as long as you're on MacOS)

```bash
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

**Step 3: Add SSH key to 1Password**

Either:

- Import existing key: drag `~/.ssh/id_ed25519` into 1Password
- Generate new key: 1Password → New Item → SSH Key → Generate

I recommend generating a new one. It's a single button click and when was the last time you rotated your key, anyway?

**Step 4: Add public key to GitHub**

1Password shows the public key in the item. Copy it to GitHub → Settings → SSH Keys.

**Step 5: Configure allowed apps (optional)**

1Password → Settings → Developer → "Manage" under SSH Agent

You can require approval per-app, or auto-approve for trusted apps like Terminal, iTerm, VS Code.

### Verify It Works

```bash
ssh -T git@github.com
# 1Password prompts for approval → "Hi username! You've successfully authenticated"
```

Now `git push`, `git pull`, and any SSH operation work automatically — including from Claude Code.

---

## Part 2: The Bare Git Repo

A bare repo has no working directory. We set the working directory to `$HOME`, letting git track specific files without a `.git` folder cluttering your home.

### First-Time Setup (Creating the Repo)

```bash
# Initialize bare repo
git init --bare $HOME/.dotfiles

# Create alias (add this to your .zshrc)
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Critical: don't show untracked files
dotfiles config --local status.showUntrackedFiles no

# Add first files
dotfiles add ~/.zshrc ~/.gitconfig
dotfiles commit -m "initial dotfiles"

# Push to GitHub (SSH agent handles auth)
dotfiles remote add origin git@github.com:<YOU>/dotfiles.git
dotfiles push -u origin main
```

### Setting up after a computer upgrade / reformat

```bash
# Clone as bare repo
git clone --bare git@github.com:<YOU>/dotfiles.git $HOME/.dotfiles

# Create alias (temporary, until .zshrc is checked out)
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Don't show untracked files
dotfiles config --local status.showUntrackedFiles no

# Checkout files
dotfiles checkout
```

If checkout fails due to existing files:

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep -E "^\s+" | xargs -I{} mv {} ~/.dotfiles-backup/{}
dotfiles checkout
```

... then compare the files in the backup folder to the files in the repo and merge in any changes you want to keep.

### Daily Usage

```bash
dotfiles status              # what's changed?
dotfiles add ~/.config/nvim  # track new file/folder
dotfiles diff                # review changes
dotfiles commit -m "msg"     # commit
dotfiles push                # push (SSH agent handles auth)
dotfiles pull                # pull on other machines
```

I like to use `lazygit` to review the changes and merge them in, so I have this alias to load my dotfiles repo in lazygit:

```bash
alias lgdot='lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
```

---

## Part 3: Other Secrets (Non-SSH)

SSH is handled by the agent. For other secrets (API keys, tokens), use `op run` to load secrets into environment variables for the duration of the command.

For example if you use a private npm registry, and your .npmrc file uses ${NPM_TOKEN}, you could run the npm install this way:

```bash
op run --env-file="$HOME/.config/op/personal.env" -- npm install
```

Before this works, you have to create that personal.env file...

### Secret References

Create `.env` files with references, not secrets:

```bash
# ~/.config/op/personal.env (safe to commit, won't have secrets in it!)
NPM_TOKEN=op://Private/npm/token
```

### Inject at Runtime

And of course you don't want to have to remember/type that whole command every time you want to run npm install, so let's wrap it in a function in your .zshrc:

```bash
# Wrap commands that need secrets (recommended - minimal exposure)
oprun() {
  op run --env-file="$HOME/.config/op/personal.env" -- "$@"
}

# Or load into current shell (less secure - secrets persist in session)
opsession() {
  eval $(op run --env-file="$HOME/.config/op/personal.env" -- env | grep -E '^[A-Z_]+=')
}
```

**Prefer `oprun`** — secrets exist only for that command's lifetime. Use `opsession` only in throwaway shells or when you need secrets across many commands.

### What's safe to put in dotfiles repo?

| File               | In Dotfiles? | Contains                                   |
| ------------------ | ------------ | ------------------------------------------ |
| `.zshrc`           | Yes          | Aliases, functions, `SSH_AUTH_SOCK` export |
| `.gitconfig`       | Yes          | User info, aliases                         |
| `.config/op/*.env` | Yes          | Secret _references_ (`op://...`)           |
| `.env.local`       | **No**       | Actual secrets if any (gitignored)         |
| `~/.ssh/*`         | **No**       | Nothing — 1Password manages keys           |

---

## Part 4: Bootstrap Script

Automate new machine setup:

```bash
#!/bin/bash
# ~/bootstrap.sh

set -e

# Install Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install 1Password CLI (needed before we can use SSH agent)
brew install --cask 1password 1password-cli

echo "
Next steps:
1. Open 1Password, sign in
2. Enable SSH Agent: Settings → Developer → Use the SSH Agent
3. Run: dotfiles checkout
4. Restart your shell
"
```

### Brewfile

Track installed packages:

```bash
brew bundle dump --file=~/.config/.Brewfile
dotfiles add ~/.config/.Brewfile
dotfiles commit -m "add brewfile"
```

On new machine:

```bash
brew bundle --file=~/.config/.Brewfile
```

---

## Quick Reference

```bash
# Dotfiles management
dotfiles status
dotfiles add ~/.some/config
dotfiles commit -m "message"
dotfiles push
dotfiles pull

# See what's tracked
dotfiles ls-files

# Secrets (non-SSH)
oprun some-command              # inject secrets for one command
op read "op://Vault/item/field" # read a single secret

# SSH (just works via agent)
ssh -T git@github.com           # test connection
git push                        # no special wrapper needed
```
