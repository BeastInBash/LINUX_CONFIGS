function tmux-fish-all
    tmux list-panes -a -F '#{pane_id}' | xargs -I{} tmux send-keys -t {} 'exec fish' C-m
end
