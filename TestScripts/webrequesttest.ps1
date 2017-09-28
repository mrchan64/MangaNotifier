
$tempfilename = [System.IO.Path]::GetTempFileName()

$tempfilename = "C:\Users\wildc\Documents\Git Repos\MangaNotifier\TestScripts\test.html"

$webData = (Invoke-WebRequest -URI "http://www.webtoons.com/en/fantasy/tower-of-god/list?title_no=95").content

<#$images = Select-String "<img src=""http://webtoons.static.naver.net/image/bg_transparency.png"" width=""[0-9,.]{0,}"" height=""[0-9,.]{0,}"" alt=""image"" class=""_images"" data-url=""http://webtoon.phinf.naver.net.{0,}"" rel=""nofollow"" ondragstart=""return false;"" onselectstart=""return false;"" oncontextmenu=""return false;"">" -input $webData -AllMatches

$images.Matches.count


$temppicname = [System.IO.Path]::GetTempFileName()

$temppicname = "C:\Users\wildc\Documents\Git Repos\MangaNotifier\test.jpg"

$webData = (Invoke-WebRequest -URI "http://webtoon.phinf.naver.net/20170922_263/1506051376380WU2VQ_JPEG/1506051376351663291.jpg?type=q90" -Headers @{"Referer"="http://www.webtoons.com/"}).content#>

[io.file]::WriteAllText($tempfilename,$webData)