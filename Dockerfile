FROM python:3.10


# Configure Poetry.

ENV POETRY_VERSION=1.2.1
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VENV=/opt/poetry-venv
ENV POETRY_CACHE_DIR=/opt/.cache


# Install Poetry.

RUN python3 -m venv $POETRY_VENV \
    && $POETRY_VENV/bin/pip install -U pip setuptools \
    && $POETRY_VENV/bin/pip install poetry==${POETRY_VERSION}


# Add `poetry` to PATH.

ENV PATH="${PATH}:${POETRY_VENV}/bin"


WORKDIR /app
COPY . /app


# Install dependencies.

COPY pyproject.toml ./
RUN poetry install


# Run the app.

CMD [ "poetry", "run", "python", "-c", "print('Hello, World!')" ]
