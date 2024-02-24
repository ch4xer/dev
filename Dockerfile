FROM archlinux:latest

COPY ./ /root/dev
WORKDIR /root/dev
RUN echo 'o' | bash ./scripts/install-software.sh

