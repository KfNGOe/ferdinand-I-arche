<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/schema#"
    version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:variable name="TopColId">
            <xsl:value-of select="data(.//acdh:TopCollection/@rdf:about)"/>
        </xsl:variable>
        <xsl:variable name="websiteDomain" select="'https://ferdinand-korrespondenz.acdh.oeaw.ac.at/'">
      
        </xsl:variable>
        <xsl:variable name="constants">
            <xsl:for-each select=".//node()[parent::acdh:RepoObject]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:variable>
        <rdf:RDF xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/schema#">
            <acdh:TopCollection rdf:about="https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz">
                <acdh:hasPid>https://hdl.handle.net/21.11115/0000-000F-7494-7</acdh:hasPid>
                <acdh:hasTitle xml:lang="de">Die Familienkorrespondenz von Ferdinand I.</acdh:hasTitle>
                <acdh:hasUrl>https://ferdinand-korrespondenz.acdh.oeaw.ac.at</acdh:hasUrl>
                <acdh:hasDescription xml:lang="de">Die Familienkorrespondenz von Ferdinand I. kodiert in XML/TEI, ergänzt um ein Personen-, Orts- und Sachregister.</acdh:hasDescription>
                <acdh:hasActor rdf:resource="http://d-nb.info/gnd/118532502"/><!-- RH: Kaiser Ferdinand I -->        
                <acdh:hasContact rdf:resource="https://d-nb.info/gnd/121046842"/><!-- RH: Christopher Laferl -->
                <acdh:hasMetadataCreator rdf:resource="https://d-nb.info/gnd/13295639X"/><!-- RH: Richard Hörmann -->
                <acdh:hasCurator rdf:resource="https://d-nb.info/gnd/1043833846"/><!-- RH: Richard Hörmann -->
                <acdh:hasDepositor rdf:resource="https://d-nb.info/gnd/1050382196"/><!-- RH -->
                <acdh:hasRelatedDiscipline rdf:resource="https://vocabs.acdh.oeaw.ac.at/oefosdisciplines/601"/>
                <acdh:hasSubject xml:lang="de">Edition</acdh:hasSubject>
                <acdh:hasLanguage rdf:resource="https://vocabs.acdh.oeaw.ac.at/iso6393/deu"/><!-- RH: ?xxxx -->
                <xsl:copy-of select="$constants"/>
            </acdh:TopCollection>
            <acdh:Collection rdf:about="https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz/editions">
                <acdh:hasPid>https://hdl.handle.net/21.11115/0000-000F-7495-6</acdh:hasPid>
                <acdh:isPartOf rdf:resource="https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz"/>
                <acdh:hasTitle xml:lang="de">Editionen</acdh:hasTitle>
                <acdh:hasDescription xml:lang="de">XML/TEI Dokumente</acdh:hasDescription>
                <acdh:hasLanguage rdf:resource="https://vocabs.acdh.oeaw.ac.at/iso6393/deu"/><!-- RH: ?xxxx -->
                <!-- <acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">1889-01-01</acdh:hasCoverageStartDate>
                <acdh:hasCoverageEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">1931-01-01</acdh:hasCoverageEndDate>
                <acdh:hasCreatedStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2018-07-01</acdh:hasCreatedStartDate>
                <acdh:hasCreatedEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2021-08-31</acdh:hasCreatedEndDate> -->
                <xsl:copy-of select="$constants"/>
            </acdh:Collection>        
            <acdh:Collection rdf:about="https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz/indices">
                <acdh:isPartOf rdf:resource="https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz"/>
                <acdh:hasPid>https://hdl.handle.net/21.11115/0000-000F-7496-5</acdh:hasPid>
                <acdh:hasTitle xml:lang="de">Register</acdh:hasTitle>
                <acdh:hasDescription xml:lang="de">XML/TEI kodiertes Orts-, Sach- und Personenregister</acdh:hasDescription>
                <acdh:hasLanguage rdf:resource="https://vocabs.acdh.oeaw.ac.at/iso6393/deu"/>
                <!-- <acdh:hasCreatedStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2018-07-01</acdh:hasCreatedStartDate>
            <acdh:hasCreatedEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2021-08-31</acdh:hasCreatedEndDate> -->
                <xsl:copy-of select="$constants"/>
            </acdh:Collection>
            <xsl:for-each select=".//node()[parent::acdh:MetaAgents]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <!-- <xsl:for-each select="subsequence(collection('../data/editions/band_001/')//tei:TEI, 1, 10)"> -->
            <xsl:for-each select="collection('../data/editions/band_001/')//tei:TEI">
                <xsl:variable name="filenName">
                    <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>
                </xsl:variable>
                <xsl:variable name="partOf">
                    <xsl:value-of select="concat($TopColId, '/editions')"/>
                </xsl:variable>
                <xsl:variable name="id">
                    <xsl:value-of select="concat($TopColId, '/', $filenName)"/>
                </xsl:variable>
                <xsl:if test="starts-with($filenName, 'A')">
                    <acdh:Resource rdf:about="{$id}">
                        <acdh:isPartOf rdf:resource="{$partOf}"/>
                        <acdh:hasUrl><xsl:value-of select="replace(concat($websiteDomain, $filenName), '.xml', '.html')"/></acdh:hasUrl>
                        <acdh:hasTitle xml:lang="de">
                            <xsl:choose>
                                <xsl:when test=".//tei:title[@type='sub']/text()"><xsl:value-of select=".//tei:title[@type='sub']/text()"/></xsl:when>
                                <xsl:otherwise>Kein Titel gefunden</xsl:otherwise>
                            </xsl:choose>
                        </acdh:hasTitle>
                        <acdh:hasAccessRestriction rdf:resource="https://vocabs.acdh.oeaw.ac.at/archeaccessrestrictions/public"/>
                        <acdh:hasCategory rdf:resource="https://vocabs.acdh.oeaw.ac.at/archecategory/text/tei"/>
                        <acdh:hasDescription xml:lang="de"><xsl:value-of select="normalize-space(string-join(.//tei:div[@n='2']//text()))"/></acdh:hasDescription>
                        <acdh:hasDescription xml:lang="en"><xsl:value-of select="normalize-space(string-join(.//tei:div[@n='3']//text()))"/></acdh:hasDescription>
                        <!--<acdh:hasLanguage rdf:resource="https://vocabs.acdh.oeaw.ac.at/iso6393/deu"/>-->
                        <!--<acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="$date"/></acdh:hasCoverageStartDate>-->
                        <xsl:copy-of select="$constants"/>
                    </acdh:Resource> 
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="collection('../data/register/')//tei:TEI">
                <xsl:variable name="filenName">
                    <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>
                </xsl:variable>
                <xsl:variable name="partOf">
                    <xsl:value-of select="concat($TopColId, '/indices')"/>
                </xsl:variable>
                <xsl:variable name="id">
                    <xsl:value-of select="concat($TopColId, '/', $filenName)"/>
                </xsl:variable>
                <xsl:if test="starts-with($filenName, 'register')">
                    <acdh:Resource rdf:about="{$id}">
                        <acdh:isPartOf rdf:resource="{$partOf}"/>
                        <acdh:hasUrl><xsl:value-of select="replace(concat($websiteDomain, $filenName), '.xml', '.html')"/></acdh:hasUrl>
                        <acdh:hasTitle xml:lang="en"><xsl:value-of select=".//tei:title[1]/text()"/></acdh:hasTitle>
                        <acdh:hasAccessRestriction rdf:resource="https://vocabs.acdh.oeaw.ac.at/archeaccessrestrictions/public"/>
                        <acdh:hasCategory rdf:resource="https://vocabs.acdh.oeaw.ac.at/archecategory/text/tei"/>
                        <!--<acdh:hasLanguage rdf:resource="https://vocabs.acdh.oeaw.ac.at/iso6393/deu"/>-->                        
                        <xsl:copy-of select="$constants"/>
                    </acdh:Resource> 
                </xsl:if>
                
                
            </xsl:for-each>
        </rdf:RDF>
    </xsl:template>   
</xsl:stylesheet>
