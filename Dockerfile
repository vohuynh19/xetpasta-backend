# Use the official Node.js image
FROM node:18

# Create a user and switch to it
RUN useradd -m -u 1000 user
USER user
ENV PATH="/home/user/.local/bin:$PATH"
WORKDIR /app


# Copy package.json and package-lock.json
COPY --chown=user ./package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY --chown=user . .

# Build the NestJS application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/main"]