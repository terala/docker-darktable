FROM ubuntu:14.10
MAINTAINER Ravi Terala "rterala@gmail.com"

# Install the apt-get* scripts
RUN apt-get update && \
    apt-get install -y software-properties-common

# Add DarkTable PPA get the latest released darktable bits
RUN add-apt-repository ppa:pmjdebruijn/darktable-release -y

# Install darktable
RUN apt-get install -y darktable libcanberra-gtk3*

# Install updates and cleanup after done.
RUN apt-get update && \
    apt-get autoclean \
    apt-get clean

# Create a user account for darktable to run as.
RUN mkdir -p /home/darktable && \
    echo "darktable:x:1000:1000:DarkTable,,,:/home/darktable:/bin/bash" >> /etc/passwd && \
    echo "darktable:x:1000:" >> /etc/group && \
    chown darktable:darktable -R /home/darktable 

USER darktable
ENV HOME /home/darktable
CMD darktable

#RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
#    apt-get update && apt-get install -y software-properties-common && \
#    add-apt-repository ppa:webupd8team/java -y && \
#    apt-get update && \
#    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
#    apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /tmp/*

# Install libgtk as a separate step so that we can share the layer above with
# the netbeans image
#RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module

#RUN wget http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/luna/SR1/eclipse-java-luna-SR1-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
#    echo 'Installing eclipse' && \
#    tar -xf /tmp/eclipse.tar.gz -C /opt && \
#    rm /tmp/eclipse.tar.gz

#ADD run /usr/local/bin/eclipse

#RUN chmod +x /usr/local/bin/eclipse && \
#    mkdir -p /home/developer && \
#    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
#    echo "developer:x:1000:" >> /etc/group && \
#    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
#    chmod 0440 /etc/sudoers.d/developer && \
#    chown developer:developer -R /home/developer && \
#    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

#USER developer
#ENV HOME /home/developer
#WORKDIR /home/developer
#CMD /usr/local/bin/eclipse
