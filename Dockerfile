FROM node:boron
MAINTAINER Levi Morris <siromivel@gmail.com>

RUN apt-get update
RUN apt-get install --no-install-recommends -y git nginx-extras
RUN npm install -g create-react-app
RUN git -c http.sslVerify=false clone https://github.com/marchforsciencemi/march-for-science.git

WORKDIR /march-for-science
RUN npm install
RUN npm run build
RUN rm -v /etc/nginx/nginx.conf

ADD nginx.conf /etc/nginx/
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
ENTRYPOINT ["nginx"]
