FROM alpine:3.11
LABEL maintainer="hajo@ventx.de"

ENV HELM v3.2.0
ENV HELM_S3 0.9.2
ENV HELM_SECRETS 2.0.2
ENV HELM_UNITTEST v0.1.7-rancher1
ENV KUBEVAL 0.15.0

RUN apk --update --no-cache add \
  bash \
  curl \
  git \
  wget

# Install Helm3
RUN wget -qO- https://get.helm.sh/helm-${HELM}-linux-amd64.tar.gz | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm


# Install Helm plugin
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${HELM_S3} 
RUN helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELM_SECRETS} 
RUN helm plugin install https://github.com/rancher/helm-unittest --version ${HELM_UNITTEST} 

# Install kubeval
RUN wget -qO- https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL}/kubeval-linux-amd64.tar.gz | tar -xzO kubeval > /usr/local/bin/kubeval \
  && chmod +x /usr/local/bin/kubeval

WORKDIR /work

CMD ["helm", "version"]
