Name:           test
Version:        1.0.0 
Release:        1%{?dist}
Summary:        A test package
 
Group:          Testing
License:        GPL
URL:            http://topzone.com
Source0:        %{name}-%{version}.tar.gz
BuildRoot:      %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
 
#BuildRequires:  /bin/rm, /bin/mkdir, /bin/cp
Requires:       /bin/bash
 
%description
 A test package
 
%prep
%setup -q
 
%build
 
#configure
#make %{?_smp_mflags}
 
%install
rm -rf $RPM_BUILD_ROOT
#make install DESTDIR=$RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/local/bin
cp test $RPM_BUILD_ROOT/usr/local/bin
 
%clean
rm -rf $RPM_BUILD_ROOT
 
%files
%defattr(-,root,root,-)
#%doc
 
%attr(0755,root,root)/usr/local/bin/test
 
%changelog
* Tue Dec 8 2015 dewey <doohee323@gmail.com> - 1.0.0
- Initial RPM
