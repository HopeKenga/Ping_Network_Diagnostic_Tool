# Function to validate an IP address format
validate_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi

    return $stat
}

# Function to interpret the ping result
interpret_ping_result() {
    local result="$1"
    
    if echo "$result" | grep -q "unknown host"; then
        echo "Invalid Address: Error messages indicating name resolution failure or address invalidity."
        return
    elif echo "$result" | grep -q "Request timeout"; then
        echo "Valid but Unreachable Address: Indicates the host or network is unreachable."
        return
    elif echo "$result" | grep -q "0 packets received" || echo "$result" | grep -q "100.0% packet loss"; then
        echo "Firewalls/Security Settings: The host might not be responding due to firewall or security configurations blocking ICMP packets."
        return
    elif echo "$result" | grep -q "Network is unreachable"; then
        echo "Network Issues: Errors pointing toward unreachable networks or other connectivity issues."
        return
    elif echo "$result" | grep -q "bytes from"; then
        echo "Valid and Reachable Address: Successful echo replies received!"
        return
    else
        echo "Local Configuration Issues: Failures might be related to the user's machine's network configuration or DNS resolution."
    fi
}

echo "Ping Diagnostic Tool"

# Check if an argument is provided
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <ip-address or domain>"
    exit 1
fi

address=$1

# Validate IP address or domain (basic check)
if ! validate_ip "$address" && ! [[ $address =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Error: Invalid IP address or domain format."
    exit 2
fi

echo "Pinging $address..."

# Execute the ping (with a max of 4 packets for brevity)
ping_result=$(ping -c 4 -W 5 $address 2>&1)

# Interpret and display the outcome
interpret_ping_result "$ping_result"
