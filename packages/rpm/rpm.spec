%define _version            %(git describe --tags | tr - .)
%define _topdir             %{getenv:BUILDDIR}
%global falcon_user    swift

Name:   falcon
Version:  %{_version}
Release:  1%{?dist}
Summary:  Falcon is an reimplementation of OpenStack Swift Object Server in Golang

License: Apache License v2
URL: https://github.com/iqiyi/falcon
Source0:  %{name}-%{version}.tar.gz
Source10: falcon-object.service

Requires(post):    systemd
Requires(preun):   systemd
Requires(postun):  systemd

%description
%{summary}


%prep
%setup -q

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/local/bin
cp falcon %{buildroot}/usr/local/bin
install -p -D -m 0644 %{SOURCE10} \
    %{buildroot}%{_unitdir}/falcon-object.service

%pre
getent group %{falcon_user} > /dev/null || groupadd -r %{falcon_user}
getent passwd %{falcon_user} > /dev/null || \
    useradd -r -M -g %{falcon_user} -s /sbin/nologin -c "openstack swift user" %{falcon_user}
exit 0

%post
%systemd_post falcon-object.service

%preun
%systemd_preun falcon-object.service

%postun
%systemd_postun falcon-object.service

%files
/usr/local/bin/falcon
%{_unitdir}/falcon-object.service
