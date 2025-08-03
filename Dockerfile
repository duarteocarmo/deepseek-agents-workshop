# syntax=docker/dockerfile:1.4

############
# Stages
############
FROM python:3.12-slim-bookworm AS base

FROM base AS builder
# uv binary
COPY --from=ghcr.io/astral-sh/uv:0.4.9 /uv /usr/local/bin/uv
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

# Binder-standard user
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER=${NB_USER} \
    HOME=/home/${NB_USER}
RUN adduser --disabled-password --gecos "Default user" --uid ${NB_UID} ${NB_USER}

WORKDIR ${HOME}/app

# Dependencies first (caches layer nicely)
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-install-project --no-dev

# Binder needs the notebook stack
RUN python -m pip install --no-cache-dir --upgrade pip && \
    python -m pip install --no-cache-dir notebook jupyterlab

# Project source
COPY . .
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

###############################################################################
FROM base AS runtime
# uv again for dev shells inside Binder
COPY --from=ghcr.io/astral-sh/uv:0.4.9 /uv /usr/local/bin/uv
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

# Copy built venv + code
COPY --from=builder /home/jovyan/app /home/jovyan/app

# Recreate Binder user so UID/GID is correct
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER=${NB_USER} \
    HOME=/home/${NB_USER}
RUN adduser --disabled-password --gecos "Default user" --uid ${NB_UID} ${NB_USER} && \
    chown -R ${NB_UID} ${HOME}

# Use project venv first
ENV PATH="/home/jovyan/app/.venv/bin:${PATH}"

USER ${NB_USER}
WORKDIR ${HOME}
