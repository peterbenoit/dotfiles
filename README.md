# Front-End Developer Dotfiles

This repository contains configuration files and setup scripts I use to create an optimized front-end development environment on macOS.

**Important:** Please read the [Disclaimer](#disclaimer) section before proceeding.

## What's Included

This dotfiles repository provides:

-   **Homebrew packages** - Essential tools for front-end development
-   **Shell configuration** - Optimized zsh with useful aliases and functions
-   **VS Code settings** - Editor configuration for front-end projects
-   **Project templates** - Ready-to-use starter templates
-   **Setup scripts** - Easy installation and configuration

## Getting Started

### Basic Installation (Safe Mode)

This method applies only the essential configurations without changing system settings:

```bash
# Clone the repository
git clone https://github.com/your-username/dotfiles.git
cd dotfiles

# Make scripts executable
chmod +x setup.sh
chmod +x fe-init.sh
chmod +x macos-setup.sh

# Run basic setup (safest option)
./setup.sh --safe
```

### Full Installation (After Review)

For a complete setup including macOS optimizations:

```bash
# Install Homebrew packages
brew bundle --file=Brewfile

# Set up dotfiles
./setup.sh

# Configure macOS (optional - review first!)
./macos-setup.sh --interactive
```

## Understanding the Files

### 1. Brewfile

Contains all the software that will be installed via Homebrew, organized by categories:

-   **Programming Languages** - Node.js, Deno, Python
-   **Front-End Tools** - Package managers and build tools
-   **Testing Tools** - Frameworks for writing tests
-   **Browsers** - For testing across different engines

### 2. setup.sh

This script:

-   Creates symlinks for configuration files (.zshrc, VS Code settings)
-   Installs Node.js using Fast Node Manager (fnm)
-   Sets up global npm packages
-   Creates project templates for React, Vue, and static sites

#### setup.sh Options

| Option             | Description                                   |
| ------------------ | --------------------------------------------- |
| `--safe`           | Apply only symlinks, skip installing software |
| `--skip-templates` | Skip creating project templates               |
| `--skip-node`      | Skip installing Node.js manager               |
| `--skip-globals`   | Skip installing global npm packages           |
| `--help`           | Show help message                             |

```bash
# Examples:
./setup.sh --safe                   # Only create symlinks
./setup.sh --skip-node              # Skip Node.js manager installation
./setup.sh --skip-globals           # Skip global npm packages
./setup.sh --skip-templates         # Skip project templates creation
./setup.sh --skip-node --skip-globals  # Skip Node.js and globals
```

### 3. fe-init.sh

A tool to quickly start new front-end projects:

-   Interactive CLI for project creation
-   Supports React, Vue, Angular, and static sites
-   Adds common dependencies and configurations
-   Sets up Git repository

#### fe-init.sh Options

| Option      | Description                                    |
| ----------- | ---------------------------------------------- |
| `--dry-run` | Show what would be done without making changes |
| `--help`    | Show help message                              |

```bash
# Examples:
./fe-init.sh                  # Create a new project interactively
./fe-init.sh --dry-run        # Preview what would happen without changes
```

#### Project Types Supported

1. React with Vite
2. React + TypeScript with Vite
3. Next.js
4. Vue.js with Vite
5. Angular
6. Static HTML/CSS/JS

#### CSS Framework Options

1. Tailwind CSS
2. Styled Components
3. Material UI
4. Bootstrap

#### Backend Service Options

1. Supabase

    - Adds Supabase client libraries
    - Creates environment configuration
    - Sets up authentication components (for React/Next.js)
    - Adds examples to README

2. Firebase
    - Adds Firebase client libraries
    - Creates basic configuration file
    - Adds examples to README

### 4. macos-setup.sh

Configures macOS settings for development:

-   System UI preferences
-   Keyboard and trackpad settings
-   Development-friendly defaults
-   Terminal configuration

#### macos-setup.sh Options

| Option            | Description                      |
| ----------------- | -------------------------------- |
| `--interactive`   | Ask before applying each section |
| `--skip-ui`       | Skip UI/UX settings              |
| `--skip-keyboard` | Skip keyboard and input settings |
| `--skip-finder`   | Skip Finder settings             |
| `--skip-dock`     | Skip Dock settings               |
| `--skip-safari`   | Skip Safari settings             |
| `--skip-terminal` | Skip Terminal settings           |
| `--skip-dev`      | Skip development tool settings   |
| `--help`          | Show help message                |

```bash
# Examples:
./macos-setup.sh --interactive            # Interactive mode, ask for each section
./macos-setup.sh --skip-ui --skip-dock    # Skip UI and Dock settings
./macos-setup.sh --skip-terminal          # Skip Terminal settings only
```

#### Detailed macOS Settings

Here's what each section of `macos-setup.sh` actually changes:

1. **UI/UX Settings (`--skip-ui`)**

    - Allows setting a custom computer name
    - Expands save and print panels by default
    - Saves files to disk (not iCloud) by default
    - Disables automatic capitalization
    - Disables auto-correct

2. **Keyboard & Input Settings (`--skip-keyboard`)**

    - Enables full keyboard access for all controls
    - Configures scroll gesture with Ctrl modifier to zoom
    - Sets keyboard repeat rate for faster typing
    - May adjust key repeat delay

3. **Finder Settings (`--skip-finder`)**

    - Shows hidden files (optional)
    - Shows all filename extensions
    - Shows status bar and path bar
    - Keeps folders on top when sorting
    - Changes default search scope to current folder
    - Disables extension change warning
    - Prevents .DS_Store file creation on network/USB volumes

4. **Dock Settings (`--skip-dock`)**

    - Sets the Dock icon size to 48px
    - Minimizes windows into application icons
    - Shows indicator lights for open applications
    - Optionally enables auto-hide

5. **Safari Settings (`--skip-safari`)**

    - Shows full URLs in address bar
    - Prevents auto-opening of "safe" downloads
    - Enables Developer menu and Web Inspector
    - Enables "Do Not Track" header

6. **Terminal Settings (`--skip-terminal`)**

    - Uses UTF-8 encoding in Terminal
    - Enables Secure Keyboard Entry
    - Optionally installs Oh My Zsh

7. **Development Settings (`--skip-dev`)**
    - Configures Git user name and email if installed
    - Sets Git default branch to main
    - Sets the default Git editor to VS Code
    - Configures Git to rebase on pull

## Script Independence

Each script can be run independently:

-   **setup.sh** - Sets up your dotfiles, Node.js, and templates
-   **macos-setup.sh** - Only configures macOS settings
-   **fe-init.sh** - Only creates new projects
-   **Brewfile** - Can be used directly with `brew bundle`

You can use any script without running the others first.

## How to Use Homebrew Bundles

The Brewfile contains all the packages to install with Homebrew.

```bash
# Install everything in Brewfile
brew bundle --file=Brewfile

# Check what would be installed/upgraded without making changes
brew bundle check --file=Brewfile

# Install only what's missing
brew bundle --file=Brewfile --no-upgrade

# Install only command-line tools (no casks)
grep -v "^cask" Brewfile | brew bundle --file=-
```

## Customization Guide

### Adding New Homebrew Packages

Edit the Brewfile and add your package:

```ruby
brew "package-name"       # Brief description
```

### Adding Shell Aliases

Edit .zshrc and add your aliases:

```bash
alias myalias="command to run"
```

### Setting Up Project Templates

1. Create your template in `~/GitHub/project-templates`
2. Add generation code to setup.sh or fe-init.sh

## Complete Script Workflow

### Full Setup Process

For a new machine, this is the recommended workflow:

1. Install Homebrew:

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. Clone the dotfiles repository:

    ```bash
    git clone https://github.com/your-username/dotfiles.git
    cd dotfiles
    ```

3. Make scripts executable:

    ```bash
    chmod +x setup.sh
    chmod +x fe-init.sh
    chmod +x macos-setup.sh
    ```

4. Install software packages:

    ```bash
    brew bundle --file=Brewfile
    ```

5. Set up dotfiles:

    ```bash
    ./setup.sh
    ```

6. Configure macOS:
    ```bash
    ./macos-setup.sh --interactive
    ```

### Incremental Setup

For a more cautious approach:

1. Start with symlinks only:

    ```bash
    ./setup.sh --safe
    ```

2. Install Node.js manager:

    ```bash
    ./setup.sh --skip-templates --skip-globals
    ```

3. Install global npm packages:

    ```bash
    ./setup.sh --skip-templates --skip-node
    ```

4. Set up project templates:

    ```bash
    ./setup.sh --skip-node --skip-globals
    ```

5. Apply Finder settings only:

    ```bash
    ./macos-setup.sh --skip-ui --skip-keyboard --skip-dock --skip-safari --skip-terminal --skip-dev
    ```

6. Apply keyboard settings only:
    ```bash
    ./macos-setup.sh --skip-ui --skip-finder --skip-dock --skip-safari --skip-terminal --skip-dev
    ```

## Common Commands

### Package Management

```bash
# Update all packages
brew update && brew upgrade

# Install everything in Brewfile
brew bundle

# Clean up old versions
brew cleanup
```

### Project Initialization

```bash
# Create a new React project
./fe-init.sh
# Follow the interactive prompts
```

## Troubleshooting

### General Installation Issues

Software evolves continuously, and package names, dependencies, and installation methods may change over time. If you encounter installation issues:

```bash
# Get information about a package
brew info package-name

# Search for alternative package names
brew search keyword

# Check what would be installed before committing
brew bundle --file=Brewfile --dry-run
```

**Common issues to expect:**

-   Packages being renamed, deprecated, or moved to different repositories
-   New major versions with different installation requirements
-   Casks changing their naming conventions
-   Projects becoming unmaintained and requiring alternatives

If these scripts become outdated (which is inevitable with time), please consider:

1. Opening an issue or PR to update them
2. Checking the package's official documentation for current installation methods
3. Adapting the commands to the latest requirements

### If setup.sh fails:

-   Ensure you have write permissions to destination directories
-   Check for existing files that might conflict with symlinks
-   Try running with `--safe` flag

### For Homebrew issues:

```bash
# Check for problems
brew doctor

# Fix permissions
sudo chown -R $(whoami) /usr/local/lib/node_modules

# Update Homebrew itself
brew update

# If a formula is broken or outdated, try the developer's repo
brew tap author/repository
```

### For Homebrew symlink conflicts:

If you see errors about existing symlinks when installing via Homebrew, you can resolve them with:

```bash
# For example, with gulp-cli:
rm '/opt/homebrew/bin/gulp'
brew link gulp-cli

# Or force overwrite all conflicting files:
brew link --overwrite gulp-cli
```

This happens when you've previously installed packages via npm globally and are now installing via Homebrew.

### For cask naming issues:

If you receive "Cask is unavailable" errors:

```bash
# Search for the correct cask name
brew search firefox

# Use the exact cask name in your Brewfile
# For example: cask "firefox@developer-edition" instead of cask "firefox-developer-edition"
```

### For macOS settings issues:

-   Some settings require a logout/restart to take effect
-   If a setting causes problems, use the specific `--skip-X` option
-   Apple frequently changes system preferences interfaces and APIs across macOS versions

### For project initialization issues:

-   Use `--dry-run` to preview what would happen
-   Ensure Node.js and npm are correctly installed
-   Check for updates to the frameworks being used (React, Vue, etc.)

## Disclaimer

```
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

**IMPORTANT NOTICE**: These scripts modify system settings and install software on your computer. While they have been created with care, they may not be suitable for all environments or configurations. The author(s) cannot be held responsible for any system instability, data loss, or other issues that may arise from using these dotfiles and scripts.

Before running any scripts:

-   **Back up your data**
-   **Review the code** to understand what changes will be made
-   **Use the `--safe` or `--dry-run` flags** when available to preview changes
-   **Consider running scripts incrementally** rather than all at once

If you're unsure about any aspect of these scripts, run them in a test environment first or consult with someone knowledgeable about macOS system configuration.

Remember: If something breaks, you assume all responsibility for fixing it. When in doubt, don't run it.
