Import-Module (Resolve-Path lib\MetaFunctions.psm1) -force
Import-Module (Resolve-Path lib\WebtoonRetrievalFunctions.psm1) -force

ReadMetaData
$fone = (PrintMetaData)[0]
RetrieveChapterImgs -Url "$($fone.site)$($fone.urltitle)$($fone.suffix)" -Chap 330 -Name $fone.name
#WriteMetaData