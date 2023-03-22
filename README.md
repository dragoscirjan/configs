# Templ Python

[![HitCount](http://hits.dwyl.com/templ-project/python.svg)](http://hits.dwyl.com/templ-project/python)
[![Contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/templ-project/python/issues)
![Python Version](https://img.shields.io/badge/python-3.6%7C3.7%7C3.8%7C%2B-blue)
[![TravisCI](https://travis-ci.org/templ-project/python.svg?branch=master)](https://travis-ci.org/templ-project/python)
<!-- CI Badges -->
<!-- [![CircleCI](https://circleci.com/gh/templ-project/python.svg?style=shield)](https://circleci.com/gh/templ-project/python) -->

<!-- Donation Badges -->
[![Donate to this project using Patreon](https://img.shields.io/badge/patreon-donate-yellow.svg)](https://patreon.com/dragoscirjan)
[![Donate to this project using Paypal](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QBP6DEBJDEMV2&source=url)

[![Sonarcloud Status](https://sonarcloud.io/api/project_badges/measure?project=templ-project_python&metric=alert_status)](https://sonarcloud.io/dashboard?id=templ-project_python)
[![SonarCloud Coverage](https://sonarcloud.io/api/project_badges/measure?project=templ-project_python&metric=coverage)](https://sonarcloud.io/component_measures/metric/coverage/list?id=templ-project_python)
[![SonarCloud Bugs](https://sonarcloud.io/api/project_badges/measure?project=templ-project_python&metric=bugs)](https://sonarcloud.io/component_measures/metric/reliability_rating/list?id=templ-project_python)
[![SonarCloud Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=templ-project_python&metric=vulnerabilities)](https://sonarcloud.io/component_measures/metric/security_rating/list?id=templ-project_python)

<img alt="Python logo" src="https://github.com/templ-project/python/blob/master/python_logo.png?raw=true" width="20%" align="right" />

> *Any fool can write code that a computer can understand. Good programmers write code that humans can understand.* – Martin Fowler

> **python** is a template project, designed by [Templ Project](http://templ-project.github.io).
>
> **python** includes instructions for initializing a new [Pyhon](https://python.org) project, and configuring it for
> development, unit testing as well as code linting and analysis.
>
> **python** implements:
>
> - [flake8](https://gitlab.com/pycqa/flake8), [dead](https://github.com/asottile/dead), [radon](https://github.com/yunojuno/pre-commit-xenon) for code analisys
> - [autopep8](https://github.com/hhatto/autopep8), , [pep257](https://github.com/FalconSocial/pre-commit-mirrors-pep257) for code formatting
> - [pylint](https://github.com/PyCQA/pylint), [mypy](https://github.com/pre-commit/mirrors-mypy) for linting

## Getting Started

### Prereqiusites / Dependencies

##### For Windows

- Please install [git-scm](https://git-scm.com/download/win) tool.
- Please install a form of make
  - Install [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm)
  - Install [make](https://sourceforge.net/projects/ezwinports/files/) from [ezwinports](https://sourceforge.net/projects/ezwinports/files/)
  - Install [chocolatey](https://chocolatey.org/), run `choco install make`

##### For Linux/Unix/OSX

- Please install `git` and `make`

```bash
# i.e debian
sudo apt-get install git make -y
# i.e mac OS
brew install make git
```

#### Known Issues / Troubleshooting

- Running Travis CI with Windows fails on `coverage`. Seems Travis CI Windows image has an issue with this.
- Python support starts with version 3.6 and above.

### Installation

1. Clone the project
2. Remove .git folder
3. Re-initialize your git repository
4. Use `make init` to initialize your project
5. If you're targeting to write an application and not a module, use `make init MOD=app`
6. Run `make configure` to configure project or
7. Run `make venv` to create a virtual environment (`make venv` is included in `make configure`)
8. Run `make` to see all your pre-implemented options

```bash
git clone https://github.com/templ-project/python your_project
cd your_project
rm -rf .git
git init
git add remote origin https://url/to/your/project/repository
git add .
git commit -am "init"
git push origin master
make init PROJECT=your_project MODE=mod
# make init PROJECT=your_project MODE=app
make configure
# make venv
# make
```

#### Python version

Most Linux versions, come with python 2.7 as default. The rest of python versions that are installed, can be found having a name similar to `python3.x`, i.e `python3.5`.

To allow using a specific python version, create a file called `Makefile.py-version.include` which should include the following:

```makefile
PY = python3.8
PIP = pip3.8
```

or 

```makefile
PY = /path/to/my/version/of/python
PIP = /path/to/my/version/of/pip
```

When runing `make venv`, the version used by the `Makefile` will be the one defined in this file. 

### Development

#### Requirements

- Please install [Python](https://python.org). Project support **python 3.6 and above**.
- Please instal a Python IDE
  - [Visual Studio Code](https://code.visualstudio.com/) with [ITMCDev Python Extension Pack](https://marketplace.visualstudio.com/items?itemName=itmcdev.python-extension-pack)
  - [JetBrains PyCharm](https://www.jetbrains.com/pycharm/)
  - [Vim](https://www.vim.org/) (see here a [tutorial](https://www.fullstackpython.com/vim.html) for making Vim a Python IDE)
  - Any other IDE you trust.

### Testing

Run unit tests using `make test`.

Testing is currently set to use unittest.

- or you could use `make test TEST_LIB=pytest`
- or you could alter `Makefile.mod.include` to use pytest by default. Just change the commented line as showed:

```makefile
# TEST_LIB=unittest
TEST_LIB=pytest
```

#### Single Tests

Run single unit tests file, by calling `make test-single TEST_PATH=./path/to/file.py`

```bash
make test-single TEST_PATH=./your-project/test/hello.py
```

### Deployment

Adapt `release` directive in your Makefile to fit your needs.

> `make release` will know how to increment version and create tags on its own.

## Authors

* [Dragos Cirjan](mailto:dragos.cirjan@gmail.com) - Initial work

## Issues / Support

Add a set of links to the [issues](/templ-project/python/issues) page/website, so people can know where to add issues/bugs or ask for support.

## License

(If the package is public, add licence)
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

<!-- ## Changelog

Small changelog history. The rest should be added to [CHANGELOG.md](CHANGELOG.md).

See here a template for changelogs: https://keepachangelog.com/en/1.0.0/

Also see this tool for automatically generating them: https://www.npmjs.com/package/changelog -->

> Remove Everything above this line

<hr />












# Project Title

<!-- Set of shield/badges explaining where to find more information about the project (i.e. Where to look for unit test reports, where to see code coverage and code scans, etc.). You can find a lot of them on https://shields.io/) -->

<!-- CI Badges -->
<!-- [![TravisCI](https://travis-ci.org/templ-project/go.svg?branch=master)](https://travis-ci.org/templ-project/go) -->
<!-- [![CircleCI](https://circleci.com/gh/templ-project/go.svg?style=shield)](https://circleci.com/gh/templ-project/go) -->

<!-- Sonar Badges -->
<!-- [![Sonarcloud Status](https://sonarcloud.io/api/project_badges/measure?project=templ-project_go&metric=alert_status)](https://sonarcloud.io/dashboard?id=templ-project_go)
[![SonarCloud Coverage](https://sonarcloud.io/api/project_badges/measure?project=templ-project_go&metric=coverage)](https://sonarcloud.io/component_measures/metric/coverage/list?id=templ-project_go)
[![SonarCloud Bugs](https://sonarcloud.io/api/project_badges/measure?project=templ-project_go&metric=bugs)](https://sonarcloud.io/component_measures/metric/reliability_rating/list?id=templ-project_go)
[![SonarCloud Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=templ-project_go&metric=vulnerabilities)](https://sonarcloud.io/component_measures/metric/security_rating/list?id=templ-project_go) -->

<!-- Donation Badges -->
<!-- [![Donate to this project using Patreon](https://img.shields.io/badge/patreon-donate-yellow.svg)](https://patreon.com/dragoscirjan)
[![Donate to this project using Paypal](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=UMMN8JPLVAUR4&source=url)
[![Donate to this project using Flattr](https://img.shields.io/badge/flattr-donate-yellow.svg)](https://flattr.com/profile/balupton)
[![Donate to this project using Liberapay](https://img.shields.io/badge/liberapay-donate-yellow.svg)](https://liberapay.com/dragoscirjan)
[![Donate to this project using Thanks App](https://img.shields.io/badge/thanksapp-donate-yellow.svg)](https://givethanks.app/donate/npm/badges)
[![Donate to this project using Boost Lab](https://img.shields.io/badge/boostlab-donate-yellow.svg)](https://boost-lab.app/dragoscirjan/badges)
[![Donate to this project using Buy Me A Coffee](https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg)](https://buymeacoffee.com/balupton)
[![Donate to this project using Open Collective](https://img.shields.io/badge/open%20collective-donate-yellow.svg)](https://opencollective.com/dragoscirjan)
[![Donate to this project using Cryptocurrency](https://img.shields.io/badge/crypto-donate-yellow.svg)](https://dragoscirjan.me/crypto)
[![Donate to this project using Paypal](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://dragoscirjan.me/paypal)
[![Buy an item on our wishlist for us](https://img.shields.io/badge/wishlist-donate-yellow.svg)](https://dragoscirjan.me/wishlist)
-->

One Paragraph of project description goes here

<!--
Insert Table of Contents Here
This can be done using [AlanWalk.markdown-toc](https://marketplace.visualstudio.com/items?itemName=AlanWalk.markdown-toc) plugin, 
which is also included in 
[itmcdev.generic-extension-pack](https://marketplace.visualstudio.com/items?itemName=itmcdev.generic-extension-pack) extension pack.
-->
<!-- TOC -->

- [Templ Python](#templ-python)
  - [Getting Started](#getting-started)
    - [Prereqiusites / Dependencies](#prereqiusites--dependencies)
        - [For Windows](#for-windows)
        - [For Linux/Unix/OSX](#for-linuxunixosx)
      - [Known Issues / Troubleshooting](#known-issues--troubleshooting)
    - [Installation](#installation)
      - [Python version](#python-version)
    - [Development](#development)
      - [Requirements](#requirements)
    - [Testing](#testing)
      - [Single Tests](#single-tests)
    - [Deployment](#deployment)
  - [Authors](#authors)
  - [Issues / Support](#issues--support)
  - [License](#license)
- [Project Title](#project-title)
  - [Getting Started](#getting-started-1)
    - [Prereqiusites / Dependencies](#prereqiusites--dependencies-1)
      - [For Windows](#for-windows-1)
      - [For Linux](#for-linux)
      - [Known Issues / Troubleshooting](#known-issues--troubleshooting-1)
    - [Installation](#installation-1)
      - [Say what the step will be](#say-what-the-step-will-be)
      - [And repeat](#and-repeat)
    - [Development](#development-1)
    - [Testing](#testing-1)
      - [Break down into (at least) unit tests](#break-down-into-at-least-unit-tests)
      - [and end to end tests](#and-end-to-end-tests)
      - [And coding style tests](#and-coding-style-tests)
    - [Deployment](#deployment-1)
  - [Authors](#authors-1)
  - [Issues / Support](#issues--support-1)
  - [License](#license-1)
  - [Changelog](#changelog)

<!-- /TOC -->

## Getting Started

### Prereqiusites / Dependencies

What things you need to install the software and how to install them (based on each OS type). 

#### For Windows
```bash
# Give Examples

npm install -g node-gyp windows-build-tools
# Warning: Please note windows-build-tools will install MSVS which takes a 
# LONG amount of time.
```

#### For Linux

```bash
# Give Examples

apt-get install build-essential mono
npm install -y node-gyp
```

#### Known Issues / Troubleshooting

Describe a list of known issues, and how to bypass them.

### Installation

A step by step series of examples that tell you how to get a development env running


#### Say what the step will be

```
Give the example
```

#### And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

### Development

Explain any development process for the project, if necesary

```
give examples
```

### Testing


Explain how to run the automated tests for this system

#### Break down into (at least) unit tests
Explain what these tests test and why

```
Give an example
```

#### and end to end tests
Explain what these tests test and why

```
Give an example
```

#### And coding style tests

Explain what these tests test and why

```
Give an example
```

### Deployment

Add additional notes about how to deploy this on a live system

## Authors
* [Dragos Cirjan](mailto:dragos.cirjan@gmail.com) - Initial work - [PurpleBooth](#link-to-change)

See also the list of contributors who participated in this project.

## Issues / Support

Add a set of links to the [issues](/templ-project/go/issues) page/website, so people can know where to add issues/bugs or ask for support.

## License

(If the package is public, add licence)
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Changelog

Small changelog history. The rest should be added to [CHANGELOG.md](CHANGELOG.md).

See here a template for changelogs: https://keepachangelog.com/en/1.0.0/

Also see this tool for automatically generating them: https://www.npmjs.com/package/changelog
