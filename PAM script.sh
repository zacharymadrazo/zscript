	sed -i '/^pam.unix.so/$a \ minlen=8/'
	sed -i '/^pam.unix.so/$a \ remember=5/'
	sed -i '/^pam_tally2.so/s/$a \ deny=5 onerr=fail unlock_time=1800/' /etc/pam.d/common-auth  #Add this line to the end of the file:
								#auth required pam_tally2.so ADD: deny=5 onerr=fail unlock_time=1800
