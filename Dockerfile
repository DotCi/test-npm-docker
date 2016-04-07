FROM centos:centos7

RUN yum install -y epel-release
RUN yum install -y nodejs npm
RUN npm config set registry http://registry.npmjs.org
RUN npm install -g npm@latest-2

COPY package.json /src/package.json
RUN cd /src; npm install --production
RUN npm version

COPY . /src

EXPOSE  8080
CMD ["node", "/src/index.js"]
