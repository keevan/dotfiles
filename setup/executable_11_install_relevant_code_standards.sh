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
installpaths="$WORK_DIR/moodle-local_codechecker/vendor/squizlabs/php_codesniffer/src/Standards/Squiz,$WORK_DIR/moodle-local_codechecker,$WORK_DIR/moodle-local_codechecker/vendor/moodlehq/moodle-cs,$WORK_DIR/moodle-local_codechecker/vendor/phpcompatibility/php-compatibility/PHPCompatibility,$WORK_DIR/code-sniffer/src/Standards,$WORK_DIR/coder/coder_sniffer,$WORK_DIR/PHPCSExtra"
phpcs --config-set installed_paths "$installpaths"
phpcbf --config-set installed_paths "$installpaths"

# Set the default (for use outside of nvim, and when phpcs.xml doesn't exist or when you need to specify the standard)
# --
phpcs --config-set default_standard moodle
phpcbf --config-set default_standard moodle
