# ElasticSearch Puppet module

This Puppet module is used for installing and managing ElasticSearch.

## Requirements

This module has dependencies on the following:
- maestrodev/wget
- puppetlabs/java

## Module Installation

This currently works only for Debian and Ubuntu systems.

### Via Puppet module install

Run the following from shell:
```bash
$ puppet module install sqmk-elasticsearch
```

### Via git

You can clone this repo into your modules directory:

```bash
$ git clone https://github.com/sqmk/puppet-elasticsearch.git
```

## Installing ElasticSearch via Puppet manifest

Include the following in your manifest to install ElasticSearch

```puppet
class { 'elasticsearch': }
```

Need a specific version of ElasticSearch?
```puppet
class { 'elasticsearch':
  version => '0.20.2'
}
```
