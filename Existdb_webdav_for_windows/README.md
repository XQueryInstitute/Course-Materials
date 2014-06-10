Existdb connection using Oxygen < 15.  In version 15 a wizard is available.

Oxygen XML Editor supports eXist database server versions 1.3, 1.4 and 1.5.

1. Go to menu **Preferences** > **Data Sources**.

2. Click the **New** button in the **Data Sources** panel.

3. Enter a unique name for the data source.

4. Select *eXist* from the **Driver type** combo box.

5. Press the **Add** button to add the eXist driver files.

6. The following driver files should be added in the dialog box for setting up the eXist datasource. They are found in the installation directory of the eXist database server. Please make sure you copy the files from the installation of the eXist server where you want to connect from Oxygen.

    * exist.jar

    * lib/core/xmldb.jar

    * lib/core/xmlrpc-client-3.1.x.jar

    * lib/core/xmlrpc-common-3.1.x.jar

    * lib/core/ws-commons-util-1.0.x.jar

7. **Note:** For eXist database server version 1.5 and 2.0, the following driver files must also be added in the dialog box for setting up the datasource:

    * lib/core/slf4j-api-1.x.x.jar

    * lib/core/slf4j-log4j12-1.x.x.jar

8. The version number from the driver file names may be different for your eXist server installation.

9. Click the **OK** button to finish the connection configuration.

10. [http://www.oxygenxml.com/demo/eXist_Database.html](http://www.oxygenxml.com/demo/eXist_Database.html).

WebDav access in Windows

	Windows requires a webdav client for full integration.  Two options are[ netdrive](http://www.netdrive.net/download.html) which is excellent but requires a license.  It does have a free 30 day trial though.  The other option is [carotdav](http://rei.to/carotdav_en.html) which is not as good but is free.

