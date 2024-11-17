# Node base image
FROM node:16

# Switch to the "node" user
USER node

# Set home to the user's home directory
ENV HOME=/home/node \
	  PATH=/home/node/.local/bin:$PATH

# Set the working directory to the user's home directory
WORKDIR $HOME/app

# Moving file to user's home directory
ADD . $HOME/app

# Copy the current directory contents into the container at $HOME/app setting the owner to the user
COPY --chown=node . $HOME/app

# Loading Dependencies
RUN npm install

# Build the NestJS application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["sh", "-c", "node dist/main &"]