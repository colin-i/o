
FROM ubuntu:16.04
RUN mkdir build
WORKDIR build
RUN apt-get update -y
RUN apt-get install -y binutils git software-properties-common
RUN git clone --depth=1 -b test https://github.com/colin-i/o
WORKDIR o/src/linux
RUN add-apt-repository -y ppa:colin-i/ppa
RUN apt-get update -y
RUN apt-get install -y ocompiler
RUN o obj.oc
RUN base64 obj.o > ../obj.txt
