FROM alpine:3.9.2

RUN apk add --no-cache python3 zip && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
	pip3 install --upgrade pip setuptools && \
	pip3 install --no-cache-dir 'awscli>=1,<2' && \
	rm -r /root/.cache && \
	mkdir /root/.aws && \
	aws --version

CMD ["ash"]
