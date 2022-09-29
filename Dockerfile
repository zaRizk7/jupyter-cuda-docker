FROM tensorflow/tensorflow:latest

EXPOSE 8888 8889

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -y

RUN apt-get install tmux -y

RUN pip install --upgrade pip pip-tools

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip-compile ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages

RUN curl -fsSL https://code-server.dev/install.sh | sh

ADD run /bin

ADD inspect /bin

RUN chmod +x /bin/run /bin/inspect
