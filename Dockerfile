# Install base system based on UBUNTU 16.04
FROM ubuntu:16.04

USER root

ADD  ./scripts/start.sh /start
COPY apt.conf /etc/apt/apt.conf

RUN apt-get -q -y update; apt-get install -q -y openjdk-8-jdk-headless wget openssh-server tar vim

#ssh
RUN echo "root:Passw0rd" >> /root/temp_passwd

RUN chpasswd -c SHA512 < /root/temp_passwd && rm /root/temp_passwd

RUN echo "PasswordAuthentication yes"  /etc/ssh/sshd_config

RUN echo “StrictHostKeyChecking=no” >> /etc/ssh/sshd_config

RUN mkdir /var/run/sshd

#Startup

EXPOSE 22

CMD ["/start"]
