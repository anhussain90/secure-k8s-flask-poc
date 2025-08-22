#!/usr/bin/env python3
"""
Minimal Flask API for secure Kubernetes deployment PoC
"""

from flask import Flask, jsonify
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

@app.route('/healthz')
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'service': 'secure-flask-poc',
        'version': os.getenv('APP_VERSION', '1.0.0')
    }), 200

@app.route('/ready')
def readiness_check():
    """Readiness check endpoint"""
    return jsonify({
        'status': 'ready',
        'service': 'secure-flask-poc'
    }), 200

@app.route('/')
def root():
    """Root endpoint"""
    return jsonify({
        'message': 'Secure Flask API PoC',
        'endpoints': ['/healthz', '/ready']
    }), 200

if __name__ == '__main__':
    port = int(os.getenv('PORT', 80))
    app.run(host='0.0.0.0', port=port, debug=False)