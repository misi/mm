FROM node:lts

# Args
ARG BASEDIR=/opt
ARG MM=multiparty-meeting
ARG NODE_ENV=production
ARG SERVER_DEBUG=''

WORKDIR ${BASEDIR}

RUN git clone https://github.com/havfo/${MM}.git

#install server dep
WORKDIR ${BASEDIR}/${MM}/server

RUN yarn

#install app dep
WORKDIR ${BASEDIR}/${MM}/app
RUN yarn install --production=false

# set app in producion mode/minified/.
ENV NODE_ENV ${NODE_ENV}

# package web app
RUN yarn run dist

# Web PORTS
EXPOSE 80 443 
EXPOSE 40000-49999/udp


## run server 
ENV DEBUG ${SERVER_DEBUG}

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

