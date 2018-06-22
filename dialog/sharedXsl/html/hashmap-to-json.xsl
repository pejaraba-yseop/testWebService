<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:yt="http://www.yseop.com/text/2"
xmlns:y="http://www.yseop.com/engine/3">
<!-- Stylesheet that transforms an HashMap YML object into a JSON object -->

<!-- Turn an HashMap YML object into a JSON object -->
<xsl:template match="y:instance[@yclass='HashMap']">
	<xsl:text>{&#xa;</xsl:text>
	<xsl:apply-templates select="values" mode="hashmap" />
	<xsl:text>}&#xa;</xsl:text>
	<xsl:if test="not(position()=last())">
		<xsl:text>, </xsl:text>
	</xsl:if>
</xsl:template>


<xsl:template match="values[@yclass='HashMap']" mode="hashmap">
	<xsl:text>{&#xa;</xsl:text>
	<xsl:apply-templates select="values" mode="hashmap" />
	<xsl:text>}&#xa;</xsl:text>
	<xsl:if test="not(position()=last())">
		<xsl:text>, </xsl:text>
	</xsl:if>
</xsl:template>


<xsl:template match="values[key]" mode="hashmap">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="key"/>
	<xsl:text>": </xsl:text>
	<xsl:apply-templates select="val" mode="hashmap"/>
	
	<xsl:if test="not(position()=last())">
		<xsl:text>, </xsl:text>
	</xsl:if>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>	

<xsl:template match="values[@yclass='List']|values[@yclass='Array']" mode="hashmap">
		<xsl:text>[</xsl:text>
		<xsl:apply-templates select="values" mode="hashmap"/>

		<xsl:text>]</xsl:text>

		<xsl:if test="not(position()=last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
</xsl:template>


<xsl:template match="values" mode="hashmap">
	<xsl:choose>
		<!--xsl:when test="number(.) = ."-->
		<xsl:when test="number(.) = .">
			<xsl:value-of select="."/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>"</xsl:text>
			<xsl:value-of select="."/>
			<xsl:text>"</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	
	
	<xsl:if test="not(position()=last())">
		<xsl:text>, </xsl:text>
	</xsl:if>
</xsl:template>


<xsl:template match="val[@yclass='List']|val[@yclass='Array']" mode="hashmap">
	<xsl:text>[</xsl:text>
	<xsl:apply-templates select="values" mode="hashmap"/>
	<xsl:text>]</xsl:text>
	<xsl:if test="not(position()=last())">
		<xsl:text>, </xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="val[@yclass='HashMap']" mode="hashmap">
	<xsl:text>{</xsl:text>
		<xsl:apply-templates select="values" mode="hashmap" />
	<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="val" mode="hashmap">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>"</xsl:text>
</xsl:template>





</xsl:stylesheet>