$ipconfig = ipconfig /all

$dhcpServerIPv4 = ($ipconfig | Select-String "DHCP Server" | Select-Object -First 1).ToString().Split(":")[1].Trim()


# 切换手动配置的 Internet 代理状态
$proxySettings = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
if ($proxySettings.ProxyEnable -eq 1) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyEnable" -Value 0
} else {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyEnable" -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyServer" -Value "$dhcpServerIPv4`:10809"
}