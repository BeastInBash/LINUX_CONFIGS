function kitty-theme
    set KITTY_CONFIG_DIR "$HOME/.config/kitty"
    set KITTY_CONF "$KITTY_CONFIG_DIR/kitty.conf"

    # Find all .conf files except kitty.conf and kitty.conf.bak
    set themes (find $KITTY_CONFIG_DIR -maxdepth 1 -name "*.conf" \
        ! -name "kitty.conf" \
        ! -name "*.bak" \
        ! -name "no-preference*" \
        | xargs -I{} basename {} .conf | sort)

    if test (count $themes) -eq 0
        echo "No theme files found in $KITTY_CONFIG_DIR"
        return 1
    end

    # Get current theme from kitty.conf
    set current (grep -oP '(?<=^include ).*(?=\.conf)' $KITTY_CONF | head -1)

    # Use fzf to pick a theme
    set selected (printf '%s\n' $themes | fzf \
        --prompt "  Theme: " \
        --header "Current: $current  |  Enter to apply  |  Ctrl-C to cancel" \
        --height 40% \
        --layout reverse \
        --border rounded \
        --color "fg:#D3C6AA,bg:#191919,hl:#A7C080" \
        --color "fg+:#D3C6AA,bg+:#2E383C,hl+:#A7C080" \
        --color "border:#4A5560,header:#D699B6,prompt:#DBBC7F,pointer:#E67E80" \
        --preview "bat --color=always --style=plain $KITTY_CONFIG_DIR/{}.conf 2>/dev/null || cat $KITTY_CONFIG_DIR/{}.conf" \
        --preview-window "right:50%:wrap" \
        --bind "j:down" \
        --bind "k:up" \
        --bind "h:preview-page-up" \
        --bind "l:preview-page-down" \
        --bind "ctrl-d:half-page-down" \
        --bind "ctrl-u:half-page-up")

    if test -z "$selected"
        echo "No theme selected."
        return 0
    end

    # Replace the include line in kitty.conf
sed -i '/^include .*\.conf/d' $KITTY_CONF
echo "include $selected.conf" >> $KITTY_CONF

    # Reload kitty config live
    if set -q KITTY_PID
        kill -SIGUSR1 $KITTY_PID
    else
        pkill -SIGUSR1 -x kitty 2>/dev/null
    end

    echo "✓ Theme switched to: $selected"
end
