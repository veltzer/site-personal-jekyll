#!/bin/bash
# Build the site from blog/ into the committed docs/ folder that GitHub
# Pages serves. Replaces the old Makefile rule:
#     jekyll build --source blog --destination docs && rm -f docs/feed.xml
# Runs under bundler so the plugin set comes from the root Gemfile.lock.
# The feed is intentionally not published (see commit "disabled feed.xml"),
# but bundler auto-loads jekyll-feed from the :jekyll_plugins group, so the
# generated feed.xml is dropped after the build.
# Extra arguments (--inputs/--output-dirs from rsconstruct's explicit
# processor) are informational only and ignored.
set -euo pipefail
cd "$(dirname "$0")/.."
bundle exec jekyll build --source blog --destination docs
rm -f docs/feed.xml
