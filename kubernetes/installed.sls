{% from "kubernetes/map.jinja" import config with context %}

pkg-core:
  pkg.installed:
    - names:
      - curl
      - ebtables
      - logrotate
{% if grains['os_family'] == 'RedHat' %}
      - python
      - git
      - socat
{% else %}
      - apt-transport-https
      - python-apt
      - nfs-common
      - socat
{% endif %}
# Ubuntu installs netcat-openbsd by default, but on GCE/Debian netcat-traditional is installed.
# They behave slightly differently.
# For sanity, we try to make sure we have the same netcat on all OSes (#15166)
{% if grains['os'] == 'Ubuntu' %}
      - netcat-traditional
{% endif %}
# Make sure git is installed for mounting git volumes
{% if grains['os'] == 'Ubuntu' %}
      - git
{% endif %}

