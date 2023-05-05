$newPort = Read-Host "Enter new RDP port number"  

# Check that the new port number is valid  
if ($newPort -gt 0 -and $newPort -lt 65536) {  

    # Check if the new port is already in use  
    $portInUse = ((netstat -an -p TCP | select-string ":$newPort ") -ne $null)  
    if ($portInUse) {  
        Write-Warning "The port $newPort is already in use. Please choose another port."  
    }  
    else {  

        # Change the RDP registry settings  
        Set-ItemProperty "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" "PortNumber" $newPort  

        # Change Windows Firewall rules  
        New-NetFirewallRule -DisplayName "Remote Desktop (TCP-In)" -LocalPort $newPort -Direction Inbound -Protocol TCP -Action Allow | Out-Null 
        
        # Remove old firewall rule using NetSh Admin CMDlets for back compat  
        & netsh advfirewall firewall delete rule name="Remote Desktop (TCP-In)" protocol=TCP localport=3389  

        # Restart the Terminal Services service  
        Stop-Service TermService -Force  
        Start-Service TermService  

        Write-Host "RDP port changed to $newPort successfully!" 
    }  
}  
else {  
    Write-Warning "The port number $newPort is invalid. Please choose a port number between 1 and 65535."  
}
