<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:y="http://www.yseop.com/engine/3"
 xmlns:yt="http://www.yseop.com/text/2">
<xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
<!-- common Yseop -->
<xsl:include href="sharedXsl/html/commun-yseop-yt.xsl"/>
<xsl:include href="sharedXsl/html/commun-yseop-log.xsl"/>
<xsl:include href="sharedXsl/html/commun-helpers.xsl"/>
<!-- GENERAL -->
<xsl:template match="/">
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>

<!-- 	<div class="sliderArea">
		<div class="theSliders">
			<xsl:apply-templates select="//y:txt[@id='input']" />
		</div>
	</div> -->

	<div class="reportArea">
		<div class="regenBtn">
			<input id="generateReport" type="button" class="btn" onclick="generateResult()" value="Rewrite Me!" />
		</div>

		<div class="theReport" contenteditable="false">
			<xsl:apply-templates select="//y:txt[@id='finalDocument']" />
		</div>
	</div>		
	</head>

</xsl:template>
</xsl:stylesheet>