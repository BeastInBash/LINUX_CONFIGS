# ~/.config/fish/config.fish

# ============================================
# ENVIRONMENT VARIABLES
# ============================================
set -gx EDITOR nvim
set -U fish_greeting  # Disable greeting

# ============================================
# PATH CONFIGURATION
# ============================================
set -gx PATH \
    $HOME/.local/bin \
    $HOME/bin \
    $HOME/.cargo/bin \
    $HOME/.npm-global/bin \
    $HOME/.bun/bin \
    /opt/nvim \
    $PATH

# ===========================================
# Change theme Keybind
# ===========================================
bind \ct 'kitty-theme; commandline -f repaint'
# ============================================
# NVM (Node Version Manager)
# ============================================
function nvm --description 'Node Version Manager'
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end

# ============================================
# CUSTOM FUNCTIONS
# ============================================

# Compile and run C++ code
function gr --description "Compile and run C++ code"
    if test (count $argv) -eq 0
        echo "Usage: gr <file.cpp> [extra g++ flags]"
        return 1
    end

    mkdir -p output

    set src $argv[1]

    if test (count $argv) -gt 1
        set flags $argv[2..-1]
    else
        set flags
    end

    set filename (path basename $src)
    set execname (string replace -r '\.cpp$' '' $filename)
    set outpath output/$execname

    g++ $src $flags -o $outpath

    if test $status -eq 0
        echo "✅ Compiled successfully: running $outpath"
        echo "---------------------------------------"
        ./$outpath
    else
        echo "❌ Compilation failed."
    end
end

# Reload fish in all tmux panes
function tmux-fish-all
    tmux list-panes -a -F '#{pane_id}' | xargs -I{} tmux send-keys -t {} 'exec fish' C-m
end
funcsave tmux-fish-all

# FZF file opener
function fzf_open_file
    set file (fzf)
    if test -n "$file"
        nvim "$file"
    end
end

# ============================================
# KEY BINDINGS
# ============================================
bind \cf fzf_open_file

# ============================================
# ALIASES - NAVIGATION & TOOLS
# ============================================
alias aqua="asciiquarium"
alias ef="exec fish"
alias live="live-server --port 8080"
alias carmall="cd ~/newdisk/car-bharti/carmall"
alias t="tmux"
alias ex="yazi"
alias vim="nvim"
alias vi="nvim"
alias zen="flatpak run app.zen_browser.zen"
alias k="kiro-cli"
alias pgd="./pg-docker.sh"

# ============================================
# ALIASES - FILE OPERATIONS
# ============================================
alias ll="ls -la"

# ============================================
# ALIASES - DOCKER - Lifecycle
# ============================================
alias ds="docker start"
alias dst="docker stop"
alias dps="docker ps"
alias dpsa="docker ps -a"                                      # All containers (including stopped)
alias dr="docker restart"

# Docker - Images
alias di="docker images"
alias drmi="docker rmi"                                        # Remove image
alias dpull="docker pull"
alias dbuild="docker build -t"                                 # Usage: dbuild <name> <path>

# Docker - Containers - Create & Run
alias drun="docker run -it"                                    # Interactive run
alias drund="docker run -d"                                    # Detached run

# Docker - Containers - Remove
alias drm="docker rm"                                          # Remove stopped container
alias drmf="docker rm -f"                                      # Force remove running container
alias drmall="docker rm (docker ps -aq)"                      # Remove all stopped containers
alias drmallf="docker rm -f (docker ps -aq)"                  # Force remove ALL containers

# Docker - Logs & Inspection
alias dl="docker logs"
alias dlf="docker logs -f"                                     # Follow logs
alias dins="docker inspect"
alias dexec="docker exec -it"                                  # Exec into container shell

# Docker - Stats & Info
alias dstats="docker stats"
alias dtop="docker top"

# Docker - Volumes
alias dv="docker volume ls"
alias dvrm="docker volume rm"
alias dvprune="docker volume prune"                            # Remove unused volumes

# Docker - Networks
alias dn="docker network ls"
alias dnrm="docker network rm"
alias dninspect="docker network inspect"

# Docker - System Cleanup
alias dprune="docker system prune -f"                         # Remove stopped containers, dangling images, unused networks
alias dpruneall="docker system prune -af --volumes"           # Nuclear clean: everything unused

# Docker Compose
alias dc="docker compose"
alias dcu="docker compose up"
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcr="docker compose restart"
alias dcl="docker compose logs"
alias dclf="docker compose logs -f"
alias dcb="docker compose build"

# ============================================
# ALIASES - NETWORK
# ============================================
alias ispeed="speedtest-cli"

# ============================================
# ALIASES - PACKAGE MANAGERS
# ============================================

# Yarn
alias yrd="yarn run dev"
alias yrt="yarn run test"
alias yrl="yarn run lint"
alias yrb="yarn run build"

# NPM
alias nrd="npm run dev"
alias nrt="npm run test"
alias nrl="npm run lint"
alias nrb="npm run build"

# Bun
alias ba="bun add"
alias brd="bun run dev"
alias brb="bun run build"
alias brt="bun run test"
alias brl="bun run lint"
alias bsha="bunx --bun shadcn@latest add"

# ============================================
# ALIASES - GIT
# ============================================
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpt="git push -u origin testing"
alias gpo="git push -u origin"
alias gpl="git pull"
alias gl="git log --oneline --graph --decorate --all"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gsw="git switch"
alias ng="ngrok http --url=nonoccult-barbar-uncomplacently.ngrok-free.dev "

# ============================================
# ALIASES - SYSTEM
# ============================================
alias i="yay -S"
alias update-discord="sudo nvim /opt/discord/resources/build_info.json"

# ============================================
# ALIASES - MISC
# ============================================
alias cea="create-express-app"

# ============================================
# OH-MY-POSH PROMPT
# ============================================
oh-my-posh init fish --config '~/.config/fish/posh-themes/rose_pine.omp.json' | source

# Alternative themes (uncomment to use):
# oh-my-posh init fish --config '~/.config/fish/posh-themes/zash.omp.json' | source
# oh-my-posh init fish --config '~/.config/fish/posh-themes/pure.omp.json' | source
# oh-my-posh init fish --config '~/.config/fish/posh-themes/tokyo.omp.json' | source
# oh-my-posh init fish --config '~/.config/fish/posh-themes/catppuccin_mocha.omp.json' | source

# ============================================
# INTERACTIVE SHELL INIT
# ============================================
if status is-interactive
    fastfetch --logo-type "kitty-icat" --logo-width 50 --logo-padding-top 1
    zoxide init fish --cmd cd | source
end
