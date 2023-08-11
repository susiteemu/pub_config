if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx JAVA_HOME /opt/homebrew/opt/openjdk@11
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -x fish_escape_delay_ms 200
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR /opt/homebrew/bin/nvim

starship init fish | source

