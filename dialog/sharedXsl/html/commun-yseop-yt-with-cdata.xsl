<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:yt="http://www.yseop.com/text/2">
	<!-- Stylesheet identical to commun-yseop-yt but which returns cdata (to be consumed in
c# or java) before being print in html -->
	<!-- 
TABLEAUX
-->
	<xsl:template match="yt:table">
		<div class="titreTableau">
			<xsl:apply-templates select="yt:title"/>
		</div>
		<xsl:element name="table">
			<xsl:if test="@id">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@class">
				<xsl:attribute name="class">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="border">1</xsl:attribute>
			<xsl:apply-templates select="yt:cells"/>
		</xsl:element>
	</xsl:template>
	<!--<xsl:template match="yt:span">
<xsl:element name="span">
<xsl:if test="@id">
<xsl:attribute name="id">
<xsl:value-of select="@id" />
</xsl:attribute>
</xsl:if>

<xsl:if test="@class">
<xsl:attribute name="class">
<xsl:value-of select="@class" />
</xsl:attribute>
</xsl:if>

<xsl:apply-templates />
</xsl:element>
</xsl:template>-->
	<xsl:template match="yt:div">
		<xsl:element name="div">
			<xsl:if test="@id">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@class">
				<xsl:attribute name="class">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:row">
		<tr>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="yt:cell" mode="generationPpt">
		<!--<td>-->
		<xsl:apply-templates mode="generationPpt"/>
		<!--</td>-->
	</xsl:template>
	<!-- 
STRUCTURE DE DOC
-->
	<!--
<xsl:template match="yt:title">
<b>
<xsl:apply-templates />
</b>
</xsl:template>


<xsl:template match="yt:section">
<xsl:element name="div">
<xsl:if test="@id">
<xsl:attribute name="id">
<xsl:value-of select="@id" />
</xsl:attribute>
</xsl:if>

<xsl:if test="@class">
<xsl:attribute name="class">
<xsl:value-of select="@class" />
</xsl:attribute>
</xsl:if>

<xsl:apply-templates />
</xsl:element>
</xsl:template>


<xsl:template match="yt:comment">
<xsl:element name="div">
<xsl:if test="@id">
<xsl:attribute name="id">
<xsl:value-of select="@id" />
</xsl:attribute>
</xsl:if>

<xsl:if test="@class">
<xsl:attribute name="class">
<xsl:value-of select="@class" />
</xsl:attribute>
</xsl:if>

<xsl:apply-templates />
</xsl:element>
</xsl:template>
-->
	<!-- 
TEXTES
-->
	<xsl:template match="yt:italic">
		<xsl:text disable-output-escaping="no">&lt;i&gt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="no">&lt;/i&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="yt:bold">
		<xsl:text disable-output-escaping="no">&lt;b&gt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="no">&lt;/b&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="yt:enum">
		<xsl:text disable-output-escaping="no">&lt;ul&gt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="no">&lt;/ul&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="yt:item">
		<xsl:text disable-output-escaping="no">&lt;li&gt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="no">&lt;/li&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="yt:line">
		<xsl:text disable-output-escaping="no">&lt;br/&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="yt:par">
		<xsl:text disable-output-escaping="no">&lt;p&gt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="no">&lt;/p&gt;</xsl:text>
	</xsl:template>
	<!--<xsl:template match="yt:picture">
<img>
<xsl:attribute name="src">
<xsl:value-of select="@src" />
</xsl:attribute>
<xsl:attribute name="alt">
<xsl:value-of select="@alternate" />
</xsl:attribute>    
<xsl:attribute name="title">
<xsl:value-of select="@alternate" />
</xsl:attribute>    
<xsl:apply-templates />
</img>
</xsl:template>

<xsl:template match="yt:hlink">
<a>
<xsl:attribute name="href">
<xsl:value-of select="yt:src" />
</xsl:attribute>
<xsl:value-of select="yt:title" />
</a>
</xsl:template>
-->
	<xsl:template match="yt:no-break-space">&#160;<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
