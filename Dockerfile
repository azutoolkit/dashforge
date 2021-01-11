FROM crystallang/crystal:latest-alpine
WORKDIR /opt/app
COPY . /opt/app
RUN shards install
RUN crystal build --release --static ./src/start.cr -o ./start
CMD ["crystal", "spec"]

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /opt/app/start .
COPY --from=0 /opt/app/public ./public
COPY --from=0 /opt/app/src/templates ./src/templates
CMD ["./start"]