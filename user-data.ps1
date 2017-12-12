<powershell>
Set-ExecutionPolicy Remotesigned -Force
Enable-PSRemoting -Force

Install-WindowsFeature -Name Web-Server #-IncludeAllSubFeature

Invoke-WebRequest -Uri "https://shop.r10s.jp/harvestmarket/cabinet/03673253/03771854/6046.jpg" -OutFile "C:\inetpub\wwwroot\stealyourface.jpg"

wget http://169.254.169.254/latest/meta-data/public-ipv4/ -OutFile c:\inetpub\wwwroot\ip.txt
$ip = Get-Content c:\inetpub\wwwroot\ip.txt
$ip = [int](([ipaddress] $ip).GetAddressBytes()[3..3] -join ".") ### I JUST CHANGED THIS TO 3..3, it was 2..2

if ($ip -ge 200) {
    $background_color = "red"
} elseif ($ip -ge 150) {
    $background_color = "orange"
} elseif ($ip -ge 100) {
    $background_color = "yellow"
} elseif ($ip -ge 50) {
    $background_color = "green"
} else {
    $background_color = "blue"
}

Add-Content C:\inetpub\wwwroot\index.txt '
    <html>
        <head>
            <title>Terraform test site</title>
        </head>
        <body style="background-color:#FFFFFF">
            <p style="text-align: center;">
                <img src=".\stealyourface.jpg" alt="BAM!" style="margin-left:auto;margin-right:auto">
            </p>

        </body>
    </html>
    '

(Get-Content C:\inetpub\wwwroot\index.txt).replace('#FFFFFF', "$background_color;") | Set-Content C:\inetpub\wwwroot\index.html

Restart-Service W3SVC
</powershell>
