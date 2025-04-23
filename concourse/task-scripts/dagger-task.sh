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

cd /tmp/build/ruby-hello-dagger

echo "🐍 Setting up Python environment"
python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip
pip install dagger-io==0.18.3

echo "🚀 Running Python + Dagger with Houdini"
DAGGER_ENGINE=houdini python dagger/dagger_build.py
