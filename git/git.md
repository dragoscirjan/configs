# Git Tools

- [Git Tools](#git-tools)
  - [Installation](#installation)
    - [Minimal Installation](#minimal-installation)
    - [Individual Tools](#individual-tools)
      - [Git](#git)
      - [GitKraken](#gitkraken)
      - [GitHub CLI](#github-cli)
      - [LazyGit](#lazygit)
  - [Configuration](#configuration)
    - [Git Config](#git-config)
    - [Useful Git Aliases](#useful-git-aliases)
      - [Alias Details](#alias-details)

## Installation

### Minimal Installation

To install a minimal set of Git tools (Git, GitKraken, and GitHub CLI):

```bash
# Install minimal set using Task
task minimal
```

### Individual Tools

#### Git

```bash
# Install Git using Task
task git
```

#### GitKraken

```bash
# Install GitKraken using Task
task gitkraken
```

#### GitHub CLI

```bash
# Install GitHub CLI using Task
task gh
```

#### LazyGit

```bash
# Install LazyGit using Task
task lazygit
```

## Configuration

### Git Config

To use the predefined Git configuration:

```bash
# Backup existing gitconfig and link the new one
task gitconfig
```

This will:
1. Backup your existing `.gitconfig` if it exists (with timestamp)
2. Create a symbolic link to the configuration in this repository

### Useful Git Aliases

The Git configuration includes the following useful aliases:

```bash
# Pull from origin with current branch name
git pll

# Push to origin with current branch name
git psh

# View commit history in a compact format with author information
git lol

# View commit history with a graph visualization
git graph
```

#### Alias Details

- `pll`: Pull from origin using the current branch name
  ```
  git pll
  # Equivalent to: git pull origin <current-branch>
  ```

- `psh`: Push to origin using the current branch name
  ```
  git psh
  # Equivalent to: git push origin <current-branch>
  ```

- `lol`: Show commit history in a one-line format with decorations and author info
  ```
  git lol
  # Equivalent to: git log --pretty=format:"%C(auto)%h %d %s %C(green)(%an <%ae>)" --decorate --all
  ```

- `graph`: Show commit history with an ASCII graph visualization
  ```
  git graph
  # Equivalent to: git log --oneline --graph --decorate --all
  ```
