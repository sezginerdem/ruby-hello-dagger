#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
curl -L https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=0.8.7 sh

echo "📂 Kurulumdan sonra bulunduğun dizin: $(pwd)"
echo "🔍 Binary’yi ara:"
find . -name dagger -type f

# Dagger binary kurulduysa PATH’e ekle
export PATH="$(pwd)/.dagger/bin:$PATH"

cd ruby-hello-dagger/dagger

echo "📦 Go modülünü kur"
go mod init example.com/dagger-task || true
go get dagger.io/dagger@v0.8.7
go mod tidy

echo "🚀 Running Go + Dagger with Houdini"
env DAGGER_ENGINE=houdini dagger run go run main.go
