$webData = (Invoke-WebRequest -URI "http://www.webtoons.com/en/action/the-god-of-high-school/ep-326/viewer?title_no=66&episode_no=329").content

$images = Select-String "<img src=""http://webtoons.static.naver.net/image/bg_transparency.png"" width=""[0-9,.]{0,}"" height=""[0-9,.]{0,}"" alt=""image"" class=""_images"" data-url=""http://webtoon.phinf.naver.net.{0,}"" rel=""nofollow"" ondragstart=""return false;"" onselectstart=""return false;"" oncontextmenu=""return false;"">" -input $webData -AllMatches

$count = $images.Matches.count
Write-Host "Found $count images for this chapter"

$folderName = "tempPics"
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
    $imgData = (Invoke-WebRequest -URI $imgurl -Headers @{"Referer"="http://www.webtoons.com/"}).content
    $tempImgPath = Join-Path $tempdir "the-god-of-high-school_pg_$counter.jpg"
    Write-Progress -Activity "Downloaded " -Status "$counter of $total images"
    $counter = $counter+1
    [io.file]::WriteAllBytes($tempImgPath, $imgData)
}