rbenv_deps:
  pkg.installed:
    - pkgs:
      - bash
      - git
      - build-essential
      - openssl
      - curl
      - zlib1g
      - zlib1g-dev
      - libssl-dev
      - libyaml-dev
      - libsqlite3-0
      - libsqlite3-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - autoconf
      - libc6-dev
      - libncurses5-dev
      - automake
      - libtool
      - bison
      - libreadline5 

/tmp/ruby-build:
  file.directory:
    - makedirs: True

download_ruby_build:
  git.latest:
    - name: https://github.com/sstephenson/ruby-build.git
    - rev: master
    - target: /tmp/ruby-build
    - force: True
    - require:
      - pkg: rbenv_deps
      - file: /tmp/ruby-build

install_ruby_build:
  cmd.run:
    - name: /tmp/ruby-build/install.sh
    - require:
      - git: download_ruby_build

/usr/local/rbenv:
  file.directory:
    - makedirs: True

download_rbenv:
  git.latest:
    - name: https://github.com/sstephenson/rbenv.git
    - rev: master
    - target: /usr/local/rbenv
    - force: True
    - require:
      - file: /usr/local/rbenv

create_rbenv_sh:
  file.managed:
    - name: /etc/profile.d/rbenv.sh
    - create: True

/etc/profile.d/rbenv.sh:
  file.append:
    - text:
      - export RBENV_ROOT=/usr/local/rbenv
      - export PATH="$RBENV_ROOT/bin:$PATH"
      - eval "$(rbenv init -)"
    - require:
      - file: create_rbenv_sh
      - git: download_rbenv

ruby_build_path:
  cmd.run:
    - name: export PATH=$PATH:/usr/local/bin

install_ruby:
  cmd.run:
    - name: rbenv install 2.1.0
    - unless: ls /usr/local/rbenv/versions/2.1.0
    - require:
      - git: download_rbenv
      - git: download_ruby_build
      - cmd: install_ruby_build

set_global_ruby:
  cmd.run:
    - name: rbenv global 2.1.0
    - require:
      - cmd: install_ruby

rbenv_rehash:
  cmd.run:
    - name: rbenv rehash
    - require:
      - cmd: set_global_ruby

