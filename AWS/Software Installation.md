
** Software Installation**

*Note:  This includes installing tomcat, the tomcat package will work but this step is included for completeness.*

1. Assure that software on the system is current and patched. 

    1. sudo  yum update

2. Install 

    2. sudo yum install apr

    3. sudo yum install apr-util

    4. sudo yum install apr-devel

    5. sudo yum install apr-util-devel

    6. sudo yum install gcc

    7. sudo yum install ant

    8. sudo yum install git 

    9. sudo yum install openssl-devel

3. Create a location for the source code and go into directory

    10. mkdir Software

    11. cd Software

4. Download source code

    12. wget [http://mirror.olnevhost.net/pub/apache//httpd/httpd-2.2.27.tar.gz](http://mirror.olnevhost.net/pub/apache//httpd/httpd-2.2.27.tar.gz)

    13. wget [http://mirror.olnevhost.net/pub/apache/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.tar.gz](http://mirror.olnevhost.net/pub/apache/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.tar.gz)

5. Prepare the code

    14. tar –xzvf httpd-2.2.27.tar.gz 

    15. tar –xzvf apache-tomcat-7.0.54.tar.gz

6. Prepare installation

    16. sudo mkdir /apps

    17. Tomcat

        1. sudo mv apache-tomcat-7.0.54 /apps

        2. cd /apps

        3. ln –s  apache-tomcat-7.0.54 tomcat

        4. Now you can run TOMCAT alone to test

            1. cd /apps/tomcat/bin/

            2. ./startup.sh

            3. ./shutdown.sh

    18. Apache

        5. cd /home/ec2-user/Software/httpd-2.2.27

        6. configuration

         
   4. 
./configure--prefix=/apps/apache-2.2.27\
--enable-cgi\
--enable-rewrite=shared\
--enable-so\
--enable-ssl\
--with-ssl\
--enable-setenv\
--enable-proxy\
--enable-proxy-html\
--enable-proxy-balancer\
--enable-cache\
--enable-headers\
--enable-speling=shared\
--enable-unique-id

        7. make

        8. sudo make install

        9. sudo ln -s apache-2.2.27 apache

        10. cd /apps/apache

        11. sudo useradd webuser

        12. cd /apps/apache/conf

        13. sudo vi http.conf

            18. change user and group to webuser (lines 68 and 69)

        14. now  you can run APACHE alone to test

            19. cd /apps/apache/bin

            20. sudo ./apachectl start

            21. sudo ./apachectl stop

7. Existdb

    19. cd /apps

    20. git clone https://github.com/exist-db/exist exist

    21. cd exist

    22. sudo ./build.sh

        15. existdb can now be run from this directory on port 8080

            22. ./bin/startup.sh

            23. CTRL C to stop

    23. sudo ./build.sh dist-war

    24. cd dist

    25. sudo cp exist-2.1-rev.war /apps/tomcat/webapps/exist.war cp exist-2.1-rev.war /apps/tomcat/webapps/exist.war

8. Now all of the pieces work, let’s put them together

    26. First be sure exist, tomcat, and apache is not running

        16. netstat –na |grep 80

    27. cd /apps/apache/conf

    28. sudo vi httpd.conf

##Tomcat Proxy

ProxyRequests     off

ProxyPreserveHost on

ProxyPass /exist/ http://localhost:8080/exist/

ProxyPassReverse /exist/ http://localhost:8080/exist/

ProxyPass /db/ http://localhost:8080/db/

ProxyPassReverse /db/ [http://localhost:8080/db/](http://localhost:8080/db/)

9. That’s it you have everything done,  you just need to start the system

    29. cd /apps/apache/bin

    30. sudo ./apachectl start

    31. cd /apps/tomcat/bin

    32. ./startup.sh

        17. If you want to watch the system start you can view the logs at /apps/tomcat/logs/catalina.out

		

	

