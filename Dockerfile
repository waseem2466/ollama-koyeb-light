FROM ollama/ollama:latest

# Clean up unnecessary files to reduce image size
RUN rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose default port
EXPOSE 11434

# Start Ollama and pull model once service is live
CMD sh -c "ollama serve & sleep 5 && ollama pull tinyllama && wait"
