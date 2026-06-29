FROM node:20

WORKDIR /app

# Copy complete project first
COPY . .

# Enable pnpm and install dependencies
RUN corepack enable && pnpm install

CMD ["bash"]
