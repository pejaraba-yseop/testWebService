<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:tem="http://tempuri.org/"
  xmlns:shar="http://tempuri.org/sharedObjectsIntegration"
  xmlns:y="http://www.yseop.com/engine/3"
  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  exclude-result-prefixes="y">
  
<xsl:output 
  method="xml" 
  version="1.0"
  encoding="UTF-8" 
  indent="yes" />

  
<!-- root element -->
<xsl:template match="/">
	<y:input>
		<y:datas>
			<xsl:apply-templates select="//*[name()=$entryPoints/entryPoint]" />
		</y:datas>
	</y:input>
</xsl:template>


<!-- ********************************************************************* -->
<!-- * The different entry points for the webservices (different methods)* -->
<!-- ********************************************************************* -->
<!-- It links the method called by the external application to the usecase 
	 and GeneralData that we should use -->
<xsl:variable name="entryPoints">
	<entryPoint yidDonneesGenerales="lesDonneesGeneralesVisites" usecase="Visites:_usecase">getVisitesOutput</entryPoint>
</xsl:variable>

<xsl:template match="*[name()=$entryPoints/entryPoint]">
	<xsl:variable name="selectedElement"><xsl:value-of select="name()" /></xsl:variable>
	<!-- The (entry) usecase -->
	<xsl:element name="y:instance">
		<xsl:attribute name="yclass" select="$entryPoints/entryPoint[.=$selectedElement]/@usecase" />
	</xsl:element>
	<!-- The "GeneralData" instance -->
	<xsl:element name="y:instance">
		<xsl:attribute name="yid" select="$entryPoints/entryPoint[.=$selectedElement]/@yidDonneesGenerales" />
		<xsl:apply-templates select="node()" />
	</xsl:element>
</xsl:template>


<!-- ********************************************************************* -->
<!-- ************** The default treatement for an element **************** -->
<!-- ********************************************************************* -->
<!-- copy the elements recursively (without the attributes) and lowercase the 
	 first letter of the node names. It applies only if no other template applies -->
<xsl:template match="*" priority="-1">
  <xsl:element name="{concat(lower-case(substring(name(.), 1, 1)), substring(name(.), 2))}">
    <xsl:apply-templates select="node()"/>
  </xsl:element>
</xsl:template>


<!-- ********************************************************************* -->
<!-- ******************** The "ghost" elements *************************** -->
<!-- ********************************************************************* -->
<!-- the elements we want to let through but which should not appear in the
	 xml output. In other words, we don't copu those elements but we treat their
	 children -->
<xsl:variable name="ghostElements">
	<ghostElement>input</ghostElement>
</xsl:variable>

<xsl:template match="*[name()=$ghostElements/ghostElement]">
	<xsl:apply-templates select="node()" />
</xsl:template>


<!-- ********************************************************************* -->
<!-- ******************** The elements to remove ************************* -->
<!-- ********************************************************************* -->
<!-- as their name suggest, all the elements we don't need in the xml output.
	 Unlike the ghost elements, it removes also the child elements of those
	 nodes -->
<xsl:variable name="elementsToRemove">
	<elementToRemove>DateArchive</elementToRemove>
	<elementToRemove>CodeDepartement</elementToRemove>
	<elementToRemove>LibelleDepartement</elementToRemove>
	<elementToRemove>Region</elementToRemove>
	<elementToRemove>RueOuVoie</elementToRemove>
	<elementToRemove>InfosProprietaire</elementToRemove>
	<elementToRemove>NegociateurId</elementToRemove>
	<elementToRemove>AgenceId</elementToRemove>
	<elementToRemove>AgenceNom</elementToRemove>
	<elementToRemove>EquipeId</elementToRemove>
	<elementToRemove>EquipeNom</elementToRemove>
	<elementToRemove>DpeOffre</elementToRemove>
	<elementToRemove>LettreDpeOffre</elementToRemove>
	<elementToRemove>PanneauId</elementToRemove>
	<elementToRemove>TypePublicationWebId</elementToRemove>
	<elementToRemove>NumeroVoie</elementToRemove>
	<elementToRemove>Zone</elementToRemove>
	<elementToRemove>MandatId</elementToRemove>
	<elementToRemove>DateDebutMandat</elementToRemove>
	<elementToRemove>DateFinMandat</elementToRemove>
	<elementToRemove>DateEnregistrementMandat</elementToRemove>
	<elementToRemove>LibelleMandat</elementToRemove>
	<elementToRemove>MandatAvancementId</elementToRemove>
	<elementToRemove>LibelleAvancement</elementToRemove>
	<elementToRemove>SurfacePlusGrandLotBureaux</elementToRemove>
	<elementToRemove>HauteurMinSousPoutre</elementToRemove>
	<elementToRemove>ResistanceSol</elementToRemove>
	<elementToRemove>BatimentPlainPied</elementToRemove>
	<elementToRemove>NbPortesPlainPied</elementToRemove>
	<elementToRemove>ComplementPortesPlainPied</elementToRemove>
	<elementToRemove>DescriptionEquipementEntrepots</elementToRemove>
	<elementToRemove>DetailsComplementairesActivite </elementToRemove>
	<elementToRemove>Sprinkler</elementToRemove>
	<elementToRemove>Chauffages</elementToRemove>
	<elementToRemove>TexteComplementPorteQuai</elementToRemove>
	<elementToRemove>TexteTrame</elementToRemove>
	<elementToRemove>Couverture</elementToRemove>
	<elementToRemove>MurPeripherique</elementToRemove>
	<elementToRemove>Ossature</elementToRemove>
</xsl:variable>

<xsl:template match="*[name()=$elementsToRemove/elementToRemove]">
	<!-- Do nothing -->
</xsl:template>


<!-- ********************************************************************* -->
<!-- ************************ The yclass nodes *************************** -->
<!-- ********************************************************************* -->
<!-- the nodes corresponding to a class in Yseop. We then add an attribute yclass
	 to the element; either it is explicitely written in the yclassNode, either
	 we reuse the name of the node -->
<xsl:variable name="yclassNodes">
	<yclassNode>Demande</yclassNode>
	<yclassNode>CrVisite</yclassNode>
	<yclassNode>OffreCbre</yclassNode>
	<yclassNode>Ressources</yclassNode>
	<yclassNode>PhotosOffre</yclassNode>
	<yclassNode>InfosGestionnaire</yclassNode>
	<yclassNode>InfosProprietaire</yclassNode>
	<yclassNode>Structure</yclassNode>
	<yclassNode>Surface</yclassNode>
	<yclassNode>ImpotsCharges</yclassNode>
	<yclassNode>Adresse</yclassNode>
	<yclassNode>PrixDeVente</yclassNode>
	<yclassNode>Loyer</yclassNode>
	<yclassNode>Disponibilite</yclassNode>
	<yclassNode>Mandat</yclassNode>
</xsl:variable>

<xsl:template match="*[name(.)=$yclassNodes/yclassNode]">
	<xsl:variable name="selectedElement"><xsl:value-of select="name(.)" /></xsl:variable>
	<xsl:element name="{concat(lower-case(substring(name(.), 1, 1)), substring(name(.), 2))}">
		<xsl:if test="$yclassNodes/yclassNode[.=$selectedElement]/@yclass">
			<xsl:attribute name="yclass">
				<xsl:value-of select="$yclassNodes/yclassNode[.=$selectedElement]/@yclass" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="not($yclassNodes/yclassNode[.=$selectedElement]/@yclass)">
			<xsl:attribute name="yclass">
				<xsl:value-of select="$selectedElement" />
			</xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select="node()"/>
	</xsl:element>
</xsl:template>


<!-- ********************************************************************* -->
<!-- ************************** The yid nodes **************************** -->
<!-- ********************************************************************* -->
<!-- the nodes which are a reference (yid) in the engine. We specify the 
	 yidRoot (the value being the value of the node) and the elementName
	 if the element has a different name in the engine and in the incoming xml -->
<xsl:variable name="yidElements">
	<yidElement yidRoot="TM_">TypeMotivation</yidElement>
	<yidElement yidRoot="SD_">Statut</yidElement>
	<yidElement yidRoot="TA_">TypeAction</yidElement>
	<yidElement yidRoot="typeDispo">TypeDispo</yidElement>
	<yidElement yidRoot="natureOffre">NatureOffre</yidElement>
	<yidElement yidRoot="typeBail">TypeBail</yidElement>
	<yidElement yidRoot="etatImmeuble">EtatImmeuble</yidElement>
	<yidElement yidRoot="etatOffre">EtatOffre</yidElement>
	<yidElement yidRoot="typeLocVte">TypeLocVte</yidElement>
	<yidElement yidRoot="avisDispo" yElementName="avisDispoSaisi_private">AvisDispoSaisiPrivate</yidElement>
	<yidElement yidRoot="avisDispo" yElementName="avisDispoCalcule_private">AvisDispoCalculePrivate</yidElement>
	<yidElement yidRoot="commune">CommuneOffre</yidElement>
	<yidElement yidRoot="departement">DepartementOffre</yidElement>
	<yidElement yidRoot="stadeCommercialisation" yElementName="stadeCommercialisationSaisi_private">StadeCommercialisationSaisiPrivate</yidElement>
	<yidElement yidRoot="stadeCommercialisation" yElementName="stadeCommercialisationCalcule_private">StadeCommercialisationCalculePrivate</yidElement>
	<yidElement yidRoot="typePanneau">TypePanneauId</yidElement>
	<yidElement yidRoot="typeMandat">MandatTypeId</yidElement>
	<yidElement yidRoot="">EnthousiasmeClient</yidElement>
</xsl:variable>

<xsl:template match="*[name(.)=$yidElements/yidElement]">
	<xsl:variable name="savedYidElement"><xsl:value-of select="name(.)" /> </xsl:variable>
	<xsl:variable name="savedYidValue"><xsl:value-of select="." /></xsl:variable>
	<!-- if the element have a different name in yseop and in the incoming stream -->
	<xsl:if test="$yidElements/yidElement[.=$savedYidElement]/@yElementName">
		<xsl:element name="{$yidElements/yidElement[.=$savedYidElement]/@yElementName}">
			<xsl:attribute name="yid">
				<xsl:value-of select="$yidElements/yidElement[.=$savedYidElement]/@yidRoot" />
				<xsl:value-of select="$savedYidValue" />
			</xsl:attribute>
		</xsl:element>
	</xsl:if>
	<!-- otherwise, we assume they have the same name -->
	<xsl:if test="not($yidElements/yidElement[.=$savedYidElement]/@yElementName)">
		<xsl:element name="{concat(lower-case(substring(name(.), 1, 1)), substring(name(.), 2))}">
			<xsl:attribute name="yid">
				<xsl:value-of select="$yidElements/yidElement[.=$savedYidElement]/@yidRoot" />
				<xsl:value-of select="$savedYidValue" />
			</xsl:attribute>
		</xsl:element>
	</xsl:if>
</xsl:template>


<!-- ********************************************************************* -->
<!-- ********************* The yseop list elements *********************** -->
<!-- ********************************************************************* -->
<!-- The yseop list objects...
	Several cases: 
		- convert to a simple list of values ( <xxx yclass="List"><values>45</values>...</xxx>)
		- List with complex objects (<yyy yclass="List"><values yid="..." />... </yyy>)
	-->
<xsl:variable name="listElements">
	<listElement>VillesRecherchees</listElement>
	<listElement yidRoot="niveau">Niveaux</listElement>
	<listElement yidRoot="zone">ZonesOffre</listElement>
	<listElement yidRoot="icpe">AutorisationsIcpe</listElement>
	<listElement yidRoot="icpe">DeclarationsIcpe</listElement>
</xsl:variable>

<xsl:template match="*[name(.)=$listElements/listElement]">
	<xsl:variable name="savedListElement"><xsl:value-of select="name(.)" /></xsl:variable>
	<xsl:element name="{concat(lower-case(substring(name(.), 1, 1)), substring(name(.), 2))}">
		<xsl:attribute name="yclass">List</xsl:attribute>
		<xsl:for-each select="./*">
			<xsl:element name="values">
				<xsl:if test="$listElements/listElement[.=$savedListElement]/@yidRoot">
					<xsl:attribute name="yid">
						<xsl:value-of select="$listElements/listElement[.=$savedListElement]/@yidRoot" />
						<xsl:value-of select="." />
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="not($listElements/listElement[.=$savedListElement]/@yidRoot)">
					<xsl:value-of select="." />
				</xsl:if>
			</xsl:element>
		</xsl:for-each>
	</xsl:element>
</xsl:template>


<!-- ********************************************************************* -->
<!-- ****************** The yseop multivalued elements ******************* -->
<!-- ********************************************************************* -->
<!-- the yseop multivalued elements...
	 We transform the incoming array in a regular multivalued field in yseop.
	  - the yName specifies the name of the multivalued element
	  - the yClass attribute (if present) specifies the yclass in the engine 
	  - the yClassExtension specifies the yClass to use if the element can be 
		sub-classes -->
<xsl:variable name="multivaluedElements">
	<multivaluedElement yName="demandeAvecActionsSurOffre" yClass="DemandeAvecActionsSurOffre">DemandesAvecActionsSurOffre</multivaluedElement>
	<multivaluedElement yName="actionAssocieeADemande" yClass="ActionDemande" yClassExtension="ActionVisite">ActionAssocieeADemande</multivaluedElement>
	<multivaluedElement yName="actionDirecte" yClass="ActionDirecte" yClassExtension="ActionDirecte">ActionsDirecte</multivaluedElement>
	<multivaluedElement yName="codePostalRecherche">CodePostalRecherche</multivaluedElement>
	<multivaluedElement yName="zoneRechercheeId">ZonesRechercheesId</multivaluedElement>
	<multivaluedElement yName="departementRecherche">DepartementRecherche</multivaluedElement>
</xsl:variable>

<xsl:template match="*[name(.)=$multivaluedElements/multivaluedElement]">
	<xsl:variable name="savedListElement" select="name(.)" />
	<xsl:for-each select="./*">
		<xsl:element name="{$multivaluedElements/multivaluedElement[.=$savedListElement]/@yName}">
			<xsl:if test="$multivaluedElements/multivaluedElement[.=$savedListElement]/@yClass">
				<xsl:choose>
					<xsl:when test="name(@*)='xsi:type'">
						<xsl:attribute name="yclass" select="$multivaluedElements/multivaluedElement[.=$savedListElement]/@yClassExtension" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="yclass" select="$multivaluedElements/multivaluedElement[.=$savedListElement]/@yClass" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:apply-templates select="node()" />
		</xsl:element>
	</xsl:for-each>
</xsl:template>


<!-- ********************************************************************* -->
<!-- ********************** The date elements **************************** -->
<!-- ********************************************************************* -->
<!-- Among others, the date elements have a specila format in yseop -->
<xsl:variable name="dateElements">
	<dateElement>DateButoir</dateElement>
	<dateElement>DateAction</dateElement>
	<dateElement>DateCreation</dateElement>
	<dateElement>DateReveil</dateElement>
	<dateElement>DateArchive</dateElement>
</xsl:variable>

<xsl:template match="*[name(.)=$dateElements/dateElement]">
	<xsl:param name="datestr" select="." />
	<xsl:variable name="date" select="$datestr cast as xsd:dateTime"/>
	<xsl:if test="string-length($datestr)!=0">
		<xsl:element name="{concat(lower-case(substring(name(.), 1, 1)), substring(name(.), 2))}">
			<xsl:value-of select="format-dateTime($date, '[D01]-[M01]-[Y0001]:[H01]h[m01]')" />
		</xsl:element>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>

