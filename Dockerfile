FROM golang:1.17.4-buster AS build-env

WORKDIR /go/src/github.com/isbalashov/co2monitor
COPY . ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -ldflags "-w -s"  -a -installsuffix cgo -o /out/co2monitor

FROM scratch
COPY --from=build-env /out/co2monitor /
ENTRYPOINT [ "./co2monitor" ] 