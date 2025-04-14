#!/bin/sh
set -e

# Install pip requirements first (legacy support)
if [ -f "/dependencies/python-requirements.txt" ]; then
    echo "Installing pip requirements..."
    pip install -r /dependencies/python-requirements.txt
fi

# Install Poetry and its dependencies
if ! command -v poetry &> /dev/null; then
    echo "Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
fi

# Configure Poetry
poetry config virtualenvs.create false

# Install Poetry dependencies if pyproject.toml exists
if [ -f "/conf/pyproject.toml" ]; then
    echo "Installing Poetry dependencies..."
    cd /conf
    poetry install --no-interaction --no-ansi
fi

# Execute the original entrypoint with the provided arguments
echo "Starting sandbox service..."
exec "$@"
