%global srcname ocompiler

%global debug_package %{nil}
#maybe at oadbg when we will use -g

Name: ocompiler
Version: 5+229
Release: 0
License: GPLv3
Summary: O Language compiler
Url: https://github.com/colin-i/o
Source0: %{name}-%{version}.tar.gz
Source1: https://github.com/colin-i/o/releases/download/1-%{version}/obj.txt.gz

BuildArch: x86_64

BuildRequires: make glibc32
#BuildRequires: glibc.i686
#cannot write this instead of glibc32, will error, and with occasion must also remove glibc32 when installing

#Requires: glibc32
#cannot write this, will be a problem at dnf install, anyway will ask for glibc.i686 knowing about libc.so.6

%description
O Language compiler and dev files.

%package devel
BuildArch: noarch
Summary: O Language dev files
Provides: ocompiler-devel

%description devel
This package contains necessary header files for O Language development.

#-- PREP, BUILD & INSTALL -----------------------------------------------------#
%prep
%autosetup
#cd at ${RPM_BUILD_DIR}/(to know at --test, is almost this $RPM_PACKAGE_RELEASE) is done by autosetup
gzip -dc %{S:1} > src/obj.txt
touch include_dev

%build
make

%install
%make_install

#-- FILES ---------------------------------------------------------------------#
%files
%config(noreplace) %attr(0644, root, root) "%{_sysconfdir}/%{name}.conf"
%attr(0755, root, root) "%{_bindir}/o"
%attr(0755, root, root) "%{_bindir}/ostrip"
%attr(0755, root, root) "%{_bindir}/otoc"
%attr(0755, root, root) "%{_bindir}/ounused"

%files devel
%attr(0644, root, root) "%{_includedir}/%{name}/logs.oh"
%attr(0644, root, root) "%{_includedir}/%{name}/log.oh"
%attr(0644, root, root) "%{_includedir}/%{name}/xfilecore.oh"
%attr(0644, root, root) "%{_includedir}/%{name}/xfile.oh"

#-- CHANGELOG -----------------------------------------------------------------#
%changelog
