%define pkg_version %(node -e "console.log(require('./package.json').st2_version);")

%define version %(echo "${PKG_VERSION:-%{pkg_version}}")
%define release %(echo "${PKG_RELEASE:-1}")

%define svc_user st2

Name:           st2chatops
Version:        %{version}
Release:        %{release}
Requires:       nodejs >= 20.0

Summary:        St2Chatops - StackStorm ChatOps

License:        Apache 2.0
URL:            https://github.com/stackstorm/st2chatops
Source0:        st2chatops

Prefix:         /opt/stackstorm/chatops

%define _builddir %(pwd)
%define _rpmdir %(pwd)/..
%define _build_name_fmt %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm

%if 0%{?rhel} >= 8
# brp_mangle_shebangs refrains from looking for shebangs which cause ruby, perl and coffee to be dependencies,
# which are not needed because they are provided by node
%undefine __brp_mangle_shebangs
Requires: /bin/bash
Requires: /bin/sh
Requires: /usr/bin/env
%endif
%if 0%{?rhel} >= 9
BuildRequires: systemd-rpm-macros
%endif

# Cat debian/package.dirs, set buildroot prefix and create directories.
%define debian_dirs cat debian/%{name}.dirs | grep -v '^\\s*#' | sed 's~^~%{buildroot}/~' | \
          while read dir_path; do \
            mkdir -p "${dir_path}" \
          done \
%{nil}


%description
  Package providing StackStorm ChatOps functionality: bundled, tested and ready to use Hubot
  with hubot-stackstorm plugin and additional chat adapters

%prep
  rm -rf %{buildroot}
  mkdir -p %{buildroot}

%build
  make

%install
  %debian_dirs
  %make_install
  install -D -p -m0644 %{_builddir}/rpm/st2chatops.service %{buildroot}%{_unitdir}/st2chatops.service

%clean
  rm -rf %{buildroot}

%pre
  (id %{svc_user} 1>/dev/null 2>&1) || adduser --no-create-home --system --user-group %{svc_user}

%files
  /opt/stackstorm/chatops/*
  %attr(755, st2, root) %{_localstatedir}/log/st2
  %config(noreplace) %{_sysconfdir}/logrotate.d/st2chatops
  %{_unitdir}/st2chatops.service

%config(noreplace) /opt/stackstorm/chatops/st2chatops.env
%config(noreplace) /opt/stackstorm/chatops/external-scripts.json
