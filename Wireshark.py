import pyshark
 
# Open saved trace file 
cap = pyshark.FileCapture('/tmp/mycapture.cap')
 
# Sniff from interface
capture = pyshark.LiveCapture(interface='eth0')
capture.sniff(timeout=10)
<LiveCapture (5 packets)>
