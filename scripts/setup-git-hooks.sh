#!/bin/bash
# Setup script for git hooks

set -e

echo "🔧 Setting up git hooks for secure Kubernetes Flask PoC..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not in a git repository. Run 'git init' first."
    exit 1
fi

# Create audit directories
echo "📁 Creating audit directories..."
mkdir -p audit/commits
mkdir -p audit/scans

# Copy hook templates to .git/hooks/
echo "📋 Installing git hooks..."

if [ -f "git-hooks/pre-commit" ]; then
    cp git-hooks/pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hook installed"
else
    echo "❌ Pre-commit template not found"
fi

if [ -f "git-hooks/post-commit" ]; then
    cp git-hooks/post-commit .git/hooks/post-commit
    chmod +x .git/hooks/post-commit
    echo "✅ Post-commit hook installed"
else
    echo "❌ Post-commit template not found"
fi

# Check for required tools
echo ""
echo "🔍 Checking for security tools..."

check_tool() {
    if command -v "$1" &> /dev/null; then
        echo "✅ $1 is installed"
    else
        echo "⚠️  $1 is not installed - $2"
    fi
}

check_tool "gitleaks" "install with: brew install gitleaks"
check_tool "yamllint" "install with: pip install yamllint"
check_tool "black" "install with: pip install black"
check_tool "hadolint" "install with: brew install hadolint"
check_tool "trivy" "install with: brew install trivy"
check_tool "jq" "install with: brew install jq"

echo ""
echo "🎉 Git hooks setup completed!"
echo "📝 Hooks will run automatically on commit"
echo "🔍 Security checks will be performed before each commit"
echo "📊 Audit trail will be maintained after each commit"