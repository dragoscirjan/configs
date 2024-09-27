# SSL Tools

- [SSL Tools](#ssl-tools)
  - [Default](#default)
  - [OpenSSL](#openssl)
  - [LibreSSL](#libressl)

## Default

```bash
# Darwin
brew install openssl

# Linux
sudo apt update && sudo apt install -y openssl

# Windows
choco install openssl -y

scoop install main/openssl

winget install -e --id ShiningLight.OpenSSL
```

## OpenSSL

```bash
# Darwin
brew install openssl
# Linux
sudo apt install -y openssl
# Windows
choco install openssl -y
scoop install openssl
winget install -e --id ShiningLight.OpenSSL
```

## LibreSSL

```bash
# Darwin
brew install libressl
# Linux
# LibreSSL is not typically available on most Linux distributions by default, but can be compiled from source.
wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.4.3.tar.gz -O libressl.tar.gz
tar -xf libressl.tar.gz
cd libressl-3.4.3
./configure
make
sudo make install
cd .. && rm -rf libressl-3.4.3 libressl.tar.gz
# Windows
choco install libressl -y
```
