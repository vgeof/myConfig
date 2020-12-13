source ~/Code/wslenv/aliases.fish
set fish_greeting
set fish
set -U fish_prompt_pwd_dir_length 0
set  fish_color_user --bold green
set  fish_color_host --bold green
set  fish_color_cwd --bold blue
alias nvim='/home/vgeoffroy/Code/neovim/install/bin/nvim'
alias vim='nvim'
alias vimdiff='nvim -d'




function ctrlp
    set file_found (fzf --preview "bat --style=numbers --color=always {} | head -500")
    if [ -n "$file_found" ]
        vim $file_found
    end
end
fish_vi_key_bindings
bind \cp ctrlp
bind -M insert \cp ctrlp
# emacs style completion
bind -M insert \ef forward-word
bind -M insert \cf forward-char
# better vi-style history
for mode in insert default
    bind -M $mode \ck up-or-search
    bind -M $mode \cj down-or-search
end

