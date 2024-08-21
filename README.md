# dotfiles

## Command-Line Tools Cheat Sheet

### 1. `tree`

-   **Purpose**: Visualize directory structure.
-   **Command**: `tree [directory_path]`
-   **Example**: `tree /Users/peterbenoit/Documents`

### 2. `bat`

-   **Purpose**: A better `cat` with syntax highlighting.
-   **Command**: `bat [file_name]`
-   **Example**: `bat ~/.bashrc`

### 3. `fd`

-   **Purpose**: A fast and user-friendly alternative to `find`.
-   **Command**: `fd [pattern] [directory]`
-   **Example**: `fd ".sh" /Users/peterbenoit/scripts`

### 4. `ripgrep` (or `rg`)

-   **Purpose**: Faster searching within files.
-   **Command**: `rg [pattern] [directory]`
-   **Example**: `rg "function" ~/projects`

### 5. `tldr`

-   **Purpose**: Simplified and community-driven man pages.
-   **Command**: `tldr [command]`
-   **Example**: `tldr ls`

### 6. `fzf`

-   **Purpose**: Fuzzy finder for anything in the terminal.
-   **Command**: `fzf`
-   **Example**: `ls | fzf`

### 7. `htop`

-   **Purpose**: Interactive process viewer.
-   **Command**: `htop`

### 8. `ncdu`

-   **Purpose**: Disk usage analyzer.
-   **Command**: `ncdu [directory]`
-   **Example**: `ncdu /Users/peterbenoit`

### 9. `mas`

-   **Purpose**: Command-line interface for the Mac App Store.
-   **Command**:
    -   `mas search [app_name]`
    -   `mas install [app_id]`
-   **Example**:
    -   `mas search Xcode`
    -   `mas install 497799835`
