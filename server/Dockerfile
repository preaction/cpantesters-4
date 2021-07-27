ARG TAG=latest
FROM preaction/yancy:${TAG}-pg
COPY . /app
WORKDIR /app
ENTRYPOINT ["perl", "script/cpantesters"]
CMD ["prefork"]
