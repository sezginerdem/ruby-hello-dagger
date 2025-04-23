#!/bin/sh
set -e

echo "🔧 Installing Dagger CLI..."
mkdir -p /tmp/dagger-bin
curl -L https://dl.dagger.io/dagger/releases/0.8.7/dagger_v0.8.7_linux_arm64.tar.gz | tar -xz -C /tmp/dagger-bin
chmod +x /tmp/dagger-bin/dagger

export PATH="/tmp/dagger-bin:$PATH"
export DAGGER_ENGINE=houdini

echo "📂 Switching to mounted source folder: ruby-hello-dagger"
cd ruby-hello-dagger

echo "🐍 Installing Python dependencies"
pip install --upgrade pip
pip install dagger-io==0.18.3

echo "🚀 Running Python + Dagger with Houdini"
DAGGER_ENGINE=houdini python3 dagger/dagger_build.py
