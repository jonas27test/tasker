FROM golang:1.14 as builder
COPY cmd /build/cmd
COPY go.mod go.sum /build/
WORKDIR /build
RUN useradd scratchuser && \
    export GOPATH="" && go mod vendor && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o /jwt-backend ./cmd/jwt-backend

FROM alpine
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs
COPY --from=builder /jwt-backend /jwt-backend
COPY --from=builder /etc/passwd /etc/passwd
USER scratchuser
CMD ["/jwt-backend"]
ENTRYPOINT ["/jwt-backend"]