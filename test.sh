#!/bin/bash

cd # required 
# /home/doohee
export BASEDIR=`pwd`	
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
cd
# cat <<EOF | gpg2 --batch --no-tty --gen-key
#%echo Generating a standard key
#Key-Type: default
#Key-Length: 2048
#Subkey-Type: default
#Subkey-Length: 2048
#Name-Real: dewey
#Name-Email: doohee323@gmail.com
#Expire-Date: 10y
#Passphrase: Pswd!123
#%commit
#%echo done
# EOF
# gpg --list-keys
# gpg --delete-secret-key one
# gpg --list-keys one
# gpg --list-secret-keys
# gpg --delete-secret-key 1024D/C646A999
# gpg --delete-key C646A999

#doohee@doohee-desktop:$BASEDIR/rpmbuild/SPECS$ gpg --list-keys
#pub   2048R/D330A940 2015-12-09 [expires: 2025-12-06]
#uid                  dewey <doohee323@gmail.com>
#sub   2048R/7E9B1216 2015-12-09 [expires: 2025-12-06]

# 1-3) make .rpmmacros file
# F1035488: comes from passphrase
#echo $'%_topdir /home/doohee/rpmbuild \n'\
#$'%_builddir %{_topdir}/BUILD \n'\
#$'%_rpmbuild %{_topdir}/RPMS \n'\
#$'%_sourcedir %{_topdir}/SOURCES \n'\
#$'%_specdir %{_topdir}/SPECS \n'\
#$'%_srcrpmbuild %{_topdir}/SRPMS \n'\
#$'%_tmppath %{_topdir}/tmp \n'\
#$'%_gpg_name "D330A940"'> .rpmmacros

mkdir -p $BASEDIR/rpmbuild/BUILD
mkdir -p $BASEDIR/rpmbuild/RPMS
mkdir -p $BASEDIR/rpmbuild/SOURCES
mkdir -p $BASEDIR/rpmbuild/SPECS
mkdir -p $BASEDIR/rpmbuild/SRPMS

# 2) make rpm
# 2-1) make source
cd $BASEDIR/rpmbuild/SOURCES
mkdir -p test-1.0.0
cat <<EOF > test-1.0.0/test
#!/bin/bash
echo world
EOF
sh test-1.0.0/test

tar czvf test-1.0.0.tar.gz test-1.0.0/

# 2-2) deploy a source and a spec file

2-3) build rpm
cp $BASEDIR/rpmbuild/test.spec $BASEDIR/rpmbuild/SPECS/
cd $BASEDIR/rpmbuild/SPECS/
rpmbuild --sign -ba test.spec
Pswd!123

ll $BASEDIR/rpmbuild/RPMS/x86_64

* sudo alien -i $BASEDIR/rpmbuild/RPMS/x86_64/*.rpm
  
# 3) install and test
sudo rpm -ivh  $BASEDIR/rpmbuild/RPMS/x86_64/test-1.0.0-1.x86_64.rpm --nodeps

rpm -qa test
rpm -qf /usr/local/bin/test

# uninstall
sudo rpm -e test-1.0.0-1.x86_64 --nodeps




