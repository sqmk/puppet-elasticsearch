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

  $destination_dir  = '/usr/local/src/elasticsearch'
  $destination_file = '{$destination_dir}/${version}.deb'

  file { $src_dir:
    ensure => 'directory'
  }

  wget::fetch { 'elasticsearch deb':
    source      => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb",
    destination => $destination,
    timeout     => 0,
    verbose     => false
  }

  exec { 'elasticsearch installation':
    command => "dpk -i ${destination_file}",
    creates => '/etc/init.d/elasticsearch',
    require => Wget::Fetch['elasticsearch deb'],
    notify  => Service['elasticsearch']
  }

  service { 'elasticsearch':
    ensure => running
  }
}
