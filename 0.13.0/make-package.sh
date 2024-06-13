#/bin/bash
set -e

ARCH='amd64'
ARCH_DL='x86_64'
VERSION='0.13.0'
DEB_FILE_NAME='zls_'$VERSION'_'$ARCH

echo 'Downloading ZLS from GitHub...'
wget --continue --quiet --show-progress \
    'https://github.com/zigtools/zls/releases/download/'$VERSION'/zls-'$ARCH_DL'-linux.tar.xz'

echo 'Extracting tar...'
mkdir 'zls-'$ARCH_DL'-linux'
cd 'zls-'$ARCH_DL'-linux'
tar xf ../'zls-'$ARCH_DL'-linux.tar.xz'
cd ..

echo 'Staging package...'
rm -rf $DEB_FILE_NAME
mkdir --parents \
    $DEB_FILE_NAME'/DEBIAN' \
    $DEB_FILE_NAME'/usr/local/bin';
cp -l 'zls-'$ARCH_DL'-linux/zls' $DEB_FILE_NAME'/usr/local/bin'
SIZE=$(du --block-size=1024 --summarize $DEB_FILE_NAME'/usr' | grep -Eo '^[0-9]*')

sed 's/ARCH/'$ARCH'/' 'DEBIAN-control' |
    sed 's/SIZE/'$SIZE'/' |
    sed 's/VERSION/'$VERSION'/' > $DEB_FILE_NAME'/DEBIAN/control'

echo 'Building package...'
dpkg-deb --build $DEB_FILE_NAME
echo
echo 'DONE! -- '$DEB_FILE_NAME'.deb'
echo
