FROM node:16-alpine as development

# all commands will be done from the working directory after this line
WORKDIR /usr/src/app

# Want to copy the package.json and package-lock.json to the workdir (. = /usr/src/app)
# Docker will cache the results from this, 
# 	so we don't have to rerun this if no changes in dependencies
COPY package*.json .

RUN npm install

# copy everything from our src folder to the working directory
# We first copy the package.json for optimization.
# Docker starts running the docker file from where it needs to (no change in files)
# 	we don't want to run npm install for all changes.
COPY . .

# Want to build all of our source code - which we'll use for other environments
RUN npm run build


FROM node:16-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json .

RUN npm ci --only=production

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/index.js"]
