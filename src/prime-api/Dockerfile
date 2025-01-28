FROM golang:1.23 AS build-stage
ARG VERSION

COPY go.mod ./
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /prime-api -ldflags="-X 'main.version=$VERSION'"


FROM gcr.io/distroless/base-debian11 AS runtime

WORKDIR /

COPY --from=build-stage /prime-api /prime-api

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/prime-api"]