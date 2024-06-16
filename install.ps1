function Install-Utilities {
    param (
        [string[]]$category,
        [string[]]$names,
        [switch]$update
    )

    foreach ($cat in $category) {
        if ($apps.ContainsKey($cat)) {
            $appList = $apps[$cat]
            foreach ($app in $appList) {
                if ($names -contains $app.name) {
                    foreach ($installer in $app.installers) {
                        switch ($installer.type) {
                            'brew' { Install-Brew -packages $installer.packages -options $installer.options }
                            'choco' { Install-Choco -packages $installer.packages }
                            'scoop' { Install-Scoop -packages $installer.packages }
                            'winget' { Install-Winget -packages $installer.packages }
                            'apt' { Install-Apt -packages $installer.packages }
                        }
                    }
                }
            }
        } else {
            Write-Host "Category $cat does not exist in configuration."
        }
    }
}
