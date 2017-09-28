[string]$BaseSite = "http://www.webtoons.com/"

function RetrieveChapterUrlOnPage
{
    param(
        [int]$Chap,
        [string]$Url
    )
    $epUrl = (((Invoke-WebRequest -URI $Url).content | Select-String "http://.{0,}episode_no=$Chap" -AllMatches).Matches | Select-Object -First 1).value
    $epUrl
}

function RetrieveChapterUrl
{
    param(
        [int]$Chap,
        [string]$Url
    )
    $counter = 1
    while([string]::IsNullOrEmpty($epUrl) -Or [string]::IsNullOrEmpty($isch1)){
        Write-Host "$Url&page=$counter"
        $epUrl = RetrieveChapterUrlOnPage -Url "$Url&page=$counter" -Chap $Chap
        $isch1 = RetrieveChapterUrlOnPage -Url "$Url&page=$counter" -Chap 1
        $counter = $counter + 1
    }
    $epUrl
}

function RetrieveChapterImgs
{
    param(
        [string]$Name,
        [int]$Chap,
        [string]$Url
    )

    $epUrl = RetrieveChapterUrl -Chap $Chap -Url $Url
    if([string]::IsNullOrEmpty($epUrl)){
        Write-Host "$Name Chapter $Chap does not exist."
        return
    }
    $webData = (Invoke-WebRequest -URI $epUrl).content
    $images = Select-String "<img src=""http://webtoons.static.naver.net/image/bg_transparency.png"" width=""[0-9,.]{0,}"" height=""[0-9,.]{0,}"" alt=""image"" class=""_images"" data-url=""http://webtoon.phinf.naver.net.{0,}"" rel=""nofollow"" ondragstart=""return false;"" onselectstart=""return false;"" oncontextmenu=""return false;"">" -input $webData -AllMatches

    $count = $images.Matches.count
    Write-Host "Found $count images for $Name chapter $Chap"

    $Spaceless = $Name -replace " ","-"
    $folderName = "$Spaceless-Chap-$Chap"
    If (Test-Path $folderName){
        Remove-Item $folderName -Force -Recurse
    }
    $directory = New-Item -ItemType directory -Path $folderName
    $tempdir = Resolve-Path $folderName

    $counter = 1
    $total = $images.Matches.count
    $images.Matches | %{
        $imgurl = (Select-String "data-url=""[^\s]{0,}""" -input $_.value -AllMatches).Matches | Select-Object -First 1
        $imgurl = $imgurl.value.substring(10) -replace """",""
        $imgData = (Invoke-WebRequest -URI $imgurl -Headers @{"Referer"=$script:BaseSite}).content
        $tempImgPath = Join-Path $tempdir "$Spaceless-Chap-$Chap-Pg-$counter.jpg"
        Write-Progress -Activity "Downloaded " -Status "$counter of $total images"
        $counter = $counter+1
        [io.file]::WriteAllBytes($tempImgPath, $imgData)
    }
    return $tempdir
}