#Change RDP Port in Windows with Powershell

Enhance the Security of your Remote Desktop Connections
This Powershell script allows you to easily change the default RDP (Remote Desktop) port in Windows. By default, RDP listens on port 3389, but changing the port number helps reduce brute force login attempts and unauthorized access to your Windows systems.

##Why Change the RDP Port?
The default RDP port 3389 is a major target for:

- Brute force attacks: Hackers use automated tools to guess weak passwords
- Vulnerability scanners: Tools scan for systems with open RDP ports to identify targets
- Opportunistic hackers: Many manual hacking attempts target default RDP ports hoping for an easy win
- Changing the well-known default port number helps mitigate these risks and makes your system a less attractive target. Using a non-standard port, especially above 5000, offers good security benefits for little effort.

##How to Use the Script

1. Download the ChangeRDPPort.ps1 script
2. Open Powershell and run: . .\ChangeRDPPort.ps1
3. Enter a new port number when prompted. Choose a number between 49152 and 65535.
4. The script will validate the new port number is available and in the valid range.
5. It will then update the necessary registry keys and firewall rules to start using the new RDP port.

Please note that you may have to reboot the system for the changes to fully take effect.
Make sure to connect Remote Desktop clients to the new port number going forward.

##Technical Details

This script performs the following actions to change the RDP port:

Checks the specified port is in the valid range (1-65535) and not already in use
Updates the "PortNumber" value under HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
Creates a new Windows Firewall rule named "Remote Desktop (TCP-In)" to allow inbound TCP traffic on the new port
Removes the existing RDP firewall rule for port 3389 using netsh
Restarts the Remote Desktop Services process to apply the changes
