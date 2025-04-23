#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
mkdir -p ./bin
curl -L https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=0.8.7 sh

export PATH="$(pwd)/bin:$PATH"
export DAGGER_ENGINE=houdini

echo "📂 Current directory: $(pwd)"
ls -la

cd ruby-hello-dagger/dagger

echo "📦 Initializing Go module"
go mod init example.com/dagger-task || true
go get dagger.io/dagger@v0.8.7
go mod tidy

echo "🚀 Running Go + Dagger with Houdini"
dagger run go run main.go
