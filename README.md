# cygwin_git_encrypt

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with cygwin_git_encrypt](#setup)
    * [What cygwin_git_encrypt affects](#what-cygwin_git_encrypt-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cygwin_git_encrypt](#beginning-with-cygwin_git_encrypt)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module to setup shadowhand/git-encrypt for CygWin


## Module Description

shadowhand/git-encrypt for CygWin

## Setup

include cygwin_git_encrypt

### What cygwin_git_encrypt affects

* Creates /vendor directory if it does not exist
* Creates /vendor/git-encrypt directory if it does not exist
* Clone/pull shadowhand/git-encrypt into /vendor/git-encrypt
* Creates symlink(s) from /usr/local/bin/ /vendor/git-encrypt


### Setup Requirements **OPTIONAL**

Puppet modules required: 
* puppetslab-stdlib
* puppetslab-vcsrepo
* puppetslab-git


### Beginning with cygwin_git_encrypt


## Usage

Just do this:
include cygwin_git_encrypt


## Reference

## Limitations

## Development

## Release Notes/Contributors/Etc **Optional**
