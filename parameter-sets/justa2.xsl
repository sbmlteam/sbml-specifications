<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1" xmlns:sbml="http://www.sbml.org/sbml/level1" exclude-result-prefixes="sbml">

<xsl:import href="justa.xsl"/>

<xsl:template match="sbml:specie[@name='C']/@initialAmount">
<xsl:attribute name="initialAmount">20</xsl:attribute>
</xsl:template>

<xsl:template match="sbml:reaction[@name='J23']//sbml:parameter[@name='V_24']/@value">
<xsl:attribute name="value">1.2</xsl:attribute>
</xsl:template>

</xsl:stylesheet>