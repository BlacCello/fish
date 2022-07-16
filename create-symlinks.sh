#!/bin/bash

set -eu -o pipefail

script="$(readlink -f "$0")"
dir="$(dirname $script)"

folders=("config.fish" "conf.d")
home_dir=~
echo "Home directory is ${home_dir}"

for folder in "${folders[@]}"; do
  source="${dir}/${folder}"
  target="${home_dir}/.config/fish/${folder}"

  echo "Create symlink from ${source} to ${target}"
  rm -rf -- "$target"
  ln -s "$source" "$target"
done
