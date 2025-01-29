FROM ubuntu:24.04

ENV TERM=xterm-256color

RUN apt-get update && apt-get install -y git sudo

RUN usermod -aG sudo ubuntu && \
  echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ubuntu
