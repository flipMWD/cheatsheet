#!/bin/sh
#!/usr/bin/env bash

#-------------------------------
# Keybinds
# Alt  + #      comment the whole line (some terminals)
# Ctrl + W      delete word to previous space
# Ctrl + K      delete from cursor to end of line
# Ctrl + U      delete from cursor to beginning of line
# Ctrl + Y      paste content from bind W, K or U
#-------------------------------

#-------------------------------
# File Descriptor
# STDIN   /dev/stdin  -> /proc/self/fd/0
# STDOUT  /dev/stdout -> /proc/self/fd/1
# STDERR  /dev/stderr -> /proc/self/fd/2
#-------------------------------

#-------------------------------
# Redirection
# >     STDOUT (default)
# 1>    STDOUT
# 2>    STDERR
# &#    File Descriptor     2>&1 = redirect STDERR to STDOUT
#                           2>1  = redirect STDERR to file 1
# <<< Literal String
#-------------------------------

echo "Redirect STDOUT to file or device" > filename
echo "Append" >> filename
wc -l < filename            # useful for cmds that don't take file input
cat filename | wc -l        # another option (creates subshell)

#-------------------------------
# Command Line Replace
# !!    repeat last command
# !^    first argument of last command
# !$    last argument of last command
# !*    all arguments of last command
#-------------------------------

#-------------------------------
# Startup Files
#-------------------------------

[[ $- = *i* ]]              # checks shell options if --interactive is set
shopt -q login_shell        # -bash in htop or ps means it's a login shell
/etc/profile
~/.bash_profile
~/.bash_login
~/.profile

#-------------------------------
# Environment Variables
#-------------------------------

export ENV_VAR="content"        # export evn var to child process
exec env ENV_VAR="info" cmd     # execute command with modified environment

#-------------------------------
# Variables
#-------------------------------

sep="separated"
echo This variable is $sep by spaces
dlm="delimit"
echo "This variable is ${dlm}ed by braces"
echo "There are `wc -l < /etc/group` lines in /etc/group"

#-------------------------------
# Arguments
#-------------------------------

$#=argc
$0=argv[0]
$1-n=argv[x]
$@=argv
${@:$#}=argv[argc-1]
$*="argv[0] argv[1]..."
$?=prev_return_value
$$=PID
$-='sh option flags (eg. -l[ogin shell], or -i[nteractive])'

#-------------------------------
# Brace Expansion
#-------------------------------

{1..5}                      # create list of 1 2 3 4 5
{A, B}                      # create list of A B
{A, B, C}.ext               # expands to A.ext B.ext C.ext
text{,1}                    # expands to text text1

#-------------------------------
# Parameter Expansion
#-------------------------------

${param-=?+word}            # without : tests only for param unset
${param:-word}              # subst word if param is unset or null
${param:=word}              # assign word to param if unset or null
${param:?word}              # write word 2>&1 to shell if param unset or null
${param:+word}              # subst word if param is NOT unset or null

${param:offset:lenght}      # slicing
${param:(-offset):length}   # offset from the right
word="abcdefgh"
${word:5}                   # -> fgh
${word::-2}                 # -> abcdef
${word:1:3}                 # -> bcd
${word:(-4):3}              # -> efg (h = -1, ..., e = -4)

${param#prefix}             # remove prefix (non-greedy)
${param%suffix}             # remove suffix (non-greedy)
${param##prefix}            # remove long prefix (greedy)
${param%%suffix}            # remove long suffix (greedy)
${param/from/to}            # replace first match
${param//from/to}           # replace all
${param/#from/to}           # replace prefix
${param/%from/to}           # replace suffix
${!param}                   # expand to the name of variables

#-------------------------------
# Arrays
#-------------------------------

arrA=(item1 item2 item3)    # declare space separated
arrB=($(ls $DIRECTORY))
declare -A arrC             # declare associative array with keys for indexes

echo ${arrA[@]}             # lenght = 3
echo ${arrA[1]}             # value of element 1 is item2

for i in "${!arrA[@]}"; do  # generate indexes "0 1 2"
    echo $i
done

echo ${!arrC[@]}            # prints keys of associative array

#-------------------------------
# Quoting
#-------------------------------

exp=`date +%d`
sqt='Prints literal chars ${[("`!, except \\ and \'''
dqt="Interprets ${variables}, escape sequences\n and `expressions`."
echo $'This string may contain \escape sequences'

#-------------------------------
# Logical Operators
#-------------------------------

(cat filename | wc -l) && echo "() order of operation, && execute if lhs was successful"

ls \rot || echo "|| execute this if lhs failed"

#-------------------------------
# Conditional Expressions
#-------------------------------

[ -a "$file_exists" ]       # -d[irectory], -e[xists] -f[ile regular]
                            # -h -L [symbolic link], -s[ize greater than zero]
                            # -r[eadable], -w[ritable], -x [executable]

[ "$file1" -ef "$file2" ]   # same device and inode number
[ "$file1" -nt "$file2" ]   # newer than
[ "$file1" -ot "$file2" ]   # older than

[ -o "$shell_opt_enabled" ] # eg. set -o vi
[ -v "$var_is_set" ]

[ -n "$str_not_null" ]
[ -z "$str_zero_len" ]
[ "$str1" == "$str2" ]      # equal, single = for POSIX compatible
[ "$str1" != "$str2" ]      # different
[ "$str1" < "$str2" ]       # $str1 sorts before lexographically
[ "$str1" > "$str2" ]       # $str1 sorts after lexographically

[ "$num1" -eq "$num2" ]     # number values are equal
[ "$num1" -ne "$num2" ]     # not equal
[ "$num1" -lt "$num2" ]     # less than
[ "$num1" -le "$num2" ]     # less than or equal
[ "$num1" -gt "$num2" ]     # greater than
[ "$num1" -ge "$num2" ]     # greater than or equal

#-------------------------------
# Compound Command
#-------------------------------

( cmd )                     # executed in a subshell
{ cmd;                      # executed in the same shell, group cmd
(( expr ))                  # arithmetic evaluation
[[ expr ]]                  # conditional expression, no quoting, =~ regex

#-------------------------------
# Control Flow and Iteration
#-------------------------------

if [ "$val1" -lt "$val2" ]; then
	exec program args...
elif [ -f "$file_exists" ]; then
	exec program2 args...
else
	exit 1
fi

case "$val" in
	opt1)   cmd ;;
	opt2)   cmd ;;
	opt3)   cmd ;;
	*)      cmd ;;
esac

for arg in "$@"; do
	echo "$arg"
done

function name() {
	echo "Functions do not have params, they call passed args with $1-n"
}

name "Calling" "function" "name()" "with" "multiple" "args"
