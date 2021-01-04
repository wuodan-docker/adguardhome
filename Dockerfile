FROM alpine:latest AS build

WORKDIR /src
ADD https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv6.tar.gz /src/AdGuardHome_linux_armv6.tar.gz
RUN tar -xf AdGuardHome_linux_armv6.tar.gz

FROM alpine:latest

# Update CA certs
RUN apk --no-cache --update add ca-certificates && \
    rm -rf /var/cache/apk/* && mkdir -p /opt/adguardhome

COPY --from=build /src/AdGuardHome/AdGuardHome /opt/adguardhome/AdGuardHome

EXPOSE 53/tcp 53/udp 67/tcp 67/udp 68/tcp 68/udp 80/tcp 443/tcp 853/tcp 853/udp 3000/tcp

VOLUME ["/opt/adguardhome/conf", "/opt/adguardhome/work"]

ENTRYPOINT ["/opt/adguardhome/AdGuardHome"]
CMD ["-h", "0.0.0.0", "-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work"]
