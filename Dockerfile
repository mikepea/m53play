# Build Stage
FROM lacion/alpine-golang-buildimage:1.12.4 AS build-stage

LABEL app="build-m53play"
LABEL REPO="https://github.com/mikepea/m53play"

ENV PROJPATH=/go/src/github.com/mikepea/m53play

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/mikepea/m53play
WORKDIR /go/src/github.com/mikepea/m53play

RUN make build-alpine

# Final Stage
FROM lacion/alpine-base-image:latest

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/mikepea/m53play"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/m53play/bin

WORKDIR /opt/m53play/bin

COPY --from=build-stage /go/src/github.com/mikepea/m53play/bin/m53play /opt/m53play/bin/
RUN chmod +x /opt/m53play/bin/m53play

# Create appuser
RUN adduser -D -g '' m53play
USER m53play

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/m53play/bin/m53play"]
