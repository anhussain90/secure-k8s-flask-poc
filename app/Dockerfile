# Multi-stage build for security and minimal image size
FROM python:3.11-slim as builder

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Production stage with distroless base
FROM gcr.io/distroless/python3-debian12:nonroot

# Copy Python packages from builder
COPY --from=builder /root/.local /home/nonroot/.local

# Copy application
WORKDIR /app
COPY --chown=nonroot:nonroot app.py .

# Set environment
ENV PATH=/home/nonroot/.local/bin:$PATH
ENV PYTHONPATH=/home/nonroot/.local/lib/python3.11/site-packages
ENV PORT=8080
ENV PYTHONUNBUFFERED=1

# Use non-root user
USER nonroot

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/healthz')"

EXPOSE 8080

CMD ["python", "app.py"]