FROM crystallang/crystal:latest-alpine
WORKDIR /opt/app
COPY . /opt/app
RUN shards install
RUN crystal build --release --static ./src/dashforge.cr -o ./start
CMD ["crystal", "spec"]

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /opt/app/start .
COPY --from=0 /opt/app/public ./public
CMD ["./start"]