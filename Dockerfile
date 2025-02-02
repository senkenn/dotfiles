FROM ubuntu:24.04

ENV TERM=xterm-256color
ENV TZ=Asia/Tokyo

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  sudo \
  tzdata \
  vim && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Set the timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN usermod -aG sudo ubuntu && \
  echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ubuntu
