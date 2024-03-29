FROM ubuntu:22.04

WORKDIR /app

RUN export DEBIAN_FRONTEND=non-interactive
RUN apt update && apt upgrade -y

RUN apt install -y curl build-essential

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH="/root/.cargo/bin:${PATH}"

COPY . .

RUN cargo install mdbook

EXPOSE 3000

CMD ["mdbook", "serve", "-p", "3000", "--hostname", "0.0.0.0"]