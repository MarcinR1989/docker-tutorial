# syntax=docker/dockerfile:1

# use python official image. It contains all the required packages.
FROM python:3.10-slim-buster

# Set default working directory. From now on, relative paths can be used.
WORKDIR /app

# copy files. It's better to use COPY than ADD as it's more explicit. ADD is good for tar files.
COPY poetry.lock poetry.lock
COPY pyproject.toml pyproject.toml

# install poetry
RUN pip install poetry

# do not create virtual env as docker itself is a virtual env
RUN poetry config virtualenvs.create false

RUN poetry install --no-dev

# Copy project files
COPY . .

# Run Flask
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
