#!/bin/sh

test=$(zenity --entry --title="testing" --text="test:")

cat >/home/chip/test <<EOL
$test
EOL
