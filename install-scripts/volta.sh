#!/bin/bash

curl https://get.volta.sh | bash
echo "export PATH=\$HOME/.volta/bin:\$PATH" >>"$HOME/.zshrc"
