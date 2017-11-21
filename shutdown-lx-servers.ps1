# test for sshSessions Module.
try {
  Import-Module SSHSessions
  Write-Host "Module exists"
} catch {
  Write-Host "Module SSHSessions does not exist"
  Write-Host "Install by running Install-Module -Name SSHSessions"}

# Build array of servers/devices.
$username = "pi"
$password = Get-Content 'D:\Documents\admin-secret.txt' | ConvertTo-SecureString
$RemoteHosts = "swarm-01","swarm-02","swarm-03"

# Now create new session to each device.
foreach($Host in $RemoteHosts) {
  New-SshSession -ComputerName $Host -Username $username -Password $password
}
