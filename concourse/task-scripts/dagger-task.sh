#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
curl -L https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=0.8.7 sh

export PATH="$HOME/.dagger/bin:$PATH"
export DAGGER_CLI_BIN="$HOME/.dagger/bin/dagger"
export DAGGER_ENGINE=houdini

echo "🚀 Running Go + Dagger"
cd ruby-hello-dagger/dagger
go run main.go
