FROM node:16

# Create app directory
WORKDIR /app

# Copy package*.json to ./server
COPY ./server/package*.json ./server/

# Switch to server directory
WORKDIR /app/server

# Install both prod and dev dependencies
RUN npm install --only=production

# Building the server part
RUN npm run build

# Switch back to app directory
WORKDIR /app/

# Copy package*.json to ./client
COPY ./client/package*.json ./client/

# Switch to client directory
WORKDIR /app/client

# Install client dependencies and build the client part
RUN npm install --only=production

# Switch back to app directory
WORKDIR /app/

# Copy the rest of your app's source code
COPY . .

EXPOSE 8000

CMD ["node", "./server/dist/index.js"]