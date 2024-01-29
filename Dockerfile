FROM ubuntu:22.04

ARG BUILDTIME
ARG REVISION
ARG TARGETPLATFORM
ARG VERSION

LABEL maintainer="Hans Jörg Wieland <hajo@ventx.de>" \
      org.opencontainers.image.authors="Hans Jörg Wieland <hajo@ventx.de>" \
      org.opencontainers.image.base.name="ubuntu:22.04" \
      org.opencontainers.image.created="${BUILDTIME}" \
      org.opencontainers.image.description="Helm Charts Pipeline runner container image" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.ref.name="ventx/helm3-ci" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.source="https://github.com/ventx/helm3-ci" \
      org.opencontainers.image.url="https://github.com/ventx/helm3-ci.git" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="ventx GmbH"

# Tool versions
ENV CT="3.10.1"
ENV DEBIAN_FRONTEND="noninteractive"
ENV HELM="3.14.0"
ENV HELM_DOCS="1.12.0"
ENV HELM_SECRETS="4.5.1"
ENV HELM_UNITTEST="0.4.1"
ENV KUBECTL="1.27.10"
ENV KUBESCORE="1.17.0"
ENV KUBESEC="2.14.0"
ENV KUBECONFORM="0.6.4"
ENV KUSTOMIZE="5.3.0"
ENV TZ="Europe/Berlin"
ENV YAMALE="4.0.4"
ENV YAMLLINT="1.33.0"
ENV YQ="4.40.5"

# hadolint: DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Instal packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  tzdata=2023d-0ubuntu0.22.04 \
  ca-certificates=20230311ubuntu0.22.04.1 \
  curl=7.81.0-1ubuntu1.15 \
  git=1:2.34.1-1ubuntu1.10 \
  gnupg=2.2.27-3ubuntu2.1 \
  jq=1.6-2.1ubuntu3 \
  make=4.3-4.1build1 \
  openssh-client=1:8.9p1-3ubuntu0.6 \
  python3-pip=22.0.2+dfsg-1ubuntu0.4 \
  wget=1.21.2-2ubuntu1 \
  && rm -rf /var/lib/apt/lists/*

# Config ca-certificates for wget
RUN echo "ca_certificate=/etc/ssl/certs/ca-certificates.crt" > "$HOME/.wgetrc"

# Set Timezone
RUN ln -fs "/usr/share/zoneinfo/$TZ" /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

# pip packages
RUN pip3 install --no-cache-dir \
    yamale=="${YAMALE}" \
    yamllint=="${YAMLLINT}"

# Helm3
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else echo "Unsupported Architecture" && exit 1; fi && \
    curl -sLS "https://get.helm.sh/helm-v${HELM}-linux-${ARCHITECTURE}.tar.gz" | tar -xzO "linux-${ARCHITECTURE}/helm" > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm

#  Helm plugins
RUN helm plugin install https://github.com/jkroepke/helm-secrets --version "v${HELM_SECRETS}" && \
    helm plugin install https://github.com/helm-unittest/helm-unittest --version "v${HELM_UNITTEST}"

# chart-testing
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else echo "Unsupported Architecture" && exit 1; fi && \
    curl -sLS "https://github.com/helm/chart-testing/releases/download/v${CT}/chart-testing_${CT}_linux_${ARCHITECTURE}.tar.gz" > /tmp/ct.tar.gz && \
    tar -xzf /tmp/ct.tar.gz -C /tmp/ && mv /tmp/ct /usr/local/bin/ct && chmod a+x /usr/local/bin/ct && mkdir /etc/ct && cp /tmp/etc/* /etc/ct/ && \
    rm -rf /tmp/*

# kubectl
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=linux/amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=linux/arm64; else echo "Unsupported Architecture" && exit 1; fi && \
  curl -sLS -o /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/${ARCHITECTURE}/kubectl" && \
  chmod +x /usr/local/bin/kubectl

# kube-score
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else echo "Unsupported Architecture" && exit 1; fi && \
    curl -sLS "https://github.com/zegl/kube-score/releases/download/v${KUBESCORE}/kube-score_${KUBESCORE}_linux_${ARCHITECTURE}" > /usr/local/bin/kube-score && \
    chmod +x /usr/local/bin/kube-score

# kubesec
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else echo "Unsupported Architecture" && exit 1; fi && \
    curl -sLS "https://github.com/controlplaneio/kubesec/releases/download/v${KUBESEC}/kubesec_linux_${ARCHITECTURE}.tar.gz" | tar -xzO kubesec > /usr/local/bin/kubesec && \
    chmod +x /usr/local/bin/kubesec

# kubeconform
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else echo "Unsupported Architecture" && exit 1; fi && \
    curl -sLS "https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM}/kubeconform-linux-${ARCHITECTURE}.tar.gz" | tar -xzO kubeconform > /usr/local/bin/kubeconform && \
    chmod +x /usr/local/bin/kubeconform

# helm-docs
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=x86_64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else echo "Unsupported Architecture" && exit 1; fi && \
    curl -sLS "https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS}/helm-docs_${HELM_DOCS}_Linux_${ARCHITECTURE}.tar.gz" | tar -xzO helm-docs > /usr/local/bin/helm-docs && \
    chmod +x /usr/local/bin/helm-docs

# kustomize
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
  curl -sLS "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE}/kustomize_v${KUSTOMIZE}_linux_${ARCHITECTURE}.tar.gz" | tar -xzO kustomize > /usr/local/bin/kustomize && \
  chmod +x /usr/local/bin/kustomize

# yq
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
  curl -sLS -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v${YQ}/yq_linux_${ARCHITECTURE} && \
  chmod +x /usr/local/bin/yq

WORKDIR /work

CMD ["helm", "version"]
