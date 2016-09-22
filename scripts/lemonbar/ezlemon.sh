mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/lemonbuddy
cd ${XDG_CONFIG_HOME:-$HOME/.config}/lemonbuddy
wm=$(pgrep -l -x "(bspwm|i3)"); __prefix=$(which lemonbuddy)
cp "${__prefix%%/bin*}/share/examples/lemonbuddy/config${__wm:+.${__wm##* }}" config
lemonbuddy_wrapper example

