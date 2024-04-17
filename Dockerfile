FROM archlinux:latest

COPY ./lf /root/dev/lf
COPY ./nvim /root/dev/nvim
COPY ./tmux /root/dev/tmux
COPY ./todo /root/dev/todo
COPY ./zsh /root/dev/zsh
COPY ./scripts /root/dev/scripts
WORKDIR /root/dev
RUN sed -i 's/^Server =.*archlinux.org$/Server = https:\/\/mirrors.tuna.tsinghua.edu.cn\/archlinux\/\$repo\/os\/\$arch/' /etc/pacman.d/mirrorlist
RUN pacman -Sy && pacman -S --needed --noconfirm sudo
RUN echo 'o' | bash ./scripts/install-software.sh
RUN nvim --headless "+Lazy! sync" +qa
