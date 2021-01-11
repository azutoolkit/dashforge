FROM crystallang/crystal:0.35.1-alpine
WORKDIR /opt/app
ENV PATH /opt/app/bin:$PATH
COPY . /opt/app
RUN shards update
RUN crystal build --release --static ./src/start.cr -o ./start
CMD ["crystal", "spec"]

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /opt/app/start .
COPY --from=0 /opt/app/public ./public
COPY --from=0 /opt/app/src/templates ./src/templates