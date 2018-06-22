@echo off

set SAXON_JAR=C:\yseop\libs\saxonhe9-3-0-1j\saxon9he.jar

set BASE_DIR=C:\yseop\projects\cbre-visites\dialog\sharedXsl\ws\tests
set TARGET_FOLDER=file:///C:/yseop/projects/cbre-visites/dialog/sharedXsl/ws/tests


set SRC_XML=testInputFile.xml

set XSL=soap-in.xsl

set JAVA_OPTS=-Xms512m -Xmx1024m

@echo on
echo transformation XSL

java %JAVA_OPTS% -jar %SAXON_JAR% -t -s:%TARGET_FOLDER%/%SRC_XML% -xsl:%BASE_DIR%\%XSL% targetFolder=%TARGET_FOLDER% 


pause

                                                                         