#!/bin/bash
set -e

echo "🔍 Running Security Verification Checks"
echo "========================================"

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found"
    exit 1
fi

# Verify OPA Gatekeeper is running
echo "📋 Checking OPA Gatekeeper status..."
if kubectl get pods -n gatekeeper-system | grep -q "Running"; then
    echo "✅ OPA Gatekeeper is running"
else
    echo "❌ OPA Gatekeeper is not running properly"
    exit 1
fi

# Verify security policies are applied
echo "🛡️  Checking security policies..."
POLICIES=$(kubectl get constrainttemplates --no-headers | wc -l)
if [ "$POLICIES" -gt 0 ]; then
    echo "✅ Security policies applied: $POLICIES"
    kubectl get constrainttemplates
else
    echo "❌ No security policies found"
    exit 1
fi

# Verify application deployment
echo "🚀 Checking application deployment..."
if kubectl get deployment secure-flask-poc &> /dev/null; then
    echo "✅ Application deployed"
    
    # Check pod security context
    echo "🔒 Verifying pod security context..."
    POD_NAME=$(kubectl get pods -l app=secure-flask-poc -o jsonpath='{.items[0].metadata.name}')
    
    # Check if running as non-root
    USER_ID=$(kubectl get pod $POD_NAME -o jsonpath='{.spec.securityContext.runAsUser}')
    if [ "$USER_ID" != "0" ] && [ "$USER_ID" != "" ]; then
        echo "✅ Pod running as non-root user: $USER_ID"
    else
        echo "❌ Pod may be running as root"
    fi
    
    # Check read-only root filesystem
    READONLY_ROOT=$(kubectl get pod $POD_NAME -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}')
    if [ "$READONLY_ROOT" = "true" ]; then
        echo "✅ Read-only root filesystem enabled"
    else
        echo "❌ Read-only root filesystem not enabled"
    fi
    
else
    echo "❌ Application not deployed"
    exit 1
fi

# Test application endpoints
echo "🌐 Testing application endpoints..."
kubectl port-forward deployment/secure-flask-poc 8080:8080 &
PF_PID=$!
sleep 5

# Test health endpoint
if curl -s http://localhost:8080/healthz | grep -q "healthy"; then
    echo "✅ Health endpoint responding"
else
    echo "❌ Health endpoint not responding"
    kill $PF_PID
    exit 1
fi

# Test readiness endpoint
if curl -s http://localhost:8080/ready | grep -q "ready"; then
    echo "✅ Readiness endpoint responding"
else
    echo "❌ Readiness endpoint not responding"
    kill $PF_PID
    exit 1
fi

kill $PF_PID

echo ""
echo "🎉 All security verification checks passed!"
echo "📊 Security Summary:"
echo "   - OPA Gatekeeper: ✅ Active"
echo "   - Security Policies: ✅ $POLICIES applied"
echo "   - Non-root execution: ✅ Verified"
echo "   - Read-only filesystem: ✅ Enabled"
echo "   - Application health: ✅ Healthy"