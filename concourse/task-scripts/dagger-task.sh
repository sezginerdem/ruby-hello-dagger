#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
curl -L https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=0.8.7 sh

export PATH="$HOME/.dagger/bin:$PATH"
export DAGGER_ENGINE=houdini

cd ../../dagger

echo "📦 Initializing Go module"
go mod init example.com/dagger-task || true
go get dagger.io/dagger@v0.8.7
go mod tidy

echo "🚀 Running Go + Dagger with Houdini"
DAGGER_ENGINE=houdini go run main.go
