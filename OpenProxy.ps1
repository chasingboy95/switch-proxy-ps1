$ipconfig = ipconfig /all

$dhcpServerIPv4 = ($ipconfig | Select-String "DHCP Server" | Select-Object -First 1).ToString().Split(":")[1].Trim()

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyEnable" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyServer" -Value "$dhcpServerIPv4`:10809"

$git_proxy = "$($dhcpServerIPv4):10809"
git config --global http.proxy $git_proxy
git config --global https.proxy $git_proxy
