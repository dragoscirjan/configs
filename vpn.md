# VPN Tools

- [VPN Tools](#vpn-tools)
  - [Default](#default)
  - [OpenVPN](#openvpn)

## Default

```bash
# Darwin
brew install openvpn

# Linux
sudo apt update && sudo apt install -y openvpn network-manager-openvpn network-manager-openvpn-gnome

# Windows
choco install openvpn -y

scoop bucket add main && scoop install main/openvpn

@("OpenVPNTechnologies.OpenVPN") | ForEach-Object { winget install -e --id $_ }
```

## OpenVPN

```bash
# Darwin
brew install openvpn
# Linux
sudo apt install -y openvpn network-manager-openvpn network-manager-openvpn-gnome
# Windows
choco install openvpn -y
scoop install openvpn
winget install -e --id OpenVPNTechnologies.OpenVPN
```
