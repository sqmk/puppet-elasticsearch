# == Class: elasticsearch
# 
# Class for managing ElasticSearch installation.
#
# === Parameters
# 
# [*version*]
#   Version of ElasticSearch to install.
# 
# === Examples
# 
# * Install and run the ElasticSearch service:
#     class {'elasticsearch': }
#
# === Authors
# 
# Michael K. Squires <sqmk@php.net>
#
class elasticsearch (
  $version = '0.90.2'
) {
  include wget

  $destination_dir  = '/usr/local/src/elasticsearch'
  $destination_file = "${destination_dir}/elastic-search-${version}.deb"

  file { $destination_dir:
    ensure => 'directory',
    before => Wget::Fetch['elasticsearch_deb'],
  }

  wget::fetch { 'elasticsearch_deb':
    source      => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb",
    destination => $destination_file,
    timeout     => 0,
    verbose     => true
  }

  exec { 'elasticsearch installation':
    command => "dpkg -i ${destination_file}",
    creates => '/etc/init.d/elasticsearch',
    require => Wget::Fetch['elasticsearch_deb'],
    notify  => Service['elasticsearch']
  }

  service { 'elasticsearch':
    ensure => running
  }
}
