FROM ollama/ollama:latest

# Expose default port
EXPOSE 11434

# Start Ollama and pull model once service is live
CMD sh -c "ollama serve & sleep 5 && ollama pull tinyllama && wait"
