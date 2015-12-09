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
cat <<EOF | gpg2 --batch --no-tty --gen-key
%echo Generating a standard key
Key-Type: default
Key-Length: 2048
Subkey-Type: default
Subkey-Length: 2048
Name-Real: dewey
Name-Email: doohee323@gmail.com
Expire-Date: 10y
Passphrase: vhxlspt!qotnl
%commit
%echo done
EOF
# gpg --list-keys
# gpg --list-secret-keys

# 1-3) make .rpmmacros file
# F1035488: comes from passphrase
rm -Rf ~/.rpmmacros
echo $'%_topdir /home/doohee/rpmdir \n'\
$'%_builddir %{_topdir}/BUILD \n'\
$'%_rpmdir %{_topdir}/RPMS \n'\
$'%_sourcedir %{_topdir}/SOURCES \n'\
$'%_specdir %{_topdir}/SPECS \n'\
$'%_srcrpmdir %{_topdir}/SRPMS \n'\
$'%_gpg_name "F1035488"'> .rpmmacros

mkdir -p ~/rpmdir/BUILD
mkdir -p ~/rpmdir/RPMS
mkdir -p ~/rpmdir/SOURCES
mkdir -p ~/rpmdir/SPECS
mkdir -p ~/rpmdir/SRPMS

# 2) make rpm
# 2-1) deploy a source and a spec file
cp ~/workspace/java/rpmbuild/bash.spec ~/rpmdir/SPECS/

# 2-3) build rpm
cd ~/rpmdir/SPECS/
rpmbuild bash.spec
rpmbuild --sign -ba bash.spec
# Pswd!123

ll ~/rpmdir/RPMS/x86_64

#* sudo alien -i ~/rpmdir/RPMS/x86_64/*.rpm
  
# 3) install and bash
sudo rpm -ivh  ~/rpmdir/RPMS/x86_64/bash-4.3.30-1.x86_64.rpm --nodeps

rpm -qa bash
rpm -qf /usr/local/bin/bash

# uninstall
# sudo rpm -e bash-4.3.30-1.x86_64 --nodeps




