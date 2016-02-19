%define pkg_version %(node -e "console.log(require('./package.json').st2_version);")

%define version %(echo "${PKG_VERSION:-%{pkg_version}}")
%define release %(echo "${PKG_RELEASE:-1}")

Name:           st2hubot
Version:        %{version}
Release:        %{release}
Summary:        St2Hubot - StackStorm Hubot

License:        Apache
URL:            https://github.com/stackstorm/docker-hubot
Source0:        st2hubot

Prefix:         /opt/stackstorm/hubot

%define _builddir %(pwd)
%define _rpmdir %(pwd)/..
%define _build_name_fmt %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm


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
  install -D -p -m0644 %{_builddir}/rpm/st2hubot.service %{buildroot}%{_unitdir}/st2hubot.service
%else
  install -D -p -m0755 %{_builddir}/rpm/st2hubot.init %{buildroot}%{_sysconfdir}/rc.d/init.d/st2hubot
%endif

%clean
  rm -rf %{buildroot}

%files
  /*
%if 0%{?use_systemd}
  %{_unitdir}/st2hubot.service
%else
  %{_sysconfdir}/rc.d/init.d/st2hubot
%endif
