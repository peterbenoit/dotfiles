#!/bin/bash

# Variables
DOTFILES_DIR=$(pwd)
BACKUP_DIR="$HOME/dotfiles_backup"
SAFE_MODE=false
SKIP_TEMPLATES=false
SKIP_NODE_MANAGER=false
SKIP_GLOBAL_PACKAGES=false

# Process arguments
for arg in "$@"; do
  case $arg in
    --safe)
      SAFE_MODE=true
      ;;
    --skip-templates)
      SKIP_TEMPLATES=true
      ;;
    --skip-node)
      SKIP_NODE_MANAGER=true
      ;;
    --skip-globals)
      SKIP_GLOBAL_PACKAGES=true
      ;;
    --help)
      echo "Usage: ./setup.sh [options]"
      echo "Options:"
      echo "  --safe               Apply only symlinks, skip installing software"
      echo "  --skip-templates     Skip creating project templates"
      echo "  --skip-node          Skip installing Node.js manager"
      echo "  --skip-globals       Skip installing global npm packages"
      echo "  --help               Show this help message"
      exit 0
      ;;
  esac
done

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# Function to create symlinks and backup existing files
create_symlink() {
    local source_file=$1
    local target_file=$2

    # Check if source file exists
    if [ ! -e "$source_file" ]; then
        echo "Warning: Source file $source_file does not exist, skipping."
        return
    fi

    if [ -e "$target_file" ]; then
        echo "Backing up $target_file to $BACKUP_DIR"
        # Create timestamp-based backup
        cp -R "$target_file" "$BACKUP_DIR/$(basename "$target_file").$(date +%Y%m%d%H%M%S).bak"
        rm -rf "$target_file"
    fi

    echo "Creating symlink for $source_file"
    ln -s "$source_file" "$target_file"
}

# Setup symlinks
setup_symlinks() {
    echo "Setting up symlinks..."

    # Check if files exist before creating symlinks
    if [ -f "$DOTFILES_DIR/.eslintrc.json" ]; then
        create_symlink "$DOTFILES_DIR/.eslintrc.json" "$HOME/.eslintrc.json"
    fi

    if [ -f "$DOTFILES_DIR/.prettierrc" ]; then
        create_symlink "$DOTFILES_DIR/.prettierrc" "$HOME/.prettierrc"
    fi

    if [ -f "$DOTFILES_DIR/.zshrc" ]; then
        create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    fi

    # VS Code settings
    if [ -f "$DOTFILES_DIR/.vscode/settings.json" ]; then
        mkdir -p "$HOME/Library/Application Support/Code/User"
        create_symlink "$DOTFILES_DIR/.vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
    fi

    echo "Symlinks setup complete."
}

# Install Node.js version manager (fnm)
install_node_manager() {
    if $SKIP_NODE_MANAGER; then
        echo "Skipping Node.js manager installation (--skip-node flag used)"
        return
    fi

    if command -v fnm &> /dev/null; then
        echo "Fast Node Manager (fnm) already installed."
    else
        echo "Installing Fast Node Manager (fnm)..."
        curl -fsSL https://fnm.vercel.app/install | bash

        # Source fnm to use it
        export PATH="$HOME/.fnm:$PATH"
        eval "`fnm env`"

        # Install latest LTS version of Node.js
        echo "Installing latest LTS version of Node.js..."
        fnm install --lts
        fnm use lts-latest
        fnm default $(fnm current)

        echo "Node.js setup complete. Current version: $(node -v)"
    fi
}

# Setup common front-end global packages
setup_npm_globals() {
    if $SKIP_GLOBAL_PACKAGES; then
        echo "Skipping global npm packages installation (--skip-globals flag used)"
        return
    fi

    if ! command -v npm &> /dev/null; then
        echo "npm not found. Make sure Node.js is installed correctly."
        return
    fi

    echo "Installing global NPM packages for front-end development..."

    # Create an array of packages
    packages=(
        "yarn"
        "typescript"
        "eslint"
        "prettier"
        "serve"
        "http-server"
        "lighthouse"
		"jest"
        "mocha"
        "chai"
        "puppeteer"
        "playwright"
		"gulp-cli"
		"gatsby-cli"
		"cypress"
		"supabase"
        "npm-check-updates"
    )

    # Optional packages - ask user
    read -p "Install deployment tools (firebase, vercel, netlify)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        packages+=(
            "firebase-tools"
            "vercel"
            "netlify-cli"
            "surge"
        )
    fi

    # Install each package individually with progress indication
    for package in "${packages[@]}"; do
        echo "Installing $package..."
        npm install -g "$package"
    done

    echo "Global NPM packages installation complete."
}

# Create frontend project templates directory
setup_project_templates() {
    if $SKIP_TEMPLATES; then
        echo "Skipping project templates creation (--skip-templates flag used)"
        return
    fi

    TEMPLATES_DIR="$HOME/GitHub/project-templates"

    # Ask user before proceeding
    read -p "Create project templates in $TEMPLATES_DIR? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping project templates creation."
        return
    fi

    echo "Creating project templates directory at $TEMPLATES_DIR"
    mkdir -p "$TEMPLATES_DIR"

    # Function to create a template
    create_template() {
        local name=$1
        local type=$2

        echo "Setting up $name template..."
        mkdir -p "$TEMPLATES_DIR/$name"

        # Check if directory is empty
        if [ "$(ls -A "$TEMPLATES_DIR/$name")" ]; then
            read -p "Template directory $TEMPLATES_DIR/$name is not empty. Overwrite? (y/n) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "Skipping $name template."
                return
            fi
            # Clear directory
            rm -rf "$TEMPLATES_DIR/$name"/*
        fi

        cd "$TEMPLATES_DIR/$name"

        case $type in
            "react")
                echo "Creating React template with Vite..."
                npm create vite@latest . -- --template react-ts
                ;;
            "vue")
                echo "Creating Vue template with Vite..."
                npm create vite@latest . -- --template vue-ts
                ;;
            "static")
                echo "Creating static site template..."
                mkdir -p css js images

                # Create basic index.html
                cat > index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Static Site Template</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Static Site Template</h1>
    </header>
    <main>
        <p>Ready to build!</p>
    </main>
    <footer>
        <p>&copy; $(date +%Y)</p>
    </footer>
    <script src="js/main.js"></script>
</body>
</html>
EOF

                # Create basic CSS
                cat > css/styles.css << EOF
/* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
        Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

header, footer {
    text-align: center;
    padding: 20px 0;
}

main {
    min-height: 80vh;
}
EOF

                # Create basic JS
                cat > js/main.js << EOF
// Your JavaScript goes here
console.log('Static site template loaded');
EOF
                ;;
        esac

        echo "$name template created successfully."
    }

    # Create templates
    create_template "react-template" "react"
    create_template "vue-template" "vue"
    create_template "static-site-template" "static"

    echo "Project templates created at $TEMPLATES_DIR"
}

# Main setup
echo "=== Front-End Development Environment Setup ==="
echo "This script will set up your development environment."

# Check if running in safe mode
if $SAFE_MODE; then
    echo "Running in safe mode: only symlinks will be created."
    setup_symlinks
    echo "Safe setup complete. To run full setup, run without --safe flag."
    exit 0
fi

# Run the setup in stages
setup_symlinks

# If Node.js is not installed and we're not skipping it
if ! command -v node &> /dev/null && ! $SKIP_NODE_MANAGER; then
    install_node_manager
elif ! $SKIP_NODE_MANAGER; then
    echo "Node.js is already installed. Current version: $(node -v)"
    read -p "Do you want to install/update the Node version manager? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_node_manager
    fi
fi

# If Node.js is installed and we're not skipping global packages
if command -v node &> /dev/null && ! $SKIP_GLOBAL_PACKAGES; then
    setup_npm_globals
fi

# Set up project templates if not skipped
if ! $SKIP_TEMPLATES; then
    setup_project_templates
fi

echo "Front-end development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'source ~/.zshrc' to load your new shell configuration"
echo "2. Review and run './macos-setup.sh --interactive' for macOS optimizations"
echo "3. Use './fe-init.sh' to create new front-end projects"
