
%global _debugsource_template %{nil}

Name: ocompiler
Version: 5+242
Release: 0
License: GPLv3
Summary: O Language compiler
Url: https://github.com/colin-i/o
Source0: %{name}-%{version}.tar.gz
Source1: https://github.com/colin-i/o/releases/download/%{name}-%{version}-0/obj.txt.gz

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
* Sun Oct 19 2025 Costin Botescu <costin.botescu@gmail.com> 5+242-0
- s/u ext also at declare (costin.botescu@gmail.com)
- ss/sss asm acting at operations (costin.botescu@gmail.com)
- win fix (costin.botescu@gmail.com)

* Sun Oct 19 2025 Costin Botescu <costin.botescu@gmail.com> 5+241-0
- volatile, import varargs, fixes and more (costin.b.84@gmail.com)
- local test (costin.botescu@gmail.com)
- fix otoc \\ (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- varargs at import (costin.botescu@gmail.com)
- Xfile_import_name and some fixes (costin.botescu@gmail.com)
- step fix (costin.botescu@gmail.com)
- fix (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- otoc: move imports at top declarations (costin.botescu@gmail.com)
- unimplemented more verbose (costin.botescu@gmail.com)
- very rare case (costin.botescu@gmail.com)
- to not compare unallocated space (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- volatile marks ocompiler <-> otoc (costin.botescu@gmail.com)
- callret for otoc proto (costin.botescu@gmail.com)

* Sun Oct 19 2025 Costin Botescu <costin.botescu@gmail.com> 5+240-0
- local test (costin.botescu@gmail.com)
- fix otoc \\ (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- varargs at import (costin.botescu@gmail.com)
- Xfile_import_name and some fixes (costin.botescu@gmail.com)
- step fix (costin.botescu@gmail.com)
- fix (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- otoc: move imports at top declarations (costin.botescu@gmail.com)
- unimplemented more verbose (costin.botescu@gmail.com)
- very rare case (costin.botescu@gmail.com)
- to not compare unallocated space (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- volatile marks ocompiler <-> otoc (costin.botescu@gmail.com)
- callret for otoc proto (costin.botescu@gmail.com)

* Tue Oct 07 2025 Costin Botescu <costin.botescu@gmail.com> 5+239-0
- unused (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- Xfile_numbers_type_tpref (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- override N struct . ?preference at numbers (costin.botescu@gmail.com)
- in include files, allow write is false (costin.botescu@gmail.com)
- extra !=0 (costin.botescu@gmail.com)
- otoc base/leave (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- readme (costin.botescu@gmail.com)

* Wed Jul 23 2025 Costin Botescu <costin.botescu@gmail.com> 5+238-0
- rtest (costin.botescu@gmail.com)
- was extra returning at erEnd (costin.botescu@gmail.com)
- %%x values to compare (costin.botescu@gmail.com)
- at ostrip trying to find the problem (costin.botescu@gmail.com)
- info again, was not saved (costin.botescu@gmail.com)
- callret part 2 (costin.botescu@gmail.com)
- callret part 1 (costin.botescu@gmail.com)

* Sun Jul 20 2025 Costin Botescu <costin.botescu@gmail.com> 5+237-0
- callret is good also at ocomp (costin.botescu@gmail.com)
- LocalFree (costin.botescu@gmail.com)
- exec one process (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- ${file} (costin.botescu@gmail.com)
- was not implemented (costin.botescu@gmail.com)

* Fri Jul 04 2025 Costin Botescu <costin.botescu@gmail.com> 5+236-0
- ostrip usage (costin.botescu@gmail.com)
- test ready for fuse3 (costin.botescu@gmail.com)
- acall syntax (costin.botescu@gmail.com)
- test.yml (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- suse ocompiler ln fix (costin.botescu@gmail.com)
- not required to bump version only for fedora patch (costin.botescu@gmail.com)

* Mon Jun 30 2025 Costin Botescu <costin.botescu@gmail.com> 5+235-1
- spec fix (costin.botescu@gmail.com)
- arh at last (costin.botescu@gmail.com)
- pkg composite (costin.botescu@gmail.com)

* Mon Jun 30 2025 Costin Botescu <costin.botescu@gmail.com> 5+235-0
- test (costin.botescu@gmail.com)

* Mon Jun 30 2025 Costin Botescu <costin.botescu@gmail.com> 5+234-0
- fix otoc i386 (costin.botescu@gmail.com)

* Mon Jun 30 2025 Costin Botescu <costin.botescu@gmail.com> 5+233-0
- "up" (costin.botescu@gmail.com)
- still having more cases wrong at etchelper, another solution with abs paths
  (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- was -dev required there? (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- detailed log (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- Makefile corrected for suse (costin.botescu@gmail.com)
- "up" (costin.botescu@gmail.com)
- readme and pub (costin.botescu@gmail.com)
- fixes for opensuse build (costin.botescu@gmail.com)

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

