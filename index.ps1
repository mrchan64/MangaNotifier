Import-Module (Resolve-Path lib\MetaFunctions.psm1) -force
Import-Module (Resolve-Path lib\WebtoonRetrievalFunctions.psm1) -force

ReadMetaData
$fone = (PrintMetaData)[0]
#$path = (RetrieveChapterImgs -Url "$($fone.site)$($fone.urltitle)$($fone.suffix)" -Chap 130 -Name $fone.name).path
RetrieveChapterUrl -Url "$($fone.site)$($fone.urltitle)$($fone.suffix)" -Chap 130
#WriteMetaData