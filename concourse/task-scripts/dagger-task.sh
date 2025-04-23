#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
mkdir -p ./bin
curl -L https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=0.8.7 BIN_DIR=./bin sh

export PATH="$(pwd)/bin:$PATH"
export DAGGER_ENGINE=houdini

echo "📦 Initializing Go module"
cd ruby-hello-dagger/dagger

# Init sadece ilk seferde gerekli, hata vermesin diye || true ile
go mod init example.com/dagger-task || true
go get dagger.io/dagger@v0.8.7
go mod tidy

echo "🚀 Running Go + Dagger with Houdini"
DAGGER_ENGINE=houdini ./bin/dagger run go run main.go
