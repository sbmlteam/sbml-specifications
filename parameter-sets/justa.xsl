<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1" xmlns:sbml="http://www.sbml.org/sbml/level1" exclude-result-prefixes="sbml">

<xsl:template match="sbml:specie[@name='P0']/@initialAmount">
<xsl:attribute name="initialAmount">5</xsl:attribute>
</xsl:template>

<xsl:template match="sbml:specie[@name='C']/@initialAmount">
<xsl:attribute name="initialAmount">10</xsl:attribute>
</xsl:template>

<xsl:template match="@*|node()" >
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>