# jq
FROM flant/jq:b6be13d5-musl as libjq

# build
FROM golang:1.21.0-alpine3.18 AS builder

ARG appVersion=latest
RUN apk add git ca-certificates gcc musl-dev libc-dev

ADD go.mod go.sum /app/
WORKDIR /app
RUN go mod download

COPY --from=libjq /libjq /libjq
ADD . /app

RUN CGO_ENABLED=1 \
    CGO_CFLAGS="-I/libjq/include" \
    CGO_LDFLAGS="-L/libjq/lib" \
    GOOS=linux \
    go build -ldflags="-linkmode external -extldflags '-static' -s -w -X 'github.com/flant/shell-operator/pkg/app.Version=$appVersion'" \
        -tags use_libjq \
        -o shell-operator \
        ./cmd/shell-operator

# image
FROM ubuntu:22.04

RUN apt update && apt install -y ca-certificates tini sed jq
RUN mkdir /hooks
ADD frameworks/shell /frameworks/shell
ADD shell_lib.sh /

COPY --from=builder /app/shell-operator /

WORKDIR /
ENV SHELL_OPERATOR_HOOKS_DIR /hooks
ENV LOG_TYPE json
ENTRYPOINT ["/bin/tini", "--", "/shell-operator"]
CMD ["start"]
