$apps = @{
  browsers = @(
    @{
      name = 'arc'
      installers = @(
          @{ type = 'brew'; packages = @('arc'); options = @('--cask') }
      )
    },
    @{
      name = 'brave'
      installers = @(
        @{ type = 'choco'; packages = @('brave') },
        @{ type = 'scoop'; packages = @('extras/brave') },
        @{ type = 'winget'; packages = @('Brave.Brave') }
      )
    },
    @{
      name = 'chrome'
      installers = @(
        @{ type = 'choco'; packages = @('googlechrome') },
        @{ type = 'scoop'; packages = @('extras/googlechrome') },
        @{ type = 'winget'; packages = @('Google.Chrome') }
      )
    },
    @{
      name = 'chromium'
      installers = @(
        @{ type = 'choco'; packages = @('chromium') },
        @{ type = 'scoop'; packages = @('extras/chromium') },
        @{ type = 'winget'; packages = @('Hibbiki.Chromium') }
      )
    },
    @{
      name = 'edge'
      installers = @(
        @{ type = 'choco'; packages = @('microsoft-edge') },
        # @{ type = 'scoop'; packages = @('extras/googlechrome') },
        @{ type = 'winget'; packages = @('Microsoft.Edge') }
      )
    },
    @{
      name = 'firefox'
      installers = @(
        @{ type = 'choco'; packages = @('firefox') },
        @{ type = 'scoop'; packages = @('extras/firefox') },
        @{ type = 'winget'; packages = @('Mozilla.Firefox') }
      )
    },
    @{
      name = 'opera'
      installers = @(
        @{ type = 'choco'; packages = @('opera') },
        @{ type = 'scoop'; packages = @('extras/opera') },
        @{ type = 'winget'; packages = @('Opera.Opera') }
      )
    },
    @{
      name = 'vivaldi'
      installers = @(
        @{ type = 'choco'; packages = @('vivaldi') },
        @{ type = 'scoop'; packages = @('extras/vivaldi') },
        @{ type = 'winget'; packages = @('VivaldiTechnologies.Vivaldi') }
      )
    },
  )
    # Add other categories (fonts, gits, ides, ims, langs, office, rest, ssl) here
}
