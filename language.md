# Programming Languages

- [Programming Languages](#programming-languages)
  - [Default](#default)
  - [Clangd](#clangd)
  - [NVM (Node Version Manager)](#nvm-node-version-manager)
  - [Python](#python)
  - [Zig](#zig)
  - [Rust](#rust)
  - [Go](#go)
  - [Bun](#bun)
  - [Java](#java)
  - [PHP](#php)
  - [Ruby](#ruby)
  - [Swift](#swift)

## Default

```bash
# Darwin
brew install llvm nvm python rustup go bun zig
curl -fsSL https://bun.sh/install | bash

# Linux
sudo apt update && sudo apt install -y clangd python3 python3-pip golang rustc
curl -fsSL https://bun.sh/install | bash
curl https://sh.rustup.rs -sSf | sh
wget https://ziglang.org/download/latest/zig-linux-x86_64-0.10.1.tar.xz -O zig.tar.xz && tar -xf zig.tar.xz && sudo mv zig-linux-x86_64-0.10.1 /opt/zig && rm zig.tar.xz
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Windows
choco install llvm nvm python rust golang zig bun -y

scoop install main/clangd main/nvm main/python main/rust main/go main/zig bun

@("clangd", "CoreyButler.NVMforWindows", "Python.Python.3.11", "Rustlang.Rustup", "GoLang.Go", "Ziglang.Zig", "Bun.Bun") | ForEach-Object { winget install -e --id $_ }
```

## Clangd

```bash
# Darwin
brew install llvm
# Linux
sudo apt install clangd
# Windows
choco install llvm -y
scoop install llvm
winget install -e --id clangd
```

## NVM (Node Version Manager)

```bash
# Darwin
brew install nvm
# Linux
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# Windows
choco install nvm -y
scoop install nvm
winget install -e --id CoreyButler.NVMforWindows
```

## Python

```bash
# Darwin
brew install python
# Linux
sudo apt install -y python3 python3-pip
# Windows
choco install python -y
scoop install python
winget install -e --id Python.Python.3.11
```

## Zig

```bash
# Darwin
brew install zig
# Linux
wget https://ziglang.org/download/latest/zig-linux-x86_64-0.10.1.tar.xz -O zig.tar.xz
tar -xf zig.tar.xz
sudo mv zig-linux-x86_64-0.10.1 /opt/zig
rm zig.tar.xz
echo 'export PATH="$PATH:/opt/zig"' | sudo tee -a /etc/profile.d/zig.sh
source /etc/profile.d/zig.sh
# Windows
choco install zig -y
scoop install zig
winget install -e --id Ziglang.Zig
```

## Rust

```bash
# Darwin
brew install rustup-init
rustup-init -y
# Linux
curl https://sh.rustup.rs -sSf | sh -s -- -y
# Windows
choco install rustup -y
scoop install rustup
winget install -e --id Rustlang.Rustup
```

## Go

```bash
# Darwin
brew install go
# Linux
sudo apt install -y golang
# Windows
choco install golang -y
scoop install go
winget install -e --id GoLang.Go
```

## Bun

```bash
# Darwin
brew install bun
# Linux
curl -fsSL https://bun.sh/install | bash
# Windows
choco install bun -y
scoop install bun
winget install -e --id Bun.Bun
```

## Java

```bash
# Darwin
brew install openjdk
# Linux
sudo apt install -y openjdk-11-jdk
# Windows
choco install openjdk -y
scoop install main/openjdk
winget install -e --id AdoptOpenJDK.OpenJDK
```

## PHP

```bash
# Darwin
brew install php
# Linux
sudo apt install -y php
# Windows
choco install php -y
scoop install php
winget install -e --id PHP.PHP
```

## Ruby

```bash
# Darwin
brew install ruby
# Linux
sudo apt install -y ruby
# Windows
choco install ruby -y
scoop install ruby
winget install -e --id RubyTeam.Ruby.3.1
```

## Swift

```bash
# Darwin
brew install swift
# Linux
wget https://swift.org/builds/swift-5.7.2-release/ubuntu2004/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu20.04.tar.gz -O swift.tar.gz
tar -xf swift.tar.gz
sudo mv swift-5.7.2-RELEASE-ubuntu20.04 /opt/swift
rm swift.tar.gz
echo 'export PATH="$PATH:/opt/swift/usr/bin"' | sudo tee -a /etc/profile.d/swift.sh
source /etc/profile.d/swift.sh
# Windows
# Not available natively for Windows.
winget install -e --id Swift.Toolchain
```
