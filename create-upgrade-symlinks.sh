#!/usr/bin/env bash

prev_versions=$(cat promscale.control | sed -n 's/# upgradeable_from = \(.*\)/\1/p' | sed "s/[[:space:]']//g" | tr ',' '\n')
# Note: we cut on both ':' and '@' here to support pre-1.62.0 and post 1.62.0 `cargo pkgid` output
cur_version=$(cargo pkgid | cut -d'#' -f2 | cut -d':' -f2 | cut -d'@' -f2)

for prev_version in $prev_versions; do
  if [ -n "${prev_version}" ] && [ -n "${cur_version}" ]; then
    ln -s -f "promscale--${cur_version}.sql" "sql/promscale--${prev_version}--${cur_version}.sql"
  fi
done
