Name:bash
Version:4.3.30
Release:    1%{?dist}
Summary:Bourne Again Shell

Group:System Environment/Shells
License:GPL
URL:    gnu.org
Source0:ftp://ftp.gnu.org/gnu/bash/bash-%{version}.tar.gz
BuildRoot:  %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

BuildRequires:texinfo bison
Requires:mktemp

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


%build
if ! autoconf; then
    # Yuck. We're using autoconf 2.1x.
        ln -s /bin/true autoconf
            export PATH=.:$PATH
            fi
%configure
make CPPFLAGS=`getconf LFS_CFLAGS`
make -C doc
make check


%install
rm -rf $RPM_BUILD_ROOT
if [ -e autoconf ]; then
    # Yuck. We're using autoconf 2.1x.
        export PATH=.:$PATH
        fi
%makeinstall

mkdir -p $RPM_BUILD_ROOT/etc

# make manpages for bash builtins as per suggestion in DOC/README
pushd doc
sed -e '
/^\.SH NAME/, /\\- bash built-in commands, see \\fBbash\\fR(1)$/{
/^\.SH NAME/d
s/^bash, //
s/\\- bash built-in commands, see \\fBbash\\fR(1)$//
s/,//g
b
}
d
' builtins.1 > man.pages
for i in echo pwd test kill; do
  perl -pi -e "s,$i,,g" man.pages
    perl -pi -e "s,  , ,g" man.pages
    done

    install -c -m 644 builtins.1 ${RPM_BUILD_ROOT}%{_mandir}/man1/builtins.1

    for i in `cat man.pages` ; do
      echo .so man1/builtins.1 > ${RPM_BUILD_ROOT}%{_mandir}/man1/$i.1
        chmod 0644 ${RPM_BUILD_ROOT}%{_mandir}/man1/$i.1
        done
        popd

        # Link bash man page to sh so that man sh works.
        ln -s bash.1 ${RPM_BUILD_ROOT}%{_mandir}/man1/sh.1

        # Not for printf (conflict with coreutils)
        rm -f $RPM_BUILD_ROOT/%{_mandir}/man1/printf.1

        pushd $RPM_BUILD_ROOT
        mkdir ./bin
        mv ./usr/bin/bash ./bin
        ln -sf bash ./bin/bash2
        ln -sf bash ./bin/sh
        gzip -9nf .%{_infodir}/bash.info
        rm -f .%{_infodir}/dir
        popd
        mkdir -p $RPM_BUILD_ROOT/etc/skel
        install -c -m644 $RPM_SOURCE_DIR/dot-bashrc $RPM_BUILD_ROOT/etc/skel/.bashrc
        install -c -m644 $RPM_SOURCE_DIR/dot-bash_profile \
            $RPM_BUILD_ROOT/etc/skel/.bash_profile
            install -c -m644 $RPM_SOURCE_DIR/dot-bash_logout \
                $RPM_BUILD_ROOT/etc/skel/.bash_logout
                find $RPM_BUILD_ROOT/ $RPM_BUILD_DIR/ -name "bashbug*" \
                    -exec rm -vf {} \;


%clean
rm -rf $RPM_BUILD_ROOT
%post

HASBASH2=""
HASBASH=""
HASSH=""

if [ ! -f /etc/shells ]; then
    > /etc/shells
    fi

    (while read line ; do
        if [ $line = /bin/bash ]; then
                HASBASH=1
                    elif [ $line = /bin/sh ]; then
                            HASSH=1
                                elif [ $line = /bin/bash2 ]; then
                                        HASBASH2=1
                                            fi
                                             done

                                              if [ -z "$HASBASH2" ]; then
                                                echo "/bin/bash2" >> /etc/shells
                                                 fi
                                                  if [ -z "$HASBASH" ]; then
                                                    echo "/bin/bash" >> /etc/shells
                                                     fi
                                                      if [ -z "$HASSH" ]; then
                                                        echo "/bin/sh" >> /etc/shells
                                                        fi) < /etc/shells

                                                        %postun
                                                        if [ "$1" = 0 ]; then
                                                            grep -v '^/bin/bash2$' < /etc/shells | \
                                                                grep -v '^/bin/bash$' | \
                                                                    grep -v '^/bin/sh$' > /etc/shells.new
                                                                        mv /etc/shells.new /etc/shells
                                                                        fi


%files
%defattr(-,root,root,-)
%doc
%doc CHANGES COMPAT NEWS NOTES POSIX
%doc doc/FAQ doc/INTRO doc/article.ms
%doc -P examples/bashdb/ examples/functions/ examples/misc/
%doc -P examples/scripts.noah/ examples/scripts.v2/ examples/scripts/
%doc -P examples/startup-files/ examples/complete/ examples/loadables/
%config(noreplace) /etc/skel/.b*
/bin/sh
/bin/bash
/bin/bash2
%{_infodir}/bash.info*
%{_mandir}/*/*
%{_mandir}/*/..1*
%doc doc/*.ps doc/*.0 doc/*.html doc/article.txt



%changelog                                                  
                                                          