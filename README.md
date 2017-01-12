# Automatic-Security-Update

Automatically update the security settings on ubunut server.

Create a systemd service that will run every Sunday at 06:00 UTC.  The service will perform updates, and upgrades, 
of installed security related packages on a ubuntu server.  Doing this in a development environment is encouraged.  CPU 
expensive updates may be required if service privileges are not properly set.

#1: Create the script to be executed - sec-update.sh
<p>This has issues!  If you run this without proper permissions, it will not complete.  If you run again, after a previous failure, it will not complete and a package reset must be performed.  Because of this, an email service is needed to alert the system administrator, as well as fine tuning of the systemd service file.  Use the following command: chmod +x sec-update.sh (This allows the script to execute)</p>

#2: Create the systemd service - sec-update.service
<p>Copy this into /etc/systemd/system/.  NOTE: replace $PATH_TO_SCRIPT with a full path to your script.  Use man systemd.service to further refine this file as needed.  e.g. Run the service as user 'jim'</p>

#3: Create the systemd timer - sec-update.timer
<p>Copy this into /etc/systemd/system/.  OnCalendar sets the service to execute every Sun at 06:00 UTC.</p>

#4: Enable the service
<p>sudo systemctl start sec-update.timer
sudo systemctl enable sec-update.timer</p>

#5: More stuff...
<p>Check the status of the service:
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
'</p>
