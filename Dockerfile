FROM ollama/ollama:latest

# Pull a small model at startup
RUN ollama pull tinyllama

# Expose default port
EXPOSE 11434

# Run Ollama when container starts
CMD ["ollama", "serve"]
3
