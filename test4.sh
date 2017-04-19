#!/bin/sh

test=$(zenity --password --title="testing" --text="test:")

cat >/home/chip/test <<EOL
$test
EOL
