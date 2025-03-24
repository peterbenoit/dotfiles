# Front-End Developer Dotfiles

This repository contains configuration files and setup scripts that I use to create an optimized front-end development environment on macOS. YMMV.

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

### 3. fe-init.sh

A tool to quickly start new front-end projects:

-   Interactive CLI for project creation
-   Supports React, Vue, Angular, and static sites
-   Adds common dependencies and configurations
-   Sets up Git repository

### 4. macos-setup.sh

Configures macOS settings for development:

-   System UI preferences
-   Keyboard and trackpad settings
-   Development-friendly defaults
-   Terminal configuration

## Customization Guide

### Adding New Homebrew Packages

Edit the `Brewfile` and add your package:

```ruby
brew "package-name"       # Brief description
```

### Adding Shell Aliases

Edit `.zshrc` and add your aliases:

```bash
alias myalias="command to run"
```

### Setting Up Project Templates

1. Create your template in `~/GitHub/project-templates`
2. Add generation code to `setup.sh` or `fe-init.sh`

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
```

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
- **Back up your data**
- **Review the code** to understand what changes will be made
- **Use the `--safe` or `--dry-run` flags** when available to preview changes
- **Consider running scripts incrementally** rather than all at once

If you're unsure about any aspect of these scripts, run them in a test environment first or consult with someone knowledgeable about macOS system configuration.

Remember: If something breaks, you assume all responsibility for fixing it. When in doubt, don't run it.
