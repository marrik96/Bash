#//////////////////////////////////////////////////////////////////////////////////////////////////
#
#   shutdown-lx-servers.ps1 - Ricardo Londono
#
#   This POSH script SSH to each device in $RemoteHosts array and issue shutdown command.
#
#	Last Modified: 11/22/2017
#   
#//////////////////////////////////////////////////////////////////////////////////////////////////
# Setup creds
$username = "pi"
$password = Get-Content 'D:\Documents\admin-secret.txt' | ConvertTo-SecureString
$creds = New-Object System.Management.Automation.PSCredential $username, $password
# test for sshSessions Module.
try {
  Import-Module SSHSessions
  Write-Host "Module exists"
} catch {
  Write-Host "Module SSHSessions does not exist"
  Write-Host "Install by running Install-Module -Name SSHSessions"}

# Build array of servers/devices.
$RemoteHosts = "swarm-01","swarm-02","swarm-03"

# Now create new session to each device.
foreach($RemoteHost in $RemoteHosts) {
  New-SshSession -ComputerName $RemoteHost -Credential $creds
  sleep -Seconds 2
  Invoke-SshCommand -ComputerName $RemoteHost -Command 'sudo shutdown'
}
