FROM alpine:3.11
LABEL maintainer="hajo@ventx.de"

ENV CT 3.0.0-rc.1
ENV HELM v3.2.0
ENV HELM_PUSH 0.8.1
ENV HELM_SECRETS 2.0.2
ENV HELM_UNITTEST 0.1.7-rancher1
ENV KUBEVAL 0.15.0
ENV KUBECTL 1.16.8
ENV YAMALE 2.0.1
ENV YAMLLINT 1.23.0

RUN apk --update --no-cache add \
  bash \
  curl \
  git \
  python3 \
  wget

# Helm3
RUN wget -qO- https://get.helm.sh/helm-${HELM}-linux-amd64.tar.gz | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm

#  Helm plugins
RUN helm plugin install https://github.com/chartmuseum/helm-push.git --version v${HELM_PUSH}
RUN helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELM_SECRETS} 
RUN helm plugin install https://github.com/rancher/helm-unittest --version v${HELM_UNITTEST} 

# kubeval
RUN wget -qO- https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL}/kubeval-linux-amd64.tar.gz | tar -xzO kubeval > /usr/local/bin/kubeval \
  && chmod +x /usr/local/bin/kubeval

# kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

# pip packages
RUN pip3 install --upgrade pip \
  && pip3 install yamale==${YAMALE} yamllint==${YAMLLINT}

# chart-testing
RUN wget -q https://github.com/helm/chart-testing/releases/download/v${CT}/chart-testing_${CT}_linux_amd64.tar.gz -O /tmp/chart-testing_linux_amd64.tar.gz \
  && tar xfz /tmp/chart-testing_linux_amd64.tar.gz -C /tmp/ \
  && mv /tmp/ct /usr/local/bin/ \
  && chmod +x /usr/local/bin/ct \
  && mv /tmp/etc /etc/ct


WORKDIR /work

CMD ["helm", "version"]
