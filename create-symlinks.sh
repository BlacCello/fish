#!/bin/bash

set -eu -o pipefail

script="$(readlink -f "$0")"
dir="$(dirname $script)"

files=("config.fish" "conf.d/azure.fish" "conf.d/git.fish" "conf.d/k8s.fish")
home_dir=~
echo "Home directory is ${home_dir}"

for file in "${files[@]}"; do
  source="${dir}/${file}"
  target="${home_dir}/.config/fish/${file}"

  echo "Create symlink from ${source} to ${target}"
  rm -rf -- "$target"
  ln -s "$source" "$target"
done
