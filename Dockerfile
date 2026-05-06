FROM ollama/ollama:latest

# Reduce image size significantly
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/*

# Create startup script
RUN mkdir -p /app && \
    echo '#!/bin/bash\n\
set -e\n\
echo "Starting Ollama..."\n\
ollama serve &\n\
OLLAMA_PID=$!\n\
sleep 10\n\
echo "Ollama started. Waiting for health check..."\n\
for i in {1..30}; do\n\
  if curl -f http://localhost:11434/api/tags > /dev/null 2>&1; then\n\
    echo "Ollama is healthy"\n\
    wait $OLLAMA_PID\n\
    exit 0\n\
  fi\n\
  echo "Attempt $i/30: Waiting for Ollama..."\n\
  sleep 1\n\
done\n\
echo "Ollama health check failed"\n\
kill $OLLAMA_PID 2>/dev/null || true\n\
exit 1\n\
' > /app/start.sh && \
    chmod +x /app/start.sh

# Expose default port
EXPOSE 11434

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:11434/api/tags || exit 1

# Start Ollama service
CMD ["/app/start.sh"]
