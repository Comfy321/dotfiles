#!/bin/zsh
scale=2


how_help()
{
	cat << EOF
	In addition to standard math functions, calc also supports
	a % b
	a ^ b
	s(x)
	c(x)
	l(x)
	e(x)
	j(n, x)
	scale N (number of digits on decimal. by default is two)
EOF
}
if [ $# -gt 0 ] ; then
	exec scriptbc "$@"
fi
echo "Welcome to pyxelCalc"
echo -n "calc> "
while read command args
do
	case $command
		in
		quit|exit)    exit 0 ;;
		htlp|\?)   show_help ;;
		scale)   scale=$args ;;
		*)           scriptbc -p $scale "$command" $args" ;;
	esac
	echo -n "calc> "
done
echo ""

exit 0
