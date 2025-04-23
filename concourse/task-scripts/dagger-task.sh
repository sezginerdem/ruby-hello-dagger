#!/bin/sh
set -e

echo "🔧 Installing system dependencies..."
apt-get update -qq && apt-get install -yqq curl gcc python3-dev build-essential git

echo "🐍 Ensuring latest pip version..."
python3 -m pip install --upgrade pip

echo "🐍 Installing Dagger Python SDK from GitHub"
pip install git+https://github.com/dagger/dagger.git#subdirectory=sdk/python

echo "🔧 Installing Dagger CLI (optional but helpful)"
mkdir -p /tmp/dagger-bin
cd /tmp/dagger-bin
curl -L https://dl.dagger.io/dagger/releases/0.8.7/dagger_v0.8.7_linux_amd64.tar.gz | tar -xz
chmod +x dagger
export PATH="/tmp/dagger-bin:$PATH"
cd -

echo "📂 Switching to source folder"
cd ruby-hello-dagger

echo "🚀 Running dagger_build.py using Houdini engine"
DAGGER_ENGINE=houdini python3 dagger/dagger_build.py
