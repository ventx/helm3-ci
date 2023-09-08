# helm3-ci

[![Docker Pulls](https://img.shields.io/docker/pulls/ventx/helm3-ci.svg)](https://hub.docker.com/r/ventx/helm3-ci/)

Multi-Arch image with tools and plugins for Helm Charts in **C**ontinous **I**ntegration pipelines.


## Docker Hub

[ventx/helm3-ci:2.2.1](https://hub.docker.com/r/ventx/helm3-ci) <!-- {x-release-please-version} -->


## Docker image

* OS: Ubuntu
* Version: 22.04 LTS ("Jammy")


## Architectures

* linux/amd64
* linux/arm64


## Installed Packages (apt)

* [ca-certificates](https://packages.ubuntu.com/jammy/ca-certificates)
* [curl](https://packages.ubuntu.com/jammy/curl)
* [git](https://packages.ubuntu.com/jammy/git)
* [gnupg](https://packages.ubuntu.com/jammy/gnupg)
* [jq](https://packages.ubuntu.com/jammy/jq)
* [make](https://packages.ubuntu.com/jammy/make)
* [openssh-client](https://packages.ubuntu.com/jammy/openssh-client)
* [python3-pip](https://packages.ubuntu.com/jammy/python3-pip)
* [tzdata](https://packages.ubuntu.com/jammy/tzdata)
* [wget](https://packages.ubuntu.com/jammy/wget)


# Installed Packages (go binaries)

* [chart-testing](https://github.com/helm/chart-testing)
* [helm](https://helm.sh/)
* [helm-docs](https://github.com/norwoodj/helm-docs)
* [kubeval](https://www.kubeval.com)
* [kubectl](https://github.com/kubernetes/kubectl)
* [kustomize](https://github.com/kubernetes-sigs/kustomize)
* [yq](https://github.com/mikefarah/yq)


# Installed Packages (Python3 - pip)

* [yamale](https://pypi.org/project/yamale/)
* [yamllint](https://pypi.org/project/yamllint/)


# Helm Plugins

* [helm-secrets](https://github.com/jkroepke/helm-secrets)
* [helm-unittest](https://github.com/helm-unittest/helm-unittest)
