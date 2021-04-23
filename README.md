# helm3-ci

Small Alpine Docker image with tools and plugins for Helm charts in **C**ontinous **I**ntegration pipelines.


## Docker Hub

[ventx/helm3-ci](https://cloud.docker.com/u/ventx/repository/docker/ventx/helm3-ci)


# Docker base image

* OS: [Alpine Linux](https://alpinelinux.org/)
* Version: 3.13


# Installed Packages

* [bash](https://pkgs.alpinelinux.org/packages?name=bash&branch=v3.13)
* [curl](https://pkgs.alpinelinux.org/packages?name=curl&branch=v3.13)
* [git](https://pkgs.alpinelinux.org/packages?name=git&branch=v3.13)
* [make](https://pkgs.alpinelinux.org/packages?name=make&branch=v3.13)
* [openssh-client](https://pkgs.alpinelinux.org/packages?name=openssh-client&branch=v3.13)
* [python3](https://pkgs.alpinelinux.org/packages?name=python3&branch=v3.13)
* [py3-pip](https://pkgs.alpinelinux.org/packages?name=py3-pip&branch=v3.13)


# Installed Packages (go binaries)

* [chart-testing](https://github.com/helm/chart-testing) `v3.3.1`
* [helm](https://helm.sh/) `v3.5.4`
* [kubeval](https://www.kubeval.com) `v0.16.1`
* [kubectl](https://github.com/kubernetes/kubectl) `v1.19.6`

# Installed Packages (Python3 - pip)

* [yamale](https://pypi.org/project/yamale/) `3.0.4`
* [yamllint](https://pypi.org/project/yamllint/) `1.26.1`


# Helm Plugins

* [helm-secrets](https://github.com/jkroepke/helm-secrets) `v3.6.1`
* [helm-unittest](https://github.com/quintush/helm-unittest) `v0.2.6`