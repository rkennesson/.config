if status --is-login
  set -gx fish_greeting ""
  set -gx XDG_CONFIG_HOME ~/.config

  # Bootstrap fisher
  # https://github.com/jorgebucaran/fisher
  if not functions -q fisher
      set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
      curl https://git.io/fisher --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
      fish -c fisher
  end

  # Set vi bindings
  set -gx fish_key_bindings fish_user_key_bindings

  # Set editor
  set -gx EDITOR nvim

  # FZF
  set -gx FZF_DEFAULT_COMMAND  'rg -g !.git/ --files --hidden'

  # Load aliases
  source ~/.config/fish/aliases.fish

  # Load secrets
  # source ~/.config/fish/secrets.fish

  # Force certain more-secure behaviors from homebrew
  set -x HOMEBREW_NO_INSECURE_REDIRECT 1
  set -x HOMEBREW_CASK_OPTS --require-sha

  # Use GNU utilities instead of macOS versions
  set -gx PATH /usr/local/opt/{coreutils,grep,gnu-sed}/libexec/gnubin $PATH

  # Use install LLVM tools
  set -gx PATH /usr/local/opt/llvm/bin $PATH

  # JavaScript specific settings
  # Set up nodenv
  status --is-interactive; and source (nodenv init -|psub)

  # Ruby specific settings
  # Rbenv
  status --is-interactive; and source (rbenv init -|psub)
  # Add gems to path
  set -gx PATH $PATH /usr/local/lib/ruby/gems/2.6.0/bin

  # Go specific settings
  # GOPATH
  set -gx PATH $PATH $GOPATH/bin

  # Rust specific settings
  set -gx PATH $PATH ~/.cargo/bin


end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
