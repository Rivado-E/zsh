pythonIcon="\Ue73c"
rustIcon="\Ue7a8"
goIcon="\Uf07d3"
rubyIcon="\Ue791"
ocamlIcon="\Ue67a"
luaIcon="\Ue620"
tsIcon="\Ue628"
javaIcon="\Ue738"
gccIcon="\Uf0671"
linuxIcon="\Ue712"
appleIcon="\Uf302"
cargoIcon="\Uf323"
gitIcon="\Ue702"

# print $gitIcon
# Function to get the Go version if in a Go project
function go_version_prompt() {
    if [ -f go.mod ]; then
        echo "$(go version | awk '{print $3}')"
    fi
}

# Function to get the OCaml version if in an OCaml project
function ocaml_version_prompt() {
    if [ -f dune ] || [ -f dune-project ]; then
        echo "$(ocamlc -version)"
    fi
}

# Function to get the Rust version if in a Rust project
function rust_version_prompt() {
    if [ -f Cargo.toml ]; then
        echo "$(rustc --version | awk '{print $2}')"
    fi
}

# # Function to get the Python version if in a Python project
# function python_version_prompt() {
#     if [ -f requirements.txt ] || [ -f setup.py ] || [ -f pyproject.toml ]; then
#         echo "Python $(python --version 2>&1 | awk '{print $2}')"
#     fi
# }

# Function to get the Ruby version if in a Ruby project
function ruby_version_prompt() {
    if [ -f Gemfile ]; then
        echo "💎 $(ruby --version | awk '{print $2}')"
    fi
}

# Function to combine all language version prompts
function project_info() {
    local versions=()
    local go_version=$(go_version_prompt)
    local ocaml_version=$(ocaml_version_prompt)
    local rust_version=$(rust_version_prompt)
    local python_version=$(python_version_prompt)
    local ruby_version=$(ruby_version_prompt)

    [ ! -z "$go_version" ] && versions+=("$go_version")
    [ ! -z "$ocaml_version" ] && versions+=("$ocaml_version")
    [ ! -z "$rust_version" ] && versions+=("$rust_version")
    [ ! -z "$python_version" ] && versions+=("$python_version")
    [ ! -z "$ruby_version" ] && versions+=("$ruby_version")

    if [ ${#versions[@]} -ne 0 ]; then
        echo " ${versions[@]}"
    fi
}

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

alias refresh="source ~/.zshrc"
alias tdt="tmux detach" 
alias ctmux='tmux new-session -s "$(basename "$PWD")"'

alias nv="nvim"
alias c="clear"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/rivaldoe/.local/bin:"

# eval "$(zoxide init zsh)"

fcd(){
    local dir
    dir=$(find ~/Git ~/Scratch -mindeph 1 -maxdepth 1 -type d | fzf) && cd "$dir"
}

fza(){
    tmux attach-session -t $(tmux list-sessions -F "#{session_name}" | fzf)
}

# ZSH_THEME = "" 
# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/rivaldoe/.opam/opam-init/init.zsh' ]] || source '/home/rivaldoe/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
#

