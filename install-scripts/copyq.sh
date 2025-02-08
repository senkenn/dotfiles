#!/bin/bash

sudo apt install -y copyq

# copyq is not working by default: https://github.com/hluk/CopyQ/issues/2889
# workaround: https://itsfoss.community/t/solved-copyq-not-saving-clipboard-copy-paste-in-ubuntu/10829/2
cp ~/.config/autostart/copyq.desktop ~/.config/autostart/copyq.desktop~
sed -i 's@Exec="/usr/bin/copyq"@Exec=env QT_QPA_PLATFORM=xcb copyq@' ~/.config/autostart/copyq.desktop
