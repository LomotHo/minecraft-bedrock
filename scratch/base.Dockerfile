FROM debian:buster-slim

# install packages & config docker
# pkgs installed on 1st line of apt installs are required, 2nd line pkgs are admin tools, and 3rd line are development tools.
RUN apt-get update \
  && apt-get -y install libcurl4 \
  && apt-get -y install screen vim procps file htop \
  && apt-get -y install tree tmux tcpdump sed grep gawk ack \
  && apt-get -y install autoremove \
  && apt-get clean

ENV LD_LIBRARY_PATH .
ENV SERVER_PATH="/mcpe"

WORKDIR ${SERVER_PATH}
EXPOSE 19132/udp

# RUN
CMD ["/mcpe/bedrock_server"]
