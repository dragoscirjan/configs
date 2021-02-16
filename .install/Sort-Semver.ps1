New-Module -Name SemverSort -ScriptBlock {
  Function Sort-Semver
  {
    param (
      $theArray = @(),
      [switch]$Descending
    )

    # False when swaps occur
    [bool] $sorted = $false
    $counter = 0
    for ($pass = 1; ($pass -lt $theArray.Count) -and -not $sorted; $pass++)
    {
        # Assume the array is sorted
        $sorted = $true
        for ($index = 0; $index -lt ($theArray.Count - $pass); $index++)
        {
            $counter++
            $nextIndex = $index + 1
            if ((Sort-Semver-Compare $theArray[$index] $theArray[$nextIndex]) -gt 0)
            {
                # Swap items
                $temp = $theArray[$index]
                $theArray[$index] = $theArray[$nextIndex]
                $theArray[$nextIndex] = $temp
                $sorted = $false
            }
        }
    }
    if ($Descending -eq $True) {
      [Array]::Reverse($theArray)
    }
    return $theArray
  }

  Function Sort-Semver-Compare ($adir, $bdir)
  {
    $a = $adir
    $b = $bdir

    $semverregex = "^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$"
    $dummy = $a -match $semverregex
    [int]$amajor = $Matches[1]
    [int]$aminor = $Matches[2]
    [int]$apatch = $Matches[3]
    $aprerelease = $Matches[4]
    #Write-Host $a $amajor + $aminor + $apatch + $aprerelease ($aprerelease -eq $null)

    $dummy = $b -match $semverregex
    [int]$bmajor = $Matches[1]
    [int]$bminor = $Matches[2]
    [int]$bpatch = $Matches[3]
    $bprerelease = $Matches[4]
    #Write-Host $b $bmajor + $bminor + $bpatch + $bprerelease ($bprerelease -eq $null)

    if( $amajor -lt $bmajor)
    {
      return -1
    } elseif ($amajor -gt $bmajor) {
      return 1
    } else {
      if ( $aminor -lt $bminor ) {
        return -1
      } elseif ( $aminor -gt $bminor ) {
        return 1
      } else {

          if ( $apatch -lt $bpatch ) {
            return -1
          } elseif ( $apatch -gt $bpatch ) {
            return 1
          } else {

              if( ($aprerelease -eq $null) -and ($bprerelease -eq $null)) {
                return 0
              }
              if($aprerelease -eq $null) {
                return 1
              }
              if($bprerelease -eq $null) {
                return -1
              }

              $aparts = $aprerelease.Split('.')
              $bparts = $bprerelease.Split('.')
              $minparts = [math]::min($aparts.Count, $bparts.Count)

              for($i = 0; $i -lt $minparts; $i++) {
                $ap = $aparts[$i]
                $bp = $bparts[$i]
                if(($ap -match "^[0-9]+$") -and ($bp -match "^[0-9]+$")) {
                  $ap = [int]$ap
                  $bp = [int]$bp
                }

                if ( $ap -lt $bp ) {
                  return -1
                } elseif ( $ap -gt $bp ) {
                  return 1
                }
              }
              if($aparts.Count -lt $bparts.Count) {
                return -1
              } elseif($aparts.Count -gt $bparts.Count) {
                return 1
              } else {
                return 0
              }

          }
      }
    }
  }

  Export-ModuleMember -Function Sort-Semver

}
