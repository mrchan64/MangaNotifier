[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon 

$objNotifyIcon.Icon = "C:\Users\wildc\Documents\Git Repos\MangaNotifier\favicon-1.ico"
$objNotifyIcon.BalloonTipIcon = "C:\Users\wildc\Documents\Git Repos\MangaNotifier\favicon-1.ico" 
$objNotifyIcon.BalloonTipText = "A file needed to complete the operation could not be found." 
$objNotifyIcon.BalloonTipTitle = "File Not Found"
 
$objNotifyIcon.Visible = $False 
$objNotifyIcon.ShowBalloonTip(10000)

Get-ChildItem C:\Windows

$objNotifyIcon.BalloonTipText = "The script has finished running." 
$objNotifyIcon.BalloonTipTitle = "Files retrieved." 

$objNotifyIcon.Visible = $True 
$objNotifyIcon.ShowBalloonTip(10000)
[void][System.Threading.Thread]::Sleep(10000)

$objNotifyIcon.Dispose()