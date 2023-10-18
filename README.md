# Ping Network Diagnostic Tool

A simple Bash script leveraging the `ping` command to test network connectivity and gather diagnostic information.

## Overview

The `ping` command sends ICMP echo request packets to a specified target, awaiting echo reply packets. Different outcomes are explained below:

### Possible Outcomes:

- **Valid and Reachable Address**:
  - Successful echo replies with statistics about the time taken, TTL, and other details.
  
- **Valid but Unreachable Address**:
  - Indicates the host or network is unreachable, often displaying "Request timeout" messages.
  
- **Invalid Address**:
  - Error messages indicating name resolution failure or address invalidity.

- **Network Issues**:
  - Errors pointing toward unreachable networks or other connectivity issues.
  
- **Firewalls/Security Settings**:
  - Some hosts might not respond due to firewall or security configurations blocking ICMP packets.
  
- **Local Configuration Issues**:
  - Failures related to the user's machine's network configuration or DNS resolution.

## Usage

```bash
./ping_script.sh <target-address>
```

Replace `<target-address>` with any valid IP address or domain name.

## Note

While `ping` is a valuable diagnostic tool, it's essential to remember that it's just one among many. For in-depth diagnostics, consider other network tools and techniques.
