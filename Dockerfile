FROM  python:3.6

ENV PYTHONUNBUFFERED 1
RUN mkdir /live_project
WORKDIR /live_project

COPY . /live_project/

RUN pip install -r req.txt


