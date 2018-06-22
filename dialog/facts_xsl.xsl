<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:y="http://www.yseop.com/engine/3">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/root">
    <y:result xmlns:y="http://www.yseop.com/engine/3">
      <xsl:apply-templates />
    </y:result>
  </xsl:template>

  <xsl:template match="*/facts/item">
    <facts>
      <xsl:attribute name="yclass"><xsl:value-of select="yclass" /></xsl:attribute>
      <xsl:apply-templates />
    </facts>
  </xsl:template>

  <xsl:template match="*/factMeasures/item">
    <factMeasures>
      <xsl:attribute name="yclass"><xsl:value-of select="yclass" /></xsl:attribute>
      <xsl:apply-templates />
    </factMeasures>
  </xsl:template>

  <xsl:template match="*/members/item">
    <xsl:value-of select="node()"/>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="facts|facts">
        <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="factMeasures|factMeasures">
        <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="*/yclass"></xsl:template>

    
</xsl:stylesheet>