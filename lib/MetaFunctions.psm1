[string]$SettingsFile = "metadata.json"

function ReadMetaData
{
    If (Test-Path $SettingsFile){
        Write-Host "Reading from Metadata file."
        $script:SettingsObject = Get-Content -Path $SettingsFile -Raw | ConvertFrom-Json
        return
    }
    Else{
        Write-Host "No Metadata file found so creating one now."
        New-Item -ItemType file -Path $SettingsFile
        return
    }
}

function WriteMetaData
{
    If (-Not (Test-Path $SettingsFile)){
        Write-Host "No Metadata file found so creating one now."
        New-Item -ItemType file -Path $SettingsFile
    }
    Write-Host "Writing to Metadata file."
    $output = $SettingsObject | ConvertTo-Json
    If ($SettingsObject.Count -eq 1){
        $output = $output -replace "`n","`n`t"
        $output="[`n`t$output`n]"
    }
    $output | Set-Content -Path $SettingsFile
}

function PrintMetaData
{
    $SettingsObject
}

function ChangeChapterNumber
{
    param(
        [string]$Url,
        [int]$ChapNum
    )
    $found = $false
    foreach($_ in $script:SettingsObject){
        If ($_.urltitle -eq $Url){
            Write-Host "Changing last read chapter of $($_.name) from $($_.lastReadChapter) to $ChapNum."
            $_.lastReadChapter = $ChapNum
            $found = $true
            break
        }
    }
    If ($found){return}
    Write-Host "Either $urltitle does not exist, or some other error occured in changing the chapter."
}