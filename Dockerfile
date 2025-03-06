FROM elixir:1.18.2

WORKDIR /app
COPY . /app

RUN mix do \
    local.hex --force, \
    local.rebar --force, \
    archive.install --force hex phx_new