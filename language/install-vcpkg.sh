#!/usr/bin/env bash

prefix="$HOME/.local/bin"
mkdir -p "$prefix"

repo="$prefix/../share/vcpkg"
if [ -d "$repo" ]; then
  git -C "$repo" pull --ff-only
else
  git clone --depth 1 https://github.com/microsoft/vcpkg "$repo"
fi

cd "$repo"

if [ ! -f "./vcpkg" ]; then
  ./bootstrap-vcpkg.sh
fi

./vcpkg integrate install

# Create shim script
shim="$prefix/vcpkg"
cat > "$shim" << 'EOF'
#!/usr/bin/env bash
exec "$HOME/.local/share/vcpkg/vcpkg" "$@"
EOF
chmod +x "$shim"
