FROM node:19-slim

# Create app directory
WORKDIR /web

# copy package.json and install frontend packages
COPY /web/package*.json /web/
RUN npm install

# copy source code
COPY . .

CMD [ "npm", "run", "dev:nobrowser" ]