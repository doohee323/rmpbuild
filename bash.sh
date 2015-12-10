#!/bin/bash

VERSION=4.3.30
cd
BASEDIR=`pwd`
echo '$BASEDIR:'$BASEDIR

# 1) requirements
# 1-1) install rpm
# sudo apt-get install rpm -y
# sudo apt-get install rng-tools -y
# sudo apt-get install gnupg-agent -y
# sudo apt-get install gnupg2 -y
# sudo rngd -r /dev/urandom
# gpg-agent --use-standard-socket --daemon
# * sudo apt-get install alien -y

# 1-2) make a passphrase for gpg
#cat <<EOF | gpg2 --batch --no-tty --gen-key
#%echo Generating a standard key
#Key-Type: default
#Key-Length: 2048
#Subkey-Type: default
#Subkey-Length: 2048
#Name-Real: dewey
#Name-Email: doohee323@gmail.com
#Expire-Date: 10y
#Passphrase: vhxlspt!qotnl
#%commit
#%echo done
#EOF

# 1-3) make .rpmmacros file
# D330A940: comes from passphrase
echo $'%_topdir '$BASEDIR$'/rpmbuild \n'\
$'%_builddir %{_topdir}/BUILD \n'\
$'%_rpmbuild %{_topdir}/RPMS \n'\
$'%_sourcedir %{_topdir}/SOURCES \n'\
$'%_specdir %{_topdir}/SPECS \n'\
$'%_srcrpmbuild %{_topdir}/SRPMS \n'\
$'%_tmppath %{_topdir}/tmp \n'\
$'%_gpg_name "D330A940"'> .rpmmacros

#mkdir -p $BASEDIR/rpmbuild/BUILD
#mkdir -p $BASEDIR/rpmbuild/RPMS
#mkdir -p $BASEDIR/rpmbuild/SOURCES
#mkdir -p $BASEDIR/rpmbuild/SPECS
#mkdir -p $BASEDIR/rpmbuild/SRPMS
#mkdir -p $BASEDIR/rpmbuild/tmp

cd $BASEDIR/rpmbuild/SOURCES
wget ftp://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz

tar xvfz $BASEDIR/rpmbuild/SOURCES/bash-4.3.30.tar.gz -C $BASEDIR/rpmbuild/BUILD
rm -Rf $BASEDIR/rpmbuild/tmp/bash-4.3.30
mkdir -p $BASEDIR/rpmbuild/tmp/bash-4.3.30
cd $BASEDIR/rpmbuild/BUILD/bash-4.3.30
./configure --prefix=$BASEDIR/rpmbuild/tmp/bash-4.3.30
make install

# 2) make rpm
# 2-1) deploy a source and a spec file
# cp $BASEDIR/workspace/etc/rpmbuild/bash.spec $BASEDIR/rpmbuild/SPECS/

# 2-3) build rpm
cd $BASEDIR/rpmbuild/SPECS/
rpmbuild bash.spec

rpmbuild --sign -ba bash.spec
# vhxlspt!qotnl

ls -al $BASEDIR/rpmbuild/RPMS/x86_64

#* sudo alien -i $BASEDIR/rpmbuild/RPMS/x86_64/*.rpm
  
# 3) install and bash
#sudo rpm -ivh --replacefiles $BASEDIR/rpmbuild/RPMS/x86_64/bash-4.3.30-1.x86_64.rpm --nodeps

#rpm -qa bash
#rpm -qf /usr/local/bin/bash

# uninstall
# sudo rpm -e bash-4.3.30-1.x86_64 --nodeps




