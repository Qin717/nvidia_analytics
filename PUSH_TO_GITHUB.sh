#!/bin/bash

# Quick script to push to GitHub
# Edit YOUR_USERNAME below before running!

# ⚠️ IMPORTANT: Replace YOUR_USERNAME with your actual GitHub username
GITHUB_USERNAME="YOUR_USERNAME"

echo "🚀 Pushing NVIDIA Patent Analytics to GitHub..."
echo ""

# Add remote
git remote add origin https://github.com/$GITHUB_USERNAME/nvidia-patent-analytics.git

# Push to GitHub
git branch -M main
git push -u origin main

echo ""
echo "✅ Done! Check your repository at:"
echo "   https://github.com/$GITHUB_USERNAME/nvidia-patent-analytics"

