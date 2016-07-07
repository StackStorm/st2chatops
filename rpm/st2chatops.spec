%define pkg_version %(node -e "console.log(require('./package.json').st2_version);")

%define version %(echo "${PKG_VERSION:-%{pkg_version}}")
%define release %(echo "${PKG_RELEASE:-1}")

Name:           st2chatops
Version:        %{version}
Release:        %{release}
Requires:       nodejs >= 4.0.0
Summary:        St2Chatops - StackStorm Chatops

License:        Apache
URL:            https://github.com/stackstorm/st2chatops
Source0:        st2chatops

Prefix:         /opt/stackstorm/chatops

%define _builddir %(pwd)
%define _rpmdir %(pwd)/..
%define _build_name_fmt %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm

%if 0%{?_unitdir:1}
  %define use_systemd 1
%endif


%description
  <insert long description, indented with spaces>

%prep
  rm -rf %{buildroot}
  mkdir -p %{buildroot}

%build
  make

%install
  %make_install
%if 0%{?use_systemd}
  install -D -p -m0644 %{_builddir}/rpm/st2chatops.service %{buildroot}%{_unitdir}/st2chatops.service
%else
  install -D -p -m0755 %{_builddir}/rpm/st2chatops.init %{buildroot}%{_sysconfdir}/rc.d/init.d/st2chatops
%endif

%clean
  rm -rf %{buildroot}

%files
  /opt/stackstorm/chatops/*
%if 0%{?use_systemd}
  %{_unitdir}/st2chatops.service
%else
  %{_sysconfdir}/rc.d/init.d/st2chatops
%endif
