FROM ubuntu:16.04

RUN \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -qy ca-certificates build-essential pkg-config \
        software-properties-common \
        dpkg-dev build-essential curl wget vim unzip zip

# install java
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer

# provide a random env better suited for headless work such as docker images
# http://www.labouisse.com/misc/2014/06/19/tomcat-startup-time-surprises/
ENV JAVA_OPTS -Djava.security.egd=file:/dev/./urandom

# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN \
    apt-get install -y x11vnc xvfb xinit && \
    mkdir ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd

RUN mkdir -p /data/coma
WORKDIR /data/coma

RUN cd /tmp && wget -O /tmp/coma.zip http://downloads.sourceforge.net/project/coma-ce/coma%203.0%20ce%20v3.zip?use_mirror=netcologne
RUN unzip -d /tmp /tmp/coma.zip
RUN cp -r /tmp/coma\ 3.0\ ce\ v3/* /data/coma/
Run rm -rf /tmp/coma*
ADD assets/* /data/coma/
RUN chmod +x /data/coma/*.sh
RUN bash -c 'echo "cd /data/coma && ./coma.sh" >> /root/.profile'
# Autostart firefox (might not be the best way to do it, but it does the trick)

EXPOSE 5900
ENV DISPLAY :0

CMD /data/coma/x11_vnc.sh

#http://downloads.sourceforge.net/project/coma-ce/coma%203.0%20ce%20v3.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcoma-ce%2F&ts=1463056186&use_mirror=tenet
