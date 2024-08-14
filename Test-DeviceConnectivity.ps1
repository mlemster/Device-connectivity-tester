# Define the device and ports
$device = "192.168.1.1"  # Replace with the target device IP address or hostname
$sshPort = 22            # Default SSH port
$telnetPort = 23         # Default Telnet port

# Function to test if a port is open
function Test-Port {
    param (
        [string]$hostname,
        [int]$port
    )
    try {
        $tcpClient = New-Object System.Net.Sockets.TcpClient
        $tcpClient.Connect($hostname, $port)
        $tcpClient.Close()
        return $true
    } catch {
        return $false
    }
}

# Test Ping
Write-Output "Testing Ping to $device..."
$pingResult = Test-Connection -ComputerName $device -Count 1 -Quiet
if ($pingResult) {
    Write-Output "Ping to $device succeeded."
} else {
    Write-Output "Ping to $device failed."
}

# Test SSH
Write-Output "Testing SSH to $device on port $sshPort..."
$sshResult = Test-Port -hostname $device -port $sshPort
if ($sshResult) {
    Write-Output "SSH connection to $device on port $sshPort succeeded."
} else {
    Write-Output "SSH connection to $device on port $sshPort failed."
}

# Test Telnet
Write-Output "Testing Telnet to $device on port $telnetPort..."
$telnetResult = Test-Port -hostname $device -port $telnetPort
if ($telnetResult) {
    Write-Output "Telnet connection to $device on port $telnetPort succeeded."
} else {
    Write-Output "Telnet connection to $device on port $telnetPort failed."
}
