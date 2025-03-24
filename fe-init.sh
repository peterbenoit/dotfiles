#!/bin/bash

# Color codes for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}   Front-End Project Initializer   ${NC}"
echo -e "${BLUE}========================================${NC}"

show_help() {
  echo "Usage: ./fe-init.sh [options]"
  echo "Creates a new front-end project with best practices and configuration"
  echo
  echo "Options:"
  echo "  --dry-run       Show what would be done without making changes"
  echo "  --help          Show this help message"
  echo
  echo "Project types supported:"
  echo "  - React"
  echo "  - React + TypeScript"
  echo "  - Next.js"
  echo "  - Vue.js"
  echo "  - Angular"
  echo "  - Static HTML/CSS/JS"
  echo "  - React + Vite"
  echo "  - Vue + Vite"
  exit 0
}

# Check for help flag
for arg in "$@"; do
  if [ "$arg" == "--help" ]; then
    show_help
  fi
done

# Check for dry run flag
DRY_RUN=false
for arg in "$@"; do
  if [ "$arg" == "--dry-run" ]; then
    DRY_RUN=true
    echo -e "${YELLOW}DRY RUN: No changes will be made${NC}"
  fi
done

# Get project name with validation
get_valid_project_name() {
  while true; do
    read -p "$(echo -e $YELLOW"Enter project name: "$NC)" PROJECT_NAME

    # Check if name is empty
    if [ -z "$PROJECT_NAME" ]; then
      echo -e "${RED}Error: Project name cannot be empty${NC}"
      continue
    fi

    # Check if name is valid (alphanumeric, dash, underscore)
    if ! [[ $PROJECT_NAME =~ ^[a-zA-Z0-9_-]+$ ]]; then
      echo -e "${RED}Error: Project name can only contain letters, numbers, underscores and dashes${NC}"
      continue
    fi

    # Choose location
    read -p "$(echo -e $YELLOW"Where to create project? [1: ~/GitHub (default), 2: Current directory, 3: Custom location]: "$NC)" LOCATION_CHOICE

    case $LOCATION_CHOICE in
      2)
        PROJECT_DIR="$(pwd)/$PROJECT_NAME"
        ;;
      3)
        read -p "$(echo -e $YELLOW"Enter custom location: "$NC)" CUSTOM_LOCATION
        PROJECT_DIR="$CUSTOM_LOCATION/$PROJECT_NAME"
        ;;
      *)
        PROJECT_DIR="$HOME/GitHub/$PROJECT_NAME"
        ;;
    esac

    # Check if project directory already exists
    if [ -d "$PROJECT_DIR" ]; then
      echo -e "${RED}Error: $PROJECT_DIR already exists${NC}"
      read -p "$(echo -e $YELLOW"Choose a different name? [y/n]: "$NC)" -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        continue
      else
        echo -e "${RED}Project initialization cancelled${NC}"
        exit 1
      fi
    fi

    # All checks passed
    break
  done
}

# Get project name
get_valid_project_name

# Select project type
echo -e "${BLUE}Select project type:${NC}"
echo "1) React with Vite"
echo "2) React + TypeScript with Vite"
echo "3) Next.js"
echo "4) Vue.js with Vite"
echo "5) Angular"
echo "6) Static HTML/CSS/JS"
echo "7) Exit without creating a project"

read -p "$(echo -e $YELLOW"Select an option (1-7): "$NC)" PROJECT_TYPE

if [ "$PROJECT_TYPE" == "7" ]; then
  echo -e "${BLUE}Exiting without creating a project${NC}"
  exit 0
fi

if [ "$PROJECT_TYPE" -lt 1 ] || [ "$PROJECT_TYPE" -gt 7 ]; then
  echo -e "${RED}Invalid option selected. Exiting.${NC}"
  exit 1
fi

# Create project directory
if ! $DRY_RUN; then
  echo -e "${GREEN}Creating project directory: $PROJECT_DIR${NC}"
  mkdir -p "$PROJECT_DIR"
  cd "$PROJECT_DIR"
else
  echo -e "${YELLOW}Would create directory: $PROJECT_DIR${NC}"
fi

# Initialize Git repository
if ! $DRY_RUN; then
  echo -e "${GREEN}Initializing Git repository...${NC}"
  git init
else
  echo -e "${YELLOW}Would initialize Git repository${NC}"
fi

# Create .gitignore file
if ! $DRY_RUN; then
  echo -e "${GREEN}Creating .gitignore file...${NC}"
  cat > .gitignore << EOF
# Dependencies
node_modules/
.pnp/
.pnp.js

# Testing
/coverage

# Production
/build
/dist
/out
/.next
/.nuxt

# Misc
.DS_Store
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
*.log*

# Editor directories and files
.idea/
.vscode/*
!.vscode/extensions.json
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?
EOF
else
  echo -e "${YELLOW}Would create .gitignore file${NC}"
fi

# Create README.md
if ! $DRY_RUN; then
  echo -e "${GREEN}Creating README.md...${NC}"
  cat > README.md << EOF
# $PROJECT_NAME

## Overview
Front-end project created with fe-init.sh

## Getting Started
### Installation
\`\`\`bash
npm install
\`\`\`

### Development
\`\`\`bash
npm run dev
\`\`\`

### Build
\`\`\`bash
npm run build
\`\`\`
EOF
else
  echo -e "${YELLOW}Would create README.md${NC}"
fi

# Setup project based on selected type
case $PROJECT_TYPE in
  1) # React with Vite
    if ! $DRY_RUN; then
      echo -e "${GREEN}Setting up React project with Vite...${NC}"
      npm create vite@latest . -- --template react
      npm install --save-dev eslint-config-prettier prettier
    else
      echo -e "${YELLOW}Would set up React project with Vite${NC}"
    fi
    ;;

  2) # React + TypeScript with Vite
    if ! $DRY_RUN; then
      echo -e "${GREEN}Setting up React + TypeScript project with Vite...${NC}"
      npm create vite@latest . -- --template react-ts
      npm install --save-dev eslint-config-prettier prettier
    else
      echo -e "${YELLOW}Would set up React + TypeScript project with Vite${NC}"
    fi
    ;;

  3) # Next.js
    if ! $DRY_RUN; then
      echo -e "${GREEN}Setting up Next.js project...${NC}"
      npx create-next-app@latest . --use-npm
    else
      echo -e "${YELLOW}Would set up Next.js project${NC}"
    fi
    ;;

  4) # Vue.js with Vite
    if ! $DRY_RUN; then
      echo -e "${GREEN}Setting up Vue.js project with Vite...${NC}"
      npm create vite@latest . -- --template vue
      npm install --save-dev eslint-config-prettier prettier
    else
      echo -e "${YELLOW}Would set up Vue.js project with Vite${NC}"
    fi
    ;;

  5) # Angular
    if ! $DRY_RUN; then
      echo -e "${GREEN}Setting up Angular project...${NC}"
      npx @angular/cli new . --directory=. --skip-git
    else
      echo -e "${YELLOW}Would set up Angular project${NC}"
    fi
    ;;

  6) # Static HTML/CSS/JS
    if ! $DRY_RUN; then
      echo -e "${GREEN}Setting up static HTML/CSS/JS project...${NC}"
      mkdir -p css js images

      # Create index.html
      cat > index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$PROJECT_NAME</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>$PROJECT_NAME</h1>
    </header>
    <main>
        <p>Welcome to $PROJECT_NAME</p>
    </main>
    <footer>
        <p>&copy; $(date +%Y)</p>
    </footer>
    <script src="js/main.js"></script>
</body>
</html>
EOF

      # Create CSS file
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

      # Create JS file
      cat > js/main.js << EOF
// Main JavaScript file
console.log('$PROJECT_NAME loaded');
EOF

      # Setup package.json for static site
      npm init -y
      npm install --save-dev live-server

      # Update package.json scripts
      sed -i '' 's/"scripts": {/"scripts": {\n    "dev": "live-server",/g' package.json
    else
      echo -e "${YELLOW}Would set up static HTML/CSS/JS project${NC}"
    fi
    ;;
esac

# Ask about additional packages
echo -e "${BLUE}Would you like to install additional packages?${NC}"
echo "1) Tailwind CSS"
echo "2) Styled Components"
echo "3) Material UI"
echo "4) Bootstrap"
echo "5) No additional packages"

read -p "$(echo -e $YELLOW"Select an option (1-5): "$NC)" PACKAGES

case $PACKAGES in
  1) # Tailwind CSS
    if ! $DRY_RUN; then
      echo -e "${GREEN}Installing Tailwind CSS...${NC}"
      case $PROJECT_TYPE in
        1|2) # React or React+TS with Vite
          npm install -D tailwindcss postcss autoprefixer
          npx tailwindcss init -p
          # Add Tailwind directives to CSS
          echo "/* Tailwind directives */
@tailwind base;
@tailwind components;
@tailwind utilities;" > src/index.css
          ;;
        3) # Next.js
          npm install -D tailwindcss postcss autoprefixer
          npx tailwindcss init -p
          ;;
        4) # Vue with Vite
          npm install -D tailwindcss postcss autoprefixer
          npx tailwindcss init -p
          ;;
        5) # Angular
          npm install -D tailwindcss postcss autoprefixer
          npx tailwindcss init -p
          ;;
        6) # Static
          npm install -D tailwindcss
          npx tailwindcss init
          # Create a tailwind.css file
          echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > css/tailwind.css
          ;;
      esac
    else
      echo -e "${YELLOW}Would install Tailwind CSS${NC}"
    fi
    ;;

  2) # Styled Components
    if ! $DRY_RUN; then
      echo -e "${GREEN}Installing Styled Components...${NC}"
      if [ "$PROJECT_TYPE" -eq 1 ] || [ "$PROJECT_TYPE" -eq 2 ] || [ "$PROJECT_TYPE" -eq 3 ]; then
        npm install styled-components
        npm install -D @types/styled-components
      else
        echo -e "${YELLOW}Styled Components is primarily for React projects${NC}"
      fi
    else
      echo -e "${YELLOW}Would install Styled Components${NC}"
    fi
    ;;

  3) # Material UI
    if ! $DRY_RUN; then
      echo -e "${GREEN}Installing Material UI...${NC}"
      if [ "$PROJECT_TYPE" -eq 1 ] || [ "$PROJECT_TYPE" -eq 2 ] || [ "$PROJECT_TYPE" -eq 3 ]; then
        npm install @mui/material @emotion/react @emotion/styled
      elif [ "$PROJECT_TYPE" -eq 5 ]; then
        npm install @angular/material
      else
        echo -e "${YELLOW}Material UI is primarily for React/Angular projects${NC}"
      fi
    else
      echo -e "${YELLOW}Would install Material UI${NC}"
    fi
    ;;

  4) # Bootstrap
    if ! $DRY_RUN; then
      echo -e "${GREEN}Installing Bootstrap...${NC}"
      npm install bootstrap
    else
      echo -e "${YELLOW}Would install Bootstrap${NC}"
    fi
    ;;

  5) # No additional packages
    echo -e "${GREEN}No additional packages selected${NC}"
    ;;

  *)
    echo -e "${RED}Invalid option selected${NC}"
    ;;
esac

# Create VS Code settings
if ! $DRY_RUN; then
  echo -e "${GREEN}Creating VS Code settings...${NC}"
  mkdir -p .vscode
  cat > .vscode/settings.json << EOF
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true
}
EOF
else
  echo -e "${YELLOW}Would create VS Code settings${NC}"
fi

# Initial commit
if ! $DRY_RUN; then
  echo -e "${GREEN}Creating initial Git commit...${NC}"
  git add .
  git commit -m "Initial commit"
else
  echo -e "${YELLOW}Would create initial Git commit${NC}"
fi

# Final instructions
echo -e "${GREEN}Project setup complete!${NC}"
echo -e "${BLUE}Project created at:${NC} $PROJECT_DIR"
echo -e "${BLUE}To get started:${NC}"
echo -e "  cd $PROJECT_DIR"

if [ "$PROJECT_TYPE" -eq 6 ]; then
  echo -e "  npm run dev"
else
  echo -e "  npm install (if not already run)"
  echo -e "  npm run dev (or npm start)"
fi

echo -e "${BLUE}Happy coding!${NC}"
