FROM ubuntu:14.04
MAINTAINER jerome.petazzoni@docker.com

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker v1.7 from binary
#RUN curl -sSL https://get.docker.com/ubuntu/ | sh
RUN apt-get install -y wget
RUN wget http://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_1.7.0-0~trusty_amd64.deb
RUN dpkg -i docker-engine_1.7.0-0~trusty_amd64.deb
RUN apt-get -f install

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]

