function fish_prompt --description 'Write out the prompt'
#   set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
#   set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')
  set -l USER (id -nu)
   printf ' ' (set_color normal)
   switch $USER
       case root toor;
            set_color red
            echo -n '#'
       case '*';
            echo -n '$'
   end
   printf " " (set_color normal)
end

