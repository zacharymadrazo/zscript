#!/bin/bash
#Execute all Commands within the Ubuntu Checklist given by Cyberpatriot
#Functions
#firewall
#(Guest_Account)=/etc/lightdm/lightdm.conf
# (PAM_COMPASS)=/etc/pam.d/common-password (PAM_COMAUTH)=/etc/pam.d/common-auth
# (Password_History)/etc/login.defs
# (Secure_Ports) netstat --listen (view specific Ports)=netstat -a | grep port-number
#audit linux system
#remove unsecure hacking tools such as "nmap" and "cracking"

startscript(){
	
	firewall
	susec
	Guest_Account
	PAM_COMPASS
	PAM.COMAUTH
	Password_History
	Secure_Ports
	audit
	sshconfig
	fixupdate
	sshkeygen
	mysql
	postfix
	sharedmem
	
}
cont(){
echo "would you like me to secure the next parameter? YES or NO"
read OPTION
 case "$OPTION" in 
 YES|Y)
 echo "Continuing to secure"
 return 0
 ;;
 NO|N)
 return 
;;
*) 
	 echo "I did not understand."
 esac
 
}

firewall(){ 
	sudo apt-get ufw
	ufw enable
	ufw deny 23
    ufw deny 2049
    ufw deny 515
    ufw deny 111
	ufw allow ssh
	ufw allow http
    lsof  -i -n -P
    netstat -tulpn
	
	
	cont	
}

susec(){
	dpkg-statoverride --update --add root sudo 4750 /bin/su

	cont
}

Guest_Account(){
	
	echo "allow-guests=false" >>/etc/lightdm/lightdm.conf

	cont
}
PAM_COMPASS(){
	nano /etc/pam.d/common-password 
									#Add “remember=5” to the end of the line that has “pam_unix.so” in it
	
									# Add “minlen=8” to the end of the line that has “pam_unix.so” in it
									
									#Add “ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1” to the end of the line with “pam_cracklib.so” in it.**
							        #ucredit = upper case, lcredit=lower case, dcredit = number and ocredit = symbol
                                    #**cracklib may need to be installed before enforcing password complexity
	
	
cont
}
PAM_COMAUTH(){ 
	nano /etc/pam.d/common-auth #Add this line to the end of the file:
								#auth required pam_tally2.so ADD: deny=5 onerr=fail unlock_time=1800
	cont
}
Password_History(){

	nano /etc/login.defs 
	#• PASS_MAX_DAYS 90
#‐ Minimum Password Duration:
#• PASS_MIN_DAYS 10
#‐ Days Before Expiration to Warn Users
#to Change Their Password:
#• PASS_WARN_AGE 7
#• Save the file and close it

cont
}
Secure_Ports(){
	netstat --listen
	iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 23 -j DROP         #Block Telnet
    iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 2049 -j DROP       #Block NFS
    iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 2049 -j DROP       #Block NFS
    iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 6000:6009 -j DROP  #Block X-Windows
    iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 7100 -j DROP       #Block X-Windows font server
    iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 515 -j DROP        #Block printer port
    iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 515 -j DROP        #Block printer port
    iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 111 -j DROP        #Block Sun rpc/NFS
    iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 111 -j DROP        #Block Sun rpc/NFS
    iptables -A INPUT -p all -s localhost  -i eth0 -j DROP            #Deny outside packets from internet which claim to be from your loopback interface.
	cont
	
}

audit(){
#install auditing system 
    apt-get install auditd
    
	auditclt -e 1

	cont
}
sshconfig(){
nano /etc/ssh/sshd_config
 cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
 chmod a-w /etc/ssh/sshd_config.original
system ctl restart sshd.service

cont
}
fixupdate(){
	sudo apt-get update
	sudo apt-get install -f
	sudo rm -rf /var/lib/apt/lits*
	sudo apt-get update

	cont
}
	

sshkeygen(){
ssh-keygen -t rsa
#see manconfig

cont
}
mysql(){
 apt-get install mysql-server
 sudo mysql_secure_installation
 cont
 
}

postfix(){
if [ ! -f postfix ]; then

sudo apt-get install postfix

else

echo "Posfix does not exist"

fi
cont
}
sharedmem(){
	cat /etc/fstab
	cont
}


	


antivirus(){

#configure any configured packages already on system
sudo apt-get --configure -a
#Make a variable name ANTIVIRUS and give it a list of the programs "clamav clamtk rkhunter chkrootkit"

ANTIVIRUS="clamav clamtk rkhunter chkrootkit"
#loop the ANTIVIRUS list
#After declaring variable name; execute ...
for A in $ANTIVIRUS; do
#install variable
sudo apt-get install "$ANTIVIRUS"
#update clamav
done
freshclam

cont



}

antivirus


startscript && antivirus