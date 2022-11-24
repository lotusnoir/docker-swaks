FROM alpine:3.17

LABEL maintainer="lotusnoir"

ENV SWAKS_VERSION=20201014.0
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk add --update --no-cache perl perl-net-ssleay perl-net-dns curl make tzdata; \
    (yes "" 2>/dev/null || true) | perl -MCPAN -e 'install Authen::NTLM' \
    rm -rf /root/.cpan \
    apk remove make
RUN curl -SLk https://www.jetmore.org/john/code/swaks/files/swaks-$SWAKS_VERSION/swaks -o /usr/bin/swaks; \
    chmod +x /usr/bin/swaks;

ENTRYPOINT ["/usr/bin/swaks"]
