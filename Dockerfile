# Recommended: use Node LTS + newer Debian suite (bookworm)
FROM node:18.20.6-bookworm-slim

WORKDIR /usr/src/app

# Install only required runtime packages (if any). Keep minimal.
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy package files, use npm ci for reproducible installs
COPY package.json package-lock.json ./
RUN npm ci --only=production

COPY graphserver.js UScities.json ./

# Run as non-root
USER node

EXPOSE 4000
CMD ["node", "graphserver.js"]
