Name:bash
Version:4.3.30
Release:    1%{?dist}
Summary:Bourne Again Shell

Group:System Environment/Shells
License:GPL
URL:    gnu.org
Source0:ftp://ftp.gnu.org/gnu/bash/bash-%{version}.tar.gz
BuildRoot:  %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

#BuildRequires:texinfo bison
#Requires:mktemp

%description
The GNU Bourne Again shell (Bash) is a shell or command language
interpreter that is compatible with the Bourne shell (sh). Bash
incorporates useful features from the Korn shell (ksh) and the C shell
(csh). Most sh scripts can be run by bash without modification. This
package (bash) contains bash version %{version}, which improves POSIX
compliance over previous versions. However, many old shell scripts
will depend upon the behavior of bash 1.14, which is included in the
bash1 package. Bash is the default shell for Red Hat Linux.  It is
popular and powerful, and you'll probably end up using it.
 
%prep
%setup -q
 
#%build

#configure
#make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
cp -Rf %{_tmppath}/bash-%{version}/* $RPM_BUILD_ROOT
 
#%clean
rm -rf $RPM_BUILD_ROOT
rm -rf %{_tmppath}/bash-%{version}
 
%files
%defattr(-,root,root,-)
/bin
/share

#%doc

%attr(0755,root,root)/bin/bash
%attr(0755,root,root)/bin/bashbug
 
%changelog
