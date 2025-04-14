#!/bin/sh
set -e

# Install Poetry if not already installed
if ! command -v poetry &> /dev/null; then
    curl -sSL https://install.python-poetry.org | python3 -
fi

# Configure Poetry
poetry config virtualenvs.create false

# If a pyproject.toml exists in /conf, install dependencies
if [ -f "/conf/pyproject.toml" ]; then
    cd /conf
    poetry install --no-interaction --no-ansi
fi

# Execute the original entrypoint with the provided arguments
exec "$@"
