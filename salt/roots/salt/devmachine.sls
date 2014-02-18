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
      - subversion

/home/glen/.rbenv:
  file.directory:
    - makedirs: True
    - user: glen

rbenv-git:
  git.latest:
    - name: https://github.com/sstephenson/rbenv.git
    - rev: master
    - target: /home/glen/.rbenv
    - force: True
    - user: glen
    - require:
      - pkg: rbenv_deps
      - file: /home/glen/.rbenv

https://github.com/sstephenson/ruby-build.git:
  git.latest:
    - rev: master
    - target: /home/glen/.rbenv/plugins
    - force: True
    - user: glen
    - require:
      - git: rbenv-git
      - file: /home/glen/.rbenv

/home/glen/.rbenv/plugins/install.sh:
  cmd.run:
  - require:
    - git: https://github.com/sstephenson/ruby-build.git

/home/glen/.bashrc:
  file.append:
    - user: glen
    - text:
      - export PATH="$HOME/.rbenv/bin:$PATH"
      - eval "$(rbenv init -)"
    - require:
      - git: https://github.com/sstephenson/rbenv.git

/home/glen/.rbenv/bin/rbenv install 2.1.0:
  cmd.run:
    - user: glen
    - require:
      - git: https://github.com/sstephenson/ruby-build.git

/home/glen/.rbenv/bin/rbenv rehash:
  cmd.run:
    - user: glen
    - require:
      - cmd: /home/glen/.rbenv/bin/rbenv install 2.1.0

/home/glen/.rbenv/bin/rbenv global 2.1.0:
  cmd.run:
    - user: glen
    - require:
      - cmd: /home/glen/.rbenv/bin/rbenv rehash
