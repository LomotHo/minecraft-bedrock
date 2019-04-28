FROM debian:buster-slim

# Install packages & config docker
RUN apt-get update && \
  apt-get -y install libcurl4 && \
  apt-get -y autoremove && \
  apt-get clean

ENV LD_LIBRARY_PATH .
ENV SERVER_PATH="/mcpe"

WORKDIR ${SERVER_PATH}
EXPOSE 19132/udp

# RUN
CMD ["/mcpe/bedrock_server"]
