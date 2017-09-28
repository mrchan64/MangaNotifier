$settings = Get-Content -Path "webtoonsettings.json" -Raw | ConvertFrom-Json
$webtoonChap = "http://www.webtoons.com/en/action/"
$settings | %{
    $urltitle = $_.urltitle
    $suffix = $_.suffix
    "$webtoonChap$urltitle$suffix"
}