FROM alpine:3.11
LABEL maintainer="hajo@ventx.de"

ENV HELM3_VERSION v3.2.0
ENV HELMS3_VERSION 0.9.2
ENV HELMSECRETS_VERSION 2.0.2

RUN apk --update --no-cache add \
  bash \
  curl \
  git \
  wget

# Install Helm3
RUN wget -qO- https://get.helm.sh/helm-${HELM3_VERSION}-linux-amd64.tar.gz | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm


# Install Helm plugin
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${HELMS3_VERSION} 
RUN helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELMSECRETS_VERSION} 

WORKDIR /work

CMD ["helm", "version"]
