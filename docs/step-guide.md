# macOS Setup Guide

## Introduction

This guide will help you set up your macOS development environment.

## Prerequisites

-   Ensure you have the latest version of macOS installed.
-   Install Xcode from the App Store.
-   Install Xcode Command Line Tools by running `xcode-select --install`.

## Audit Your Current Setup (Recommended)

Before making any changes, it's recommended to capture the current state of your development environment. This helps track changes and avoid regressions.

Run the following command:

```bash
./scripts/audit-env.sh
```

This will save the following details into `docs/_installed/`:

-   Homebrew formulae and casks
-   Brew taps
-   Global npm and pip3 packages
-   pyenv-installed Python versions
-   Deno environment info
-   VS Code extensions
-   Installed tool paths

## Step 1: Brewfile & Homebrew

-   Convert your Brewfile into a `brew bundle`–compatible format so you can `brew bundle install` in one command.
-   Add modern CLI tools: `ripgrep`, `bat`, `fd`, `gh` (GitHub CLI), `exa`, `starship`, `zoxide`.
-   Organize entries by `tap`, `brew`, and `cask`, and consider pinning versions for reproducibility.
-   Document usage: `brew bundle dump` and `brew bundle install` in your README.

## Step 2: Install Oh My Zsh

-   Install Oh My Zsh by running `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`.
-   Set Zsh as your default shell: `chsh -s $(which zsh)`.

## Step 3: Configure Zsh

-   Copy the default `.zshrc` configuration file: `cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc`.
-   Customize your `.zshrc` file to suit your preferences.
-   Install Zsh plugins and themes as needed.

## Step 4: Install and Configure Git

-   Install Git using Homebrew: `brew install git`.
-   Set up your Git configuration:
    ```sh
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    ```
-   Generate an SSH key and add it to your GitHub account:
    ```sh
    ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
    ssh-add ~/.ssh/id_rsa
    pbcopy < ~/.ssh/id_rsa.pub
    ```
-   Follow the instructions on GitHub to add the SSH key to your account.

## Step 5: Install Node.js and npm

-   Install Node.js and npm using Homebrew: `brew install node`.
-   Verify the installation:
    ```sh
    node -v
    npm -v
    ```

## Step 6: Install Python and pip

-   Install Python using Homebrew: `brew install python`.
-   Verify the installation:
    ```sh
    python3 -V
    pip3 -V
    ```

## Step 7: Install Docker

-   Install Docker Desktop for Mac from the [Docker website](https://www.docker.com/products/docker-desktop).
-   Follow the installation instructions on the website.

## Conclusion

You have successfully set up your macOS development environment. Happy coding!

```

```
