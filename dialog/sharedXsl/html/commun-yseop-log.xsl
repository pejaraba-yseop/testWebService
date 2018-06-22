<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:yt="http://www.yseop.com/text/2" xmlns:y="http://www.yseop.com/engine/3">
	<xsl:template name="log">
		<a name="log">
			<h1>Runtime log <a href="#top">back</a>
			</h1>
		</a>
		<div id="log">
			<ul>
				<xsl:apply-templates select="//y:logging/y:log"/>
			</ul>
		</div>
	</xsl:template>
	<xsl:template match="y:log">
		<xsl:element name="li">
			<xsl:attribute name="class">
				<xsl:value-of select="@level"/>
			</xsl:attribute>
			<xsl:value-of select="y:message"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
