#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
mkdir -p /tmp/dagger-bin
cd /tmp/dagger-bin
curl -L https://dl.dagger.io/dagger/releases/0.8.7/dagger_v0.8.7_linux_arm64.tar.gz | tar -xz
chmod +x dagger

export PATH="/tmp/dagger-bin:$PATH"
export DAGGER_ENGINE=houdini

echo "📂 Current directory: $(pwd)"

# Dagger projesinin olduğu dizine geçiş
cd $(find /tmp/build -type d -path "*/ruby-hello-dagger/dagger")

echo "📦 Initializing Go module"
go mod init example.com/dagger-task || true
go get dagger.io/dagger@v0.8.7
go mod tidy

echo "🚀 Running Go + Dagger with Houdini"
DAGGER_ENGINE=houdini /tmp/dagger-bin/dagger run go run main.go
