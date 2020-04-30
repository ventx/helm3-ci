# helm3-ci

Small Alpine Docker image with kubeval, Helm3, helm-push, helm-secrets and helm-unittest plugins for Continous Integration.


## Docker Hub

[ventx/helm3-ci](https://cloud.docker.com/u/ventx/repository/docker/ventx/helm3-ci)


# Docker image

* OS: Alpine
* Version: 3.11


# Installed Packages

* [bash](https://pkgs.alpinelinux.org/package/v3.11/community/x86_64/bash)
* [curl](https://pkgs.alpinelinux.org/package/v3.11/community/x86_64/curl)
* [git](https://pkgs.alpinelinux.org/package/v3.11/community/x86_64/git)
* [wget](https://pkgs.alpinelinux.org/package/v3.11/community/x86_64/wget)


# Installed Packages (go binaries)

* [helm](https://helm.sh/) `v3.2.0`
* [kubeval](https://www.kubeval.com/) `0.15.0`


# Helm Plugins

* [helm-secrets](https://github.com/zendesk/helm-secrets) `2.0.2`
* [helm-push](https://github.com/chartmuseum/helm-push) `v0.8.1`
* [helm-unittest](https://github.com/rancher/helm-unittest) `v0.1.7-rancher1`

