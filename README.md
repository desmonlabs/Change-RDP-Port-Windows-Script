<h1>Change RDP Port in Windows with Powershell</h1>

Enhance the Security of your Remote Desktop Connections
This Powershell script allows you to easily change the default RDP (Remote Desktop) port in Windows. By default, RDP listens on port 3389, but changing the port number helps reduce brute force login attempts and unauthorized access to your Windows systems.

<h2>Why Change the RDP Port?</h2>
The default RDP port 3389 is a major target for:

<ul>
  <li>Brute force attacks: Hackers use automated tools to guess weak passwords</li>
  <li>Vulnerability scanners: Tools scan for systems with open RDP ports to identify targets</li>
  <li>Opportunistic hackers: Many manual hacking attempts target default RDP ports hoping for an easy win</li>
  <li>Changing the well-known default port number helps mitigate these risks and makes your system a less attractive target.</li>
  <li>Using a non-standard port, especially above 5000, offers good security benefits for little effort</li>
</ul>

<h2>How to Use the Script</h2>

<ul>
  <li>1. Download the ChangeRDPPort.ps1 script</li>
  <li>2. Open Powershell and run: . .\ChangeRDPPort.ps1</li>
  <li>3. Enter a new port number when prompted. Choose a number between 49152 and 65535.</li>
  <li>4. The script will validate the new port number is available and in the valid range.</li>
  <li>5. It will then update the necessary registry keys and firewall rules to start using the new RDP port.</li>
</ul>

Please note that you may have to reboot the system for the changes to fully take effect.
Make sure to connect Remote Desktop clients to the new port number going forward.

<h2>Technical Details</h2>

This script performs the following actions to change the RDP port:

<ul>
  <li>Checks the specified port is in the valid range (1-65535) and not already in use</li>
  <li>Updates the "PortNumber" value under HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp</li>
  <li>Creates a new Windows Firewall rule named "Remote Desktop (TCP-In)" to allow inbound TCP traffic on the new port</li>
  <li>Removes the existing RDP firewall rule for port 3389 using netsh</li>
  <li>Restarts the Remote Desktop Services process to apply the changes</li>
</ul>
