FROM centos:centos7

RUN yum install -y epel-release
ENV NODE_VERSION "v0.12.13"
RUN mkdir /nodejs && curl http://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
ENV PATH $PATH:/nodejs/bin

RUN npm config set registry http://registry.npmjs.org
RUN npm install -g npm@latest-2
RUN npm version

COPY package.json /src/package.json
RUN cd /src; npm install --production

COPY . /src

EXPOSE  8080
CMD ["node", "/src/index.js"]
