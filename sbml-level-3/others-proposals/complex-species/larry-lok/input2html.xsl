<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output encoding="ISO-8859-1" method="html"/>
<xsl:param name="doc-url">file:/home/lok/src/moleculizer/doc/Edit/</xsl:param>
<xsl:key match="mols/*" name="mol-name-key" use="@name"/>
<xsl:key match="modifications/*" name="mod-name-key" use="@name"/>
<xsl:key match="explicit-species/*" name="species-name-key" use="@name"/>
<xsl:key match="species-streams/*" name="species-stream-name-key" use="@name"/>
<xsl:key match="dump-streams/*" name="dump-stream-name-key" use="@name"/>
<xsl:template name="test-mol-name">
<xsl:param name="the-mol-name"/>
<xsl:if test="not(key('mol-name-key', $the-mol-name))">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Unknown mol `</xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-name-unique">
<xsl:param name="the-mol-name"/>
<xsl:if test="count(key('mol-name-key', $the-mol-name)) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>  Duplicate mol name `</xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>'.   </xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-site-name">
<xsl:param name="the-mol-name"/>
<xsl:param name="the-site-name"/>
<xsl:variable name="mol-element" select="key('mol-name-key', $the-mol-name)"/>
<xsl:if test="$mol-element">
<xsl:if test="not($mol-element/binding-site[@name = $the-site-name])">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   No binding site `</xsl:text>
<xsl:value-of select="$the-site-name"/>
<xsl:text>'  on mol  </xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>.   </xsl:text>
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-site-name-unique">
<xsl:param name="the-mol-name"/>
<xsl:param name="the-site-name"/>
<xsl:variable name="mol-element" select="key('mol-name-key', $the-mol-name)"/>
<xsl:if test="count($mol-element) = 1">
<xsl:if test="count($mol-element/binding-site[@name = $the-site-name]) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>  Duplicate site name `</xsl:text>
<xsl:value-of select="$the-site-name"/>
<xsl:text>'  on mol  </xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>.   </xsl:text>
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-mod-site-name">
<xsl:param name="the-mol-name"/>
<xsl:param name="the-mod-site-name"/>
<xsl:variable name="mol-element" select="key('mol-name-key', $the-mol-name)"/>
<xsl:if test="$mol-element">
<xsl:if test="not($mol-element/mod-site[@name = $the-mod-site-name])">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   No modification site `</xsl:text>
<xsl:value-of select="$the-mod-site-name"/>
<xsl:text>'  on mol  </xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>.   </xsl:text>
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-mod-site-name-unique">
<xsl:param name="the-mol-name"/>
<xsl:param name="the-mod-site-name"/>
<xsl:variable name="mol-element" select="key('mol-name-key', $the-mol-name)"/>
<xsl:if test="count($mol-element) = 1">
<xsl:if test="count($mol-element/mod-site[@name = $the-mod-site-name]) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate modification site name `</xsl:text>
<xsl:value-of select="$the-mod-site-name"/>
<xsl:text>'  on mol  </xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>.   </xsl:text>
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template name="test-modification-name">
<xsl:param name="the-mod-name"/>
<xsl:if test="not(key('mod-name-key', $the-mod-name))">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Unknown modification `</xsl:text>
<xsl:value-of select="$the-mod-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-modification-name-unique">
<xsl:param name="the-mod-name"/>
<xsl:if test="count(key('mod-name-key', $the-mod-name)) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate modification name `</xsl:text>
<xsl:value-of select="$the-mod-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-site-shape-name">
<xsl:param name="the-mol-name"/>
<xsl:param name="the-site-name"/>
<xsl:param name="the-shape-name"/>
<xsl:variable name="mol-element" select="key('mol-name-key', $the-mol-name)"/>
<xsl:if test="$mol-element">
<xsl:variable name="binding-site-element" select="$mol-element/binding-site[@name = $the-site-name]"/>
<xsl:if test="$binding-site-element">
<xsl:if test="not($binding-site-element/site-shape[@name = $the-shape-name])">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Binding site </xsl:text>
<xsl:value-of select="$the-site-name"/>
<xsl:text>  on mol  </xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text> has no shape named `</xsl:text>
<xsl:value-of select="$the-shape-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template name="test-site-shape-name-unique">
<xsl:param name="the-mol-name"/>
<xsl:param name="the-site-name"/>
<xsl:param name="the-shape-name"/>
<xsl:variable name="mol-element" select="key('mol-name-key', $the-mol-name)"/>
<xsl:if test="count($mol-element) = 1">
<xsl:variable name="binding-site-element" select="$mol-element/binding-site[@name = $the-site-name]"/>
<xsl:if test="count($binding-site-element) = 1">
<xsl:if test="count($binding-site-element/site-shape[@name = $the-shape-name]) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate shape name `</xsl:text>
<xsl:value-of select="$the-shape-name"/>
<xsl:text>'  on site  </xsl:text>
<xsl:value-of select="$the-site-name"/>
<xsl:text> of mol </xsl:text>
<xsl:value-of select="$the-mol-name"/>
<xsl:text>.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template name="test-rate-not-negative">
<!--This DOES NOT WORK for  "scientific notation"-->
<!-- the number  "-1.2e5" does not test negative -->
<!-- under XSLT numerics.-->
<xsl:param name="the-rate"/>
<xsl:if test="$the-rate &lt; 0.0">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Rate  </xsl:text>
<xsl:value-of select="$the-rate"/>
<xsl:text> should not be negative.    </xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-instance-name">
<xsl:param name="the-plex-element"/>
<xsl:param name="the-instance-name"/>
<xsl:if test="not($the-plex-element/mol-instance[@name = $the-instance-name])">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   There is no mol-instance named `  </xsl:text>
<xsl:value-of select="$the-instance-name"/>
<xsl:text>'.    </xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-instance-name-unique">
<xsl:param name="the-plex-element"/>
<xsl:param name="the-instance-name"/>
<xsl:if test="count($the-plex-element/mol-instance[@name = $the-instance-name]) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate instance name `  </xsl:text>
<xsl:value-of select="$the-instance-name"/>
<xsl:text>'.    </xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-mol-instance-site-name">
<xsl:param name="the-plex-element"/>
<xsl:param name="the-instance-name"/>
<xsl:param name="the-site-name"/>
<xsl:variable name="the-mol-instance-element" select="$the-plex-element/mol-instance[@name = $the-instance-name]"/>
<xsl:variable name="instance-mol-name" select="$the-mol-instance-element/mol-ref/@name"/>
<xsl:call-template name="test-mol-site-name">
<xsl:with-param name="the-mol-name" select="$instance-mol-name"/>
<xsl:with-param name="the-site-name" select="$the-site-name"/>
</xsl:call-template>
</xsl:template>
<xsl:template name="test-mol-instance-mod-site-name">
<xsl:param name="the-plex-element"/>
<xsl:param name="the-instance-name"/>
<xsl:param name="the-mod-site-name"/>
<xsl:variable name="the-mol-instance-element" select="$the-plex-element/mol-instance[@name = $the-instance-name]"/>
<xsl:variable name="instance-mol-name" select="$the-mol-instance-element/mol-ref/@name"/>
<xsl:call-template name="test-mol-mod-site-name">
<xsl:with-param name="the-mol-name" select="$instance-mol-name"/>
<xsl:with-param name="the-mod-site-name" select="$the-mod-site-name"/>
</xsl:call-template>
</xsl:template>
<xsl:template name="test-mol-instance-site-shape-name">
<xsl:param name="the-plex-element"/>
<xsl:param name="the-instance-name"/>
<xsl:param name="the-site-name"/>
<xsl:param name="the-shape-name"/>
<xsl:variable name="the-mol-instance-element" select="$the-plex-element/mol-instance[@name = $the-instance-name]"/>
<xsl:variable name="instance-mol-name" select="$the-mol-instance-element/mol-ref/@name"/>
<xsl:call-template name="test-site-shape-name">
<xsl:with-param name="the-mol-name" select="$instance-mol-name"/>
<xsl:with-param name="the-site-name" select="$the-site-name"/>
<xsl:with-param name="the-shape-name" select="$the-shape-name"/>
</xsl:call-template>
</xsl:template>
<xsl:template name="test-species-name">
<xsl:param name="the-species-name"/>
<xsl:if test="not(key('species-name-key', $the-species-name))">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Unknown species `</xsl:text>
<xsl:value-of select="$the-species-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-species-name-unique">
<xsl:param name="the-species-name"/>
<xsl:if test="count(key('species-name-key', $the-species-name)) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate species name `</xsl:text>
<xsl:value-of select="$the-species-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-multiplicity-positive">
<xsl:param name="the-multiplicity"/>
<xsl:if test="$the-multiplicity &lt;= 0">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Multiplicity `</xsl:text>
<xsl:value-of select="$the-multiplicity"/>
<xsl:text>' should be a positive integer.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-species-stream-name">
<xsl:param name="the-species-stream-name"/>
<xsl:if test="not(key('species-stream-name-key', $the-species-stream-name))">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Unknown species-stream `</xsl:text>
<xsl:value-of select="$the-species-stream-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-species-stream-name-unique">
<xsl:param name="the-species-stream-name"/>
<xsl:if test="count(key('species-stream-name-key', $the-species-stream-name)) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate species-stream name `</xsl:text>
<xsl:value-of select="$the-species-stream-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-dump-stream-name">
<xsl:param name="the-dump-stream-name"/>
<xsl:if test="not(key('dump-stream-name-key', $the-dump-stream-name))">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Unknown dump-stream `</xsl:text>
<xsl:value-of select="$the-dump-stream-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template name="test-dump-stream-name-unique">
<xsl:param name="the-dump-stream-name"/>
<xsl:if test="count(key('dump-stream-name-key', $the-dump-stream-name)) &gt; 1">
<xsl:element name="font">
<xsl:attribute name="color">red</xsl:attribute>
<xsl:text>   Duplicate dump-stream name `</xsl:text>
<xsl:value-of select="$the-dump-stream-name"/>
<xsl:text>'.</xsl:text>
</xsl:element>
</xsl:if>
</xsl:template>
<xsl:template match="moleculizer-input">
<xsl:element name="H1">
<xsl:text>moleculizer-input</xsl:text>
</xsl:element>
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:template>
<xsl:template match="model">
<xsl:element name="dt">
<xsl:element name="H2">
<xsl:text>model</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="mols">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>mols</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="modifications">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>modifications</xsl:text>
</xsl:element>
<xsl:element name="ul">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's-->
<!--in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="modification">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-modification-name-unique">
<xsl:with-param name="the-mod-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:text>Weight delta:  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="weight-delta/@daltons"/>
</xsl:element>
<xsl:text>  daltons</xsl:text>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="binding-site">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-mol-site-name-unique">
<xsl:with-param name="the-mol-name" select="../@name"/>
<xsl:with-param name="the-site-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Default shape: </xsl:text>
<xsl:apply-templates select="default-shape-ref"/>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's-->
<!--in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>All shapes: </xsl:text>
<xsl:element name="ul">
<xsl:apply-templates select="site-shape"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's-->
<!--in pairs.-->
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="mod-mol">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-mol-name-unique">
<xsl:with-param name="the-mol-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Type: </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="$doc-url"/>
<xsl:text>mod-mol.html</xsl:text>
</xsl:attribute>
<xsl:text>mod-mol</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty-->
<!--Trying to keep dt's and dd's-->
<!--in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>Molecular weight: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="weight/@daltons"/>
</xsl:element>
<xsl:text> daltons</xsl:text>
</xsl:element>
<xsl:element name="dt">
<xsl:text>Binding sites: </xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates select="binding-site"/>
</xsl:element>
</xsl:element>
<xsl:element name="dt">
<xsl:text>Modification sites: </xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates select="mod-site"/>
</xsl:element>
</xsl:element>
<xsl:apply-templates select="allosteric-state"/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="site-shape">
<xsl:element name="li">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-site-shape-name-unique">
<xsl:with-param name="the-mol-name" select="../../@name"/>
<xsl:with-param name="the-site-name" select="../@name"/>
<xsl:with-param name="the-shape-name" select="@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="default-shape-ref">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
</xsl:template>
<xsl:template match="mod-site">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-mol-mod-site-name-unique">
<xsl:with-param name="the-mol-name" select="../@name"/>
<xsl:with-param name="the-mod-site-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:text>Default modification: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="default-mod-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-modification-name">
<xsl:with-param name="the-mod-name" select="default-mod-ref/@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="default-state">
<xsl:element name="dd"/>
<xsl:text>default-state </xsl:text>
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="allosteric-state">
<xsl:element name="dt">
<xsl:text>Allosteric state: </xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Modification map: </xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:apply-templates select="mod-map"/>
</xsl:element>
<xsl:element name="dt">
<xsl:text>Shape map: </xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:apply-templates select="site-shape-map"/>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="mod-map">
<xsl:element name="ul">
<xsl:apply-templates select="mod-site-ref"/>
</xsl:element>
</xsl:template>
<xsl:template match="mod-site-ref">
<xsl:element name="li">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:text> =&gt; </xsl:text>
<xsl:element name="em">
<xsl:value-of select="mod-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-mol-instance-mod-site-name">
<xsl:with-param name="the-plex-element" select="../../../plex"/>
<xsl:with-param name="the-instance-name" select="../../mol-instance-ref/@name"/>
<xsl:with-param name="the-mod-site-name" select="@name"/>
</xsl:call-template>
<xsl:call-template name="test-modification-name">
<xsl:with-param name="the-mod-name" select="mod-ref/@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="site-shape-map">
<xsl:element name="ul">
<xsl:apply-templates select="binding-site-ref"/>
</xsl:element>
</xsl:template>
<xsl:template match="binding-site-ref">
<xsl:element name="li">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:text> =&gt; </xsl:text>
<xsl:element name="em">
<xsl:value-of select="site-shape-ref/@name"/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="allosteric-plexes">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>allosteric-plexes</xsl:text>
</xsl:element>
<xsl:element name="ul">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep the dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="allosteric-omnis">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>allosteric-omnis</xsl:text>
</xsl:element>
<xsl:element name="ul">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="plex">
<xsl:element name="dt">
<xsl:text>Mol-instances:</xsl:text>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
<xsl:element name="ul">
<xsl:apply-templates select="mol-instance"/>
</xsl:element>
</xsl:element>
<xsl:element name="dt">
<xsl:text>Bindings:</xsl:text>
<xsl:element name="ul">
<xsl:apply-templates select="binding"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep the dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="allosteric-plex">
<xsl:call-template name="allo-plex-content"/>
</xsl:template>
<xsl:template match="allosteric-omni">
<xsl:call-template name="allo-plex-content"/>
</xsl:template>
<xsl:template name="allo-plex-content">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="mol-instance">
<xsl:element name="li">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:text> := </xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-mol-name">
<xsl:with-param name="the-mol-name" select="mol-ref/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-instance-name-unique">
<xsl:with-param name="the-plex-element" select=".."/>
<xsl:with-param name="the-instance-name" select="@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="binding">
<xsl:element name="li">
<xsl:element name="em">
<xsl:value-of select="mol-instance-ref[1]/@name"/>
</xsl:element>
<xsl:text>::</xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-instance-ref[1]/binding-site-ref/@name"/>
</xsl:element>
<xsl:text>  &lt;=&gt;  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-instance-ref[2]/@name"/>
</xsl:element>
<xsl:text>::</xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-instance-ref[2]/binding-site-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-mol-instance-name">
<xsl:with-param name="the-plex-element" select=".."/>
<xsl:with-param name="the-instance-name" select="mol-instance-ref[1]/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-instance-name">
<xsl:with-param name="the-plex-element" select=".."/>
<xsl:with-param name="the-instance-name" select="mol-instance-ref[2]/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-instance-site-name">
<xsl:with-param name="the-plex-element" select=".."/>
<xsl:with-param name="the-instance-name" select="mol-instance-ref[1]/@name"/>
<xsl:with-param name="the-site-name" select="mol-instance-ref[1]/binding-site-ref/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-instance-site-name">
<xsl:with-param name="the-plex-element" select=".."/>
<xsl:with-param name="the-instance-name" select="mol-instance-ref[2]/@name"/>
<xsl:with-param name="the-site-name" select="mol-instance-ref[2]/binding-site-ref/@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="allosteric-sites">
<xsl:element name="dt">
<xsl:text>Allosteric-sites:</xsl:text>
<xsl:element name="ul">
<xsl:apply-templates select="mol-instance-ref"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="mol-instance-ref">
<xsl:element name="li">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:text>::</xsl:text>
<xsl:element name="em">
<xsl:value-of select="binding-site-ref/@name"/>
</xsl:element>
<xsl:text> =&gt; </xsl:text>
<xsl:element name="em">
<xsl:value-of select="binding-site-ref/site-shape-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-mol-instance-name">
<xsl:with-param name="the-plex-element" select="../../plex"/>
<xsl:with-param name="the-instance-name" select="@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-instance-site-name">
<xsl:with-param name="the-plex-element" select="../../plex"/>
<xsl:with-param name="the-instance-name" select="@name"/>
<xsl:with-param name="the-site-name" select="binding-site-ref/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-instance-site-shape-name">
<xsl:with-param name="the-plex-element" select="../../plex"/>
<xsl:with-param name="the-instance-name" select="@name"/>
<xsl:with-param name="the-site-name" select="binding-site-ref/@name"/>
<xsl:with-param name="the-shape-name" select="binding-site-ref/site-shape-ref/@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="reaction-gens">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>reaction-gens</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="dimerization-gen">
<xsl:element name="dt">
<xsl:text>dimerization-gen</xsl:text>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="mol-ref[1]/@name"/>
</xsl:element>
<xsl:text>::</xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-ref[1]/site-ref/@name"/>
</xsl:element>
<xsl:text>  &lt;=&gt;  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-ref[2]/@name"/>
</xsl:element>
<xsl:text>::</xsl:text>
<xsl:element name="em">
<xsl:value-of select="mol-ref[2]/site-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-mol-name">
<xsl:with-param name="the-mol-name" select="mol-ref[1]/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-name">
<xsl:with-param name="the-mol-name" select="mol-ref[2]/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-site-name">
<xsl:with-param name="the-mol-name" select="mol-ref[1]/@name"/>
<xsl:with-param name="the-site-name" select="mol-ref[1]/site-ref/@name"/>
</xsl:call-template>
<xsl:call-template name="test-mol-site-name">
<xsl:with-param name="the-mol-name" select="mol-ref[2]/@name"/>
<xsl:with-param name="the-site-name" select="mol-ref[2]/site-ref/@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>Default-on-rate: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="default-on-rate/@value"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>Default-off-rate: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="default-off-rate/@value"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>Allo-rates:</xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="allo-rates">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="site-shape-ref[1]/@name"/>
</xsl:element>
<xsl:text> &lt;=&gt; </xsl:text>
<xsl:element name="em">
<xsl:value-of select="site-shape-ref[2]/@name"/>
</xsl:element>
<xsl:call-template name="test-site-shape-name">
<xsl:with-param name="the-mol-name" select="../mol-ref[1]/@name"/>
<xsl:with-param name="the-site-name" select="../mol-ref[1]/site-ref/@name"/>
<xsl:with-param name="the-shape-name" select="site-shape-ref[1]/@name"/>
</xsl:call-template>
<xsl:call-template name="test-site-shape-name">
<xsl:with-param name="the-mol-name" select="../mol-ref[2]/@name"/>
<xsl:with-param name="the-site-name" select="../mol-ref[2]/site-ref/@name"/>
<xsl:with-param name="the-shape-name" select="site-shape-ref[2]/@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>On-rate: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="on-rate/@value"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>Off-rate: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="off-rate/@value"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="explicit-species">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>explicit-species</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="stoch-species">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-species-name-unique">
<xsl:with-param name="the-species-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Type: </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="$doc-url"/>
<xsl:text>stoch-species.html</xsl:text>
</xsl:attribute>
<xsl:text>stoch-species</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:text>Weight: </xsl:text>
<xsl:element name="em">
<xsl:value-of select="weight/@daltons"/>
</xsl:element>
<xsl:text> daltons</xsl:text>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="plex-species">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-species-name-unique">
<xsl:with-param name="the-species-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Type: </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="$doc-url"/>
<xsl:text>plex-species.html</xsl:text>
</xsl:attribute>
<xsl:text>plex-species</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:call-template name="plex-class"/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template name="plex-class">
<xsl:apply-templates select="plex"/>
<xsl:apply-templates select="instance-states"/>
</xsl:template>
<xsl:template match="instance-states">
<xsl:element name="dt">
<xsl:text>Instance states: </xsl:text>
<xsl:element name="ul">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep the dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="mod-mol-instance-ref">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-mol-instance-name">
<xsl:with-param name="the-plex-element" select="../../plex"/>
<xsl:with-param name="the-instance-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Modifications: </xsl:text>
<xsl:apply-templates select="mod-map"/>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="explicit-reactions">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>explicit-reactions</xsl:text>
</xsl:element>
<xsl:element name="ul">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep the dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="reaction">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:text>Substrates:</xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:apply-templates select="substrate-species-ref"/>
</xsl:element>
<xsl:element name="dt">
<xsl:text>Deltas: </xsl:text>
</xsl:element>
<xsl:element name="dd">
<xsl:apply-templates select="delta-species-ref"/>
</xsl:element>
<xsl:element name="dt">
<xsl:text>Rate: </xsl:text>
<xsl:apply-templates select="rate"/>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep the dt's and dd's in pairs.-->
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="substrate-species-ref">
<xsl:value-of select="@multiplicity"/>
<xsl:text>   </xsl:text>
<xsl:value-of select="@name"/>
<xsl:call-template name="test-species-name">
<xsl:with-param name="the-species-name" select="@name"/>
</xsl:call-template>
<xsl:call-template name="test-multiplicity-positive">
<xsl:with-param name="the-multiplicity" select="@multiplicity"/>
</xsl:call-template>
<xsl:element name="br"/>
</xsl:template>
<xsl:template match="delta-species-ref">
<xsl:value-of select="@multiplicity"/>
<xsl:text>   </xsl:text>
<xsl:value-of select="@name"/>
<xsl:call-template name="test-species-name">
<xsl:with-param name="the-species-name" select="@name"/>
</xsl:call-template>
<xsl:element name="br"/>
</xsl:template>
<xsl:template match="rate">
<xsl:value-of select="@value"/>
</xsl:template>
<xsl:template match="volume">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>volume</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:value-of select="@liters"/>
<xsl:text>  liters</xsl:text>
</xsl:element>
</xsl:template>
<xsl:template match="streams">
<xsl:element name="dt">
<xsl:element name="H2">
<xsl:text>streams</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="species-streams">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>species-streams</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="plex-species-stream">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-species-stream-name-unique">
<xsl:with-param name="the-species-stream-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:text>Type:  </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="$doc-url"/>
<xsl:text>plex-species-stream.html</xsl:text>
</xsl:attribute>
<xsl:text>plex-species-stream</xsl:text>
</xsl:element>
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="omni-species-stream">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-species-stream-name-unique">
<xsl:with-param name="the-species-stream-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="a">
<xsl:text>Type: omni-species-stream</xsl:text>
</xsl:element>
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="dump-streams">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>dump-streams</xsl:text>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="dump-stream">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
<xsl:call-template name="test-dump-stream-name-unique">
<xsl:with-param name="the-dump-stream-name" select="@name"/>
</xsl:call-template>
</xsl:element>
<xsl:element name="dd">
<xsl:element name="dl">
<xsl:apply-templates select="target-file"/>
<xsl:apply-templates select="target-output-stream"/>
<xsl:element name="dt">
<xsl:text>Dump period:  </xsl:text>
<xsl:element name="em">
<xsl:apply-templates select="@dump-period"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
<xsl:element name="dt">
<xsl:element name="ul">
<xsl:apply-templates select="species-stream-ref"/>
<xsl:apply-templates select="species-ref"/>
<xsl:apply-templates select="stat-stream-ref"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="target-file">
<xsl:element name="dt">
<xsl:text>Target file:  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="@file-name"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="target-output-stream">
<xsl:element name="dt">
<xsl:text>Target output-stream:  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="@name"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="species-stream-ref">
<xsl:element name="li">
<xsl:element name="em">
<xsl:apply-templates select="@name"/>
</xsl:element>
<xsl:text>  (a species stream)</xsl:text>
<xsl:call-template name="test-species-stream-name">
<xsl:with-param name="the-species-stream-name" select="@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="species-ref">
<xsl:element name="li">
<xsl:element name="em">
<xsl:apply-templates select="@name"/>
</xsl:element>
<xsl:text>  (a single species)</xsl:text>
<xsl:call-template name="test-species-name">
<xsl:with-param name="the-species-name" select="@name"/>
</xsl:call-template>
</xsl:element>
</xsl:template>
<xsl:template match="stat-stream-ref">
<xsl:element name="li">
<xsl:element name="em">
<xsl:apply-templates select="@name"/>
</xsl:element>
<xsl:text>  (a simulator statistic)</xsl:text>
</xsl:element>
</xsl:template>
<xsl:template match="events">
<xsl:element name="dt">
<xsl:element name="H3">
<xsl:text>events</xsl:text>
</xsl:element>
<xsl:element name="ul">
<xsl:apply-templates/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<!--This is intentionally empty.-->
<!--Trying to keep dt's and dd's in pairs.-->
</xsl:element>
</xsl:template>
<xsl:template match="create-event">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@time"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:text>Create  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="population/@count"/>
</xsl:element>
<xsl:text>     </xsl:text>
<xsl:element name="em">
<xsl:value-of select="species-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-species-name">
<xsl:with-param name="the-species-name" select="species-ref/@name"/>
</xsl:call-template>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="start-dump-event">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@time"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:text>Start dump stream  </xsl:text>
<xsl:element name="em">
<xsl:value-of select="dump-stream-ref/@name"/>
</xsl:element>
<xsl:call-template name="test-dump-stream-name">
<xsl:with-param name="the-dump-stream-name" select="dump-stream-ref/@name"/>
</xsl:call-template>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
<xsl:template match="stop-event">
<xsl:element name="li">
<xsl:element name="dl">
<xsl:element name="dt">
<xsl:element name="em">
<xsl:value-of select="@time"/>
</xsl:element>
</xsl:element>
<xsl:element name="dd">
<xsl:text>Stop</xsl:text>
</xsl:element>
</xsl:element>
</xsl:element>
</xsl:template>
</xsl:stylesheet>
