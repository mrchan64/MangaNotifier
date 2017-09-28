Import-Module (Resolve-Path lib\MetaFunctions.psm1) -force

ReadMetaData
$fone = (PrintMetaData)[0]
ChangeChapterNumber -urltitle $fone.urltitle -chapternumber 137
WriteMetaData