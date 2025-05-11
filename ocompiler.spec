%global srcname ocompiler

%global _debugsource_template %{nil}

Name: ocompiler
Version: 5+229
Release: 2
License: GPLv3
Summary: O Language compiler
Url: https://github.com/colin-i/o
Source0: %{name}-%{version}.tar.gz
Source1: https://github.com/colin-i/o/releases/download/1-%{version}/obj.txt.gz

BuildRequires: make glibc(x86-32) gcc

Requires: glibc(x86-32)

%description
O Language compiler and dev files.

%package devel
Summary: O Language dev files
BuildArch: noarch
Requires: %{name} = %{version}-%{release}

%description devel
This package contains necessary header files for O Language development.

#-- PREP, BUILD & INSTALL -----------------------------------------------------#
%prep
%autosetup
gzip -dc %{S:1} > src/obj.txt
touch include_dev

%build
linkerflags="-O3 -g" make

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
* Sun May 11 2025 Costin Botescu <costin.botescu@gmail.com> 5+229-2
- debuginfo

* Sun May 11 2025 Costin Botescu <costin.botescu@gmail.com> 5+229-1
- fix glibc 

* Sun May 11 2025 Costin Botescu <costin.botescu@gmail.com> 5+229-0
- new package built with tito

