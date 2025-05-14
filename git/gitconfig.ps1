
          $timestamp = [Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-UFormat "%s"))

          # Handle .gitconfig file
          if (Test-Path "$env:USERPROFILE\.gitconfig") {
            echo "Backing up existing .gitconfig to $env:USERPROFILE\.gitconfig.bak.$timestamp"
            Move-Item "$env:USERPROFILE\.gitconfig" "$env:USERPROFILE\.gitconfig.bak.$timestamp"
          }
          echo "Linking .gitconfig to $env:USERPROFILE\.gitconfig"
          New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$PWD\.git-config\.gitconfig" -Force

          # Handle .gitattributes file
          if (Test-Path "$env:USERPROFILE\.gitattributes") {
            echo "Backing up existing .gitattributes to $env:USERPROFILE\.gitattributes.bak.$timestamp"
            Move-Item "$env:USERPROFILE\.gitattributes" "$env:USERPROFILE\.gitattributes.bak.$timestamp"
          }
          echo "Linking .gitattributes to $env:USERPROFILE\.gitattributes"
          New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitattributes" -Target "$PWD\.git-config\.gitattributes" -Force
