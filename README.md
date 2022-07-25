# Have you lost the weather icon on your RedHat/CentOS 6 gnome desktop around 2016?

That is because the weather service moved away from weather.noaa.gov to aviationweather.gov.

RedHat considers version 6 as outgoing so they won't fix libgweather:

https://bugzilla.redhat.com/show_bug.cgi?id=1372738
https://bugzilla.redhat.com/show_bug.cgi?id=1385478

Here is a quick workaround for the problem to get back the weather station on your desktop.
No need to rebuild libgweather, just run this small web gateway.

# Installation:
````
1.
  yum install httpd
2.
  echo Timeout 600 > /etc/httpd/conf.d/Timeout.conf
3.
  chkconfig httpd on
  service httpd start
4.
   setsebool -P httpd_can_network_connect on
5.
 Append in the /etc/hosts file to the localhost entries weather.noaa.gov
  you should got something like:
    127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 weather.noaa.gov
    ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6 weather.noaa.gov
6.
 Copy this file into /var/www/cgi-bin/mgetmetar.pl
    and
 chmod  +x  /var/www/cgi-bin/mgetmetar.pl
 restorecon /var/www/cgi-bin/mgetmetar.pl
````
