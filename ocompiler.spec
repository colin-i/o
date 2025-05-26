
%global _debugsource_template %{nil}

Name: ocompiler
Version: 5+232
Release: 3
License: GPLv3
Summary: O Language compiler
Url: https://github.com/colin-i/o
Source0: %{name}-%{version}.tar.gz
Source1: https://github.com/colin-i/o/releases/download/2-%{version}/obj.txt.gz

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
linkerflags="-O3 -g" make  # -g here is important if wanting to have debuginfo package

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
* Mon May 26 2025 Costin Botescu <costin.botescu@gmail.com> 5+232-3
- 

* Mon May 26 2025 Costin Botescu <costin.botescu@gmail.com> 5+232-2
- other distros (costin.botescu@gmail.com)
- "sync" (costin.b.84@gmail.com)
- "sync" (costin.b.84@gmail.com)
- ldprefer for fast default (costin.botescu@gmail.com)
- windows otoc (costin.botescu@gmail.com)
- win ounused (costin.botescu@gmail.com)
- win getline (costin.botescu@gmail.com)
- win stderr (costin.botescu@gmail.com)
- in process of supporting windows at ounused, stderr/out/get_current_dir_name
  lin wraps (costin.botescu@gmail.com)
- argc/argv entry ounused(i386),otoc(x86_64) (costin.botescu@gmail.com)
- win ounused, 5 functions to go (costin.botescu@gmail.com)
- "sync" (costin.b.84@gmail.com)

* Sat May 17 2025 Costin Botescu <costin.botescu@gmail.com> 5+232-1
- added Xfile_yesignore and Xfile_declsign_pointer_var/fn
  (costin.b.84@gmail.com)
- added Xfile_yesignore and Xfile_declsign_pointer_var/fn
  (costin.botescu@gmail.com)
- "tests" (costin.b.84@gmail.com)
- long long option (costin.botescu@gmail.com)
- set this way to make room for long long at first otoc argument?
  (costin.botescu@gmail.com)
- "sync" (costin.b.84@gmail.com)
- dev depending on binaries (costin.botescu@gmail.com)
- "tests" (costin.b.84@gmail.com)
- excluding files from deb (costin.botescu@gmail.com)

* Sun May 11 2025 Costin Botescu <costin.botescu@gmail.com> 5+229-2
- debuginfo

* Sun May 11 2025 Costin Botescu <costin.botescu@gmail.com> 5+229-1
- fix glibc 

* Sun May 11 2025 Costin Botescu <costin.botescu@gmail.com> 5+229-0
- new package built with tito

