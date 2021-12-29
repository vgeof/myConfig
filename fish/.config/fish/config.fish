
set fish_greeting
set fish

###############################################
############ prompt customisation          ####
###############################################
set -U fish_prompt_pwd_dir_length 0
set  fish_color_user --bold green
set  fish_color_host --bold green
set  fish_color_cwd  --bold blue
set fish_color_status red
function fish_default_mode_prompt --description "Display the default mode for the prompt"
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold --background white black
                echo ' N '
            case insert
                set_color --bold --background brblue black
                echo ' I '
            case replace_one
                set_color --bold --background cyan black
                echo ' R '
            case replace
                set_color --bold --background cyan black
                echo ' R '
            case visual
                set_color --bold --background yellow black
                echo ' V '
        end
        set_color normal
        echo -n ' '
    end
end

function print_user_if_needed
    if test -n "$SSH_CLIENT"
        echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $color_host) (prompt_hostname)
    end
end

#function fish_prompt --description 'Write out the prompt'
#    set -l last_pipestatus $pipestatus
#    set -l normal (set_color normal)
#
#    # Color the prompt differently when we're root
#    set -l color_cwd $fish_color_cwd
#    set -l prefix
#    set -l suffix '>'
#    if contains -- $USER root toor
#        if set -q fish_color_cwd_root
#            set color_cwd $fish_color_cwd_root
#        end
#        set suffix '#'
#    end
#
#    # If we're running via SSH, change the host color.
#    set -l color_host $fish_color_host
#    if set -q SSH_TTY
#        set color_host $fish_color_host_remote
#    end
#
#    # Write pipestatus
#    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
#
#    echo -n -s (print_user_if_needed) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status $suffix " "
#end

###############################################
############ syntax highlighting          ####
###############################################
set fish_color_command --bold cyan
set fish_color_param  blue
set fish_color_quote  green
set fish_color_operator --bold green
set fish_color_redirection brblue
set fish_color_error red
set fish_color_comment brblack


###############################################
############ keybindings                   ####
###############################################

#keybindings
fish_vi_key_bindings
# emacs style completion
bind -M insert \ef forward-word
bind -M insert \cf forward-char
# # better vi-style history
for mode in insert default
    bind -M $mode \ck up-or-search
    bind -M $mode \cj down-or-search
end

function ctrlp
    set file_found (fzf --preview "bat --style=numbers --color=always {} | head -500")
    if [ -n "$file_found" ]
        vim $file_found
    end
end
bind \cp ctrlp
bind -M insert \cp ctrlp

###############################################
############ aliases                       ####
###############################################

alias vim='nvim'
alias vimdiff='nvim -d'
alias ll='exa -l'
alias la='exa -la'

set -x EDITOR 'nvim'
set -x VISUAL 'nvim'
set -x SUDO_EDITOR 'nvim'


###############################################
############ source specific file          ####
###############################################
if test -f ~/.config/fish/config_specific.fish
    source ~/.config/fish/config_specific.fish
end

