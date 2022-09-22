FROM alpine:latest

ARG user
# Create a group and user
RUN addgroup -S appgroup && adduser -G $appgroup -S $user

# Tell docker that all future commands should run as the appuser user
USER $user

RUN apk --update --no-cache add nodejs npm python3 py3-pip jq curl bash git docker && \
	ln -sf /usr/bin/python3 /usr/bin/python

COPY --from=golang:alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
