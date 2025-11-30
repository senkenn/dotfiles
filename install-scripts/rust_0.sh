#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo "source $HOME/.cargo/env" >>"$HOME"/.zshrc
