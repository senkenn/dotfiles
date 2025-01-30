FROM ubuntu:24.04

ENV TERM=xterm-256color

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  sudo \
  vim && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN usermod -aG sudo ubuntu && \
  echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ubuntu
