<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:y="http://www.yseop.com/engine/3"
 xmlns:yt="http://www.yseop.com/text/2">
<xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
<!-- common Yseop -->
<xsl:include href="html/commun-yseop-yt.xsl"/>
<xsl:include href="html/commun-yseop-log.xsl"/>
<xsl:include href="html/commun-helpers.xsl"/>
<xsl:include href="html/css-loader.xsl"/>
<xsl:include href="html/hashmap-to-json.xsl"/>
<xsl:include href="html/text-trace.xsl"/>
<!-- GENERAL -->
<xsl:template match="/">
<html>
	<head>
		<title>Page title</title>

    <script type="text/javascript">
      <xsl:call-template name="cssLoader" />
      loadCssArrayYseop([
      	// "css/output.css"
      ]);
    </script>
    
	</head>
	<body>
    <xsl:apply-templates select="//y:txt[@id='finalDocument']" />
		<xsl:call-template name="log" />
	</body>
</html>
</xsl:template>

</xsl:stylesheet>
