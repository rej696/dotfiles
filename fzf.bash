# Setup fzf
# ---------

export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
export FZF_ALT_C_COMMAND='fd --type d . --color=never'

if [[ ! "$PATH" == */home/${USER}/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/${USER}/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/${USER}/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/${USER}/.fzf/shell/key-bindings.bash"
