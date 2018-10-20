FROM ubuntu:16.04

MAINTAINER Ivan Nemshilov

#install front
RUN apt-get update
RUN apt-get install nodejs -y
RUN apt-get install npm -y
ADD src /
RUN npm install -y
RUN npm run build

# install nginx
RUN apt-get update
RUN apt-get install -y nginx
# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf
# Copy a configuration file
ADD conf/nginx.conf /etc/nginx/
# add nginx conf
ADD config/default.conf /etc/nginx/conf.d/default.conf
# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# Expose ports
EXPOSE 80
# Set the default command to execute
# when creating a new container
WORKDIR /etc/nginx
CMD ["nginx"]