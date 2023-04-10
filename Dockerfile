FROM panubo/sshd:1.5.0

LABEL maintainer="Salvoxia <salvoxia@blindfish.info>"

# Testing: pamtester
RUN apk add --no-cache awake
