# Start from a Jupyter Docker Stacks version
FROM jupyter/scipy-notebook:python-3.10.11

# Work in the jovyan user's home directory
WORKDIR "/home/${NB_USER}"

# Needed for poetry package management: no venv, latest poetry, GRANT_SUDO don't work :(
ENV POETRY_VIRTUALENVS_CREATE=false \
    POETRY_VERSION=1.4.2 \
    GRANT_SUDO=yes

# The docker stacks make sudo very difficult, so we [just be root™]
USER root
RUN sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt install curl -y && \
    rm -rf /var/lib/apt/lists/*

# Go back to jovyan user so we don't have permission problems
USER ${NB_USER}

# Install poetry so we can install our package requirements
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH "/home/jovyan/.local/bin:$PATH"

# Create a new conda environment to use as a kernel
RUN conda create -n netography python=3.10 && \
    conda init bash

# Activate the conda environment now that conda init has run
RUN source activate netography

# Copy our poetry configuration files as jovyan user
COPY --chown=${NB_UID}:${NB_GID} pyproject.toml "/home/${NB_USER}/work/"
COPY --chown=${NB_UID}:${NB_GID} poetry.lock    "/home/${NB_USER}/work/"

# Install our package requirements via poetry, including ipykernel. No venv, squash max-workers error.
WORKDIR "/home/${NB_USER}/work"
RUN poetry config virtualenvs.create false && \
    poetry config installer.max-workers 10 && \
    poetry install --no-interaction --no-ansi --no-root -vvv

# Install the kernel for our conda environment
RUN python3 -m ipykernel install --user --name=netography
