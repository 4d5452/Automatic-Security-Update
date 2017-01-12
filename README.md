# Automatic-Security-Update

Automatically update the security settings on ubunut server.

Create a systemd service that will run every Sunday at 06:00 UTC.  The service will perform updates, and upgrades, 
of installed security related packages on a ubuntu server.  Doing this in a development environment is encouraged.  CPU 
expensive updates may be required if service privileges are not properly set.

1: Create the script to be executed
2: Create the systemd service
3: Create the systemd timer
4: Enable the service
5: More stuff...

1: sec-update.sh
'
#!/bin/bash

#print the current date
date

#update using aptitude
aptitude update

#get the current os: e.g. xenial and append -security
TARGET_RELEASE=$(lsb_release -cs)-security

#run the upgrade
aptitude safe-upgrade -o Aptitude:Delete-Unused=false --assume-yes --target-release $TARGET_RELEASE
'
This has issues!  If you run this without proper permissions, it will not complete.  If you run again, after a previous failure, it will not complete and a package reset must be performed.  Because of this, an email service is needed to alert the system administrator, as well as fine tuning of the systemd service file.  Use the following command: chmod +x sec-update.sh (This allows the script to execute)

2: sec-update.service
'
[Unit]
Description=Automatic update of security updates

[Service]
Type=simple
Nice=19
IOSchedulingClass=2
IOSchedulingPriority=7
ExecStart=$PATH_TO_SCRIPT
'
Copy this into /etc/systemd/system/.  NOTE: replace $PATH_TO_SCRIPT with a full path to your script.  Use man systemd.service to further refine this file as needed.  e.g. Run the service as user 'jim'

3: sec-update.timer
'
[Unit]
Description=Automatic update of security updates

[Timer]
OnCalendar=Sun *-*-* 06:00:00 UTC

[Install]
WantedBy=timers.target
'
Copy this into /etc/systemd/system/.  OnCalendar sets the service to execute every Sun at 06:00 UTC.

4: enable the service
'
sudo systemctl start sec-update.timer
sudo systemctl enable sec-update.timer
'

5: more stuff...

Check the status of the service:
'
sudo systemctl status sec-update.timer
'

List all timers:
'
systemctl list-timers -all
'

Reload services
'
sudo systemctl daemon-reload
'

Check output of service
'
sudo journalctl -u sec-update --since="yesterday"
'
