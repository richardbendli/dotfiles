# ============================================================
#  options.zsh
# ============================================================

# Directory
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Globbing
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt NUMERIC_GLOB_SORT
# NULL_GLOB is NOT set globally — it breaks some plugins
# Use (N) glob qualifier per-command instead: foo*(N)

# Completion
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_PARAM_SLASH
setopt LIST_PACKED

# Input
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt RC_QUOTES
setopt NO_FLOW_CONTROL

# Jobs
setopt LONG_LIST_JOBS
setopt AUTO_RESUME
setopt NOTIFY

# Prompt
setopt PROMPT_SUBST
