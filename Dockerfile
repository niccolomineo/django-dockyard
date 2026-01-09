FROM python:3.13-slim-bookworm

ARG USER=appuser
ARG UID=1000
ARG GID=1000

ENV LANG=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    WORKDIR=/app

WORKDIR ${WORKDIR}

# System dependencies required by Django test suite
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        gdal-bin \
        libgdal-dev \
        libpq-dev \
        postgresql-client \
        ssh \
    && rm -rf /var/lib/apt/lists/*

# Create user with matching UID/GID (important for bind mounts)
RUN groupadd -g ${GID} ${USER} \
    && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USER}

# Create virtual environment owned by app user
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Ensure venv is writable by non-root user
RUN chown -R ${USER}:${USER} /opt/venv

USER ${USER}

# Default working dir for mounted source
WORKDIR ${WORKDIR}/django

CMD ["sleep", "infinity"]
