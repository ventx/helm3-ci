FROM alpine:3.13

LABEL maintainer="hajo@ventx.de" \
      org.opencontainers.image.title="ventx/helm3-ci" \
      org.opencontainers.image.description="Helm Charts Pipeline runner container image" \
      org.opencontainers.image.source="https://github.com/ventx/helm3-ci" \
      org.opencontainers.image.vendor="ventx"

# Tool versions
ENV CT 3.3.1
ENV HELM 3.5.4
ENV HELM_SECRETS 3.6.1
ENV HELM_UNITTEST 0.2.6
ENV KUBECTL 1.19.6
ENV KUBESCORE 1.11.0
ENV KUBESEC 2.11.0
ENV KUBEVAL 0.16.1
ENV YAMALE 3.0.4
ENV YAMLLINT 1.26.1

# apk package versions
ENV BASH 5.1.0-r0
ENV CURL 7.76.1-r0
ENV GIT 2.30.2-r0
ENV MAKE 4.3-r0
ENV OPENSSH_CLIENT 8.4_p1-r3
ENV PYTHON3 3.8.8-r0
ENV PY3_PIP 20.3.4-r0

RUN apk --update --no-cache add \
  bash="${BASH}" \
  curl="${CURL}" \
  git="${GIT}" \
  make="${MAKE}" \
  openssh-client="${OPENSSH_CLIENT}" \
  python3="${PYTHON3}" \
  py3-pip="${PY3_PIP}" \
  && rm -rf /var/cache/apk/*

# pip packages
RUN pip3 install --no-cache-dir \
    yamale=="${YAMALE}" \
    yamllint=="${YAMLLINT}"

# Helm3
RUN curl -Ls "https://get.helm.sh/helm-v${HELM}-linux-amd64.tar.gz" | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm

#  Helm plugins
RUN helm plugin install https://github.com/jkroepke/helm-secrets --version "v${HELM_SECRETS}"
RUN helm plugin install https://github.com/quintush/helm-unittest --version "v${HELM_UNITTEST}"

# chart-testing
RUN curl -Ls https://github.com/helm/chart-testing/releases/download/v${CT}/chart-testing_${CT}_linux_amd64.tar.gz | tar -xzO ct > /usr/local/bin/ct && \
    chmod +x /usr/local/bin/ct

# kubectl
RUN curl -Ls "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# kube-score
RUN curl -Ls "https://github.com/zegl/kube-score/releases/download/v${KUBESCORE}/kube-score_${KUBESCORE}_linux_amd64" > /usr/local/bin/kube-score && \
    chmod +x /usr/local/bin/kube-score

# kubesec
RUN curl -Ls "https://github.com/controlplaneio/kubesec/releases/download/v${KUBESEC}/kubesec_linux_amd64.tar.gz" | tar -xzO kubesec > /usr/local/bin/kubesec && \
    chmod +x /usr/local/bin/kubesec

# kubeval
RUN curl -Ls "https://github.com/instrumenta/kubeval/releases/download/v${KUBEVAL}/kubeval-linux-amd64.tar.gz" | tar -xzO kubeval > /usr/local/bin/kubeval && \
    chmod +x /usr/local/bin/kubeval

WORKDIR /work

CMD ["helm", "version"]
