# Changelog

## [2.4.0](https://github.com/ventx/helm3-ci/compare/2.3.0...2.4.0) (2024-01-29)


### Features

* add chart-testing default configs to /etc/ct so no explicit config needs to be provided ([121ca50](https://github.com/ventx/helm3-ci/commit/121ca50675a412679891757e03ad8776066382e3))
* version bump of all apt packages ([a991a0c](https://github.com/ventx/helm3-ci/commit/a991a0cc6b86015d0c137819ab3dae04489cda53))


### Bug Fixes

* chart-testing config files extraction and cleanup /tmp afterwards ([80133d4](https://github.com/ventx/helm3-ci/commit/80133d475680616cb647a13bea595b7e667fdfe3))

## [2.3.0](https://github.com/ventx/helm3-ci/compare/2.2.1...2.3.0) (2023-09-08)


### Features

* add yq, kustomize, version bump of all packages, removed schema for decrease overall image size ([bcd1e15](https://github.com/ventx/helm3-ci/commit/bcd1e154ab8b04d355b1231d29e39f487ad34dd7))

## [2.2.1](https://github.com/ventx/helm3-ci/compare/2.2.0...2.2.1) (2023-07-20)


### Bug Fixes

* set helm-docs binary executable ([9710f85](https://github.com/ventx/helm3-ci/commit/9710f859f7a7bb30feef860352143c1afdbff787))

## [2.2.0](https://github.com/ventx/helm3-ci/compare/2.1.0...2.2.0) (2023-07-20)


### Features

* add helm-docs and version bump of apt packages ([ca8ab15](https://github.com/ventx/helm3-ci/commit/ca8ab15bac8931b81b1652c4fc228de6d0e4a4c3))

## [2.1.0](https://github.com/ventx/helm3-ci/compare/2.0.0...2.1.0) (2023-07-04)


### Features

* add kubernetes-schema JSON files locally for air-gapped environments, based on KUBECTL version ([d2a26ba](https://github.com/ventx/helm3-ci/commit/d2a26ba1fa5c9ef8dd0f8fbfbafa52dc8b547484))

## [2.0.0](https://github.com/ventx/helm3-ci/compare/1.1.0...2.0.0) (2023-06-30)


### ⚠ BREAKING CHANGES

* v2
* v2
* v2, replace legacy kubeval with kubeconform, version bump of tools, switch to Ubuntu as base image, add MIT License, pre-commit hooks with hadolint, CI/CD GH Actions

### Features

* v2 ([9fd09a1](https://github.com/ventx/helm3-ci/commit/9fd09a1f1cc83f1bcc0cdc54eb9e53abb3eb3f61))
* v2 ([7e7a034](https://github.com/ventx/helm3-ci/commit/7e7a034ab380b1227c52fdb41307663265a4bd86))
* v2, replace legacy kubeval with kubeconform, version bump of tools, switch to Ubuntu as base image, add MIT License, pre-commit hooks with hadolint, CI/CD GH Actions ([a9c8954](https://github.com/ventx/helm3-ci/commit/a9c895476c6eea521dfd9e997fee334aff4a9f9e))
