#!/usr/bin/env bash

# Install relevant code standards for work

# Install moodle, drupal and totara code standards:
# --
WORK_DIR="$HOME/work"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR" || exit
git clone https://git.drupalcode.org/project/coder.git # Drupal
git clone git@github.com:PHPCSStandards/PHPCSExtra.git # For Normalised arrays
git clone git@github.com:moodlehq/moodle-local_codechecker.git # Moodle
git clone git@github.com:totara/code-sniffer.git # Totara


# Set the standards on the phpcs (nvim has it's own phpcs path)
# --
phpcs --config-set installed_paths "$WORK_DIR/moodle-local_codechecker,$WORK_DIR/code-sniffer/src/Standards,$WORK_DIR/coder/coder_sniffer,$WORK_DIR/PHPCSExtra"
phpcbf --config-set installed_paths "$WORK_DIR/moodle-local_codechecker,$WORK_DIR/code-sniffer/src/Standards,$WORK_DIR/coder/coder_sniffer,$WORK_DIR/PHPCSExtra"

# Set the default (for use outside of nvim, and when phpcs.xml doesn't exist or when you need to specify the standard)
# --
phpcs --config-set default_standard moodle
phpcbf --config-set default_standard moodle
