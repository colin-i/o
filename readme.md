# O Compiler

## Install
On Ubuntu from PPA.
```sh
sudo add-apt-repository ppa:colin-i/ppa
```
Or the *Manual installation step* from this [link](https://gist.github.com/colin-i/e324e85e0438ed71219673fbcc661da6).\
Then:
```sh
sudo apt-get install ocompiler
```
There is also <i>ocompiler-dev</i>.\
\
\
On Arch Linux, <i>.zst</i> file from [releases](https://github.com/colin-i/edor/releases). Or:
```sh
yay -Sy ocompiler
```
\
On Fedora:
```sh
sudo dnf copr enable colin/project
sudo dnf install ocompiler
```
There is also <i>ocompiler-devel</i>.\
\
\
On openSUSE, run the following as __root__:\
For openSUSE Tumbleweed:
```sh
zypper addrepo https://download.opensuse.org/repositories/home:costin/openSUSE_Tumbleweed/home:costin.repo
```
For openSUSE Leap:
```sh
zypper addrepo https://download.opensuse.org/repositories/home:costin/openSUSE_Leap_16.0/home:costin.repo
```
Replace *16.0* with *15.6* if needed.\
And:
```sh
zypper refresh
zypper install ocompiler
```
An optional step is to install **ocompiler-devel**.\
\
\
On Windows, <i>.windows.zip</i> file from [releases](https://github.com/colin-i/o/releases).\
\
\
On other linux distributions, <i>.AppImage</i> file from [releases](https://github.com/colin-i/o/releases).

## Info
Documentation is at [o.html](https://htmlpreview.github.io/?https://github.com/colin-i/o/blob/master/o.html).\
[Preferences file](https://raw.githubusercontent.com/colin-i/o/master/ocompiler.conf).

## Donations
The *Donations* section is [here](https://gist.github.com/colin-i/e324e85e0438ed71219673fbcc661da6).
