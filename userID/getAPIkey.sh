# Use this script to obtain an API key for your firewall.
clear
curl -k -X GET 'https://192.168.50.1/api/?type=keygen&user=admin&password=admin' > keyfile.txt
echo ""
echo "Copy out the portion of the output below between <key> and </key>."
echo "That portion is the firewall API key."
echo ""
echo "Paste the key into any script which uses the API to send/receive data to the firewall."
echo ""
cat keyfile.txt
echo ""
echo ""
echo ""
