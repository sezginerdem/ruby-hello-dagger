#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
curl -L https://dl.dagger.io/dagger/releases/0.8.7/dagger_v0.8.7_linux_arm64.tar.gz | tar -xz -C /tmp
chmod +x /tmp/dagger

echo "📂 Current directory: $(pwd)"

echo "📦 Initializing Go module"
cd ruby-hello-dagger/dagger
go mod tidy

echo "🚀 Running Go + Dagger with Houdini"
DAGGER_ENGINE=houdini /tmp/dagger run go run main.go