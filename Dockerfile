FROM alpine:latest AS build

ARG APP_VERSION=0.104.3

ADD https://github.com/AdguardTeam/AdGuardHome/releases/download/v$APP_VERSION/AdGuardHome_linux_armv6.tar.gz \
	/src/AdGuardHome_linux_armv6.tar.gz

RUN cd /src && \
	tar -xf AdGuardHome_linux_armv6.tar.gz


FROM alpine:latest

WORKDIR /opt/adguardhome

ADD cmd.sh /opt/adguardhome/

COPY --from=build /src/AdGuardHome/AdGuardHome /opt/adguardhome/
COPY --from=build /src/AdGuardHome/LICENSE.txt /opt/adguardhome/

# Update CA certs
RUN apk --no-cache --update add ca-certificates sudo && \
	chmod ugo+x cmd.sh && \
	chown -R nobody:nogroup . && \
	rm -rf /var/cache/apk/* /tmp/* /var/tmp/

EXPOSE	53/tcp 53/udp \
		67/tcp 67/udp 68/tcp 68/udp \
		80/tcp 443/tcp \
		853/tcp 853/udp \
		3000/tcp

VOLUME /opt/adguardhome/conf
VOLUME /opt/adguardhome/work

CMD ./cmd.sh
