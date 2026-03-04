FROM ollama/ollama:latest

# Pull a lightweight model at build time
RUN ollama pull tinyllama

# Expose default port
EXPOSE 11434

# Run Ollama when container starts
CMD ["ollama", "serve"]
