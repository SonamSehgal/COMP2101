 get-ciminstance win32_networkadapterconfiguration | ? IPEnabled -eq $True | ft Index, Description, IPAddress, IPSubnet,DNSDomain, DNSHostName, DNSServerSearchOrder -Autosize 
