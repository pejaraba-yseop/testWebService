<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
données structurées
-->
	<xsl:template match="reponseWeightedNeed-data">
		<tr>
			<td class="tableReponseAuBesoinCol1">
				<xsl:value-of select="@needResponse"/>
			</td>
			<td class="tableReponseAuBesoinCol2">
				<xsl:value-of select="round(@weight*100)"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="need">
		<tr>
			<td class="tableCriterionsColBesoin">
				<xsl:value-of select="@idNeed"/>
			</td>
			<td>
				<xsl:value-of select="@needWeight"/>
			</td>
			<td>
				<table class="tableReponseAuBesoin">
					<xsl:apply-templates/>
				</table>
			</td>
			<td>
				<xsl:value-of select="@getNeedWeight"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="criterion">
		<h3>
			<xsl:element name="a">
				<xsl:attribute name="name">
					<xsl:value-of select="name(../../..)"/>_<xsl:value-of select="../../@num"/>_<xsl:value-of select="@libCriterion"/>
				</xsl:attribute>
				<xsl:value-of select="@libCriterion"/>
( for proposition #<xsl:value-of select="../../@num"/> )

<xsl:element name="a">
					<xsl:attribute name="href">#<xsl:value-of select="name(../../..)"/>_<xsl:value-of select="../../@num"/>
					</xsl:attribute>
Back
</xsl:element>
			</xsl:element>
		</h3>
		<p>
Value:
<b>
				<xsl:element name="span">
					<xsl:attribute name="name">decodeable</xsl:attribute>
					<xsl:value-of select="@libelleValeur"/>
				</xsl:element>
			</b>
		</p>
		<ul class="criteriaDetails">
			<li>
How this offer matches the criterium in %:
				<ol>
					<li class="finalCriterionScore">Final Score for this criterion (sum of scores for each Need): <xsl:value-of select="@finalCriterionScore"/></li>
					<li class="finalClientImportance">Maximum Score (equal to Criterium Importance for the client) : <xsl:value-of select="@finalClientImportance"/>
					</li>
					<li class="offerMatchingPercentage" style="list-style:none;">
						<b>==> Therefore, this offer matches the criterion at <xsl:value-of select="round(@offerMatchingPercentage*100)"/>% (X = a / b)</b>
					</li>
				</ol>
			</li>
			<li>
Criterium Weight:
<ol>
					<li class="weight">Criterium Basic Weight: <xsl:value-of select="@weight"/>
					</li>
					<li class="finalClientImportance">Criterium Importance for the client: <xsl:value-of select="@finalClientImportance"/>
					</li>
					<li class="finalCriterionWeight" ><b>==> Total Weight (Y = a * b): <xsl:value-of select="@finalCriterionWeight"/></b>
					</li>
				</ol>
			</li>
		</ul>
		<b>==> Criterium impact on the final Offer Score (X * Y): <xsl:value-of select="@impactOnTotalScore"/><br/><br/></b>
		<table class="tableCriterions">
			<tr>
				<th class="tableCriterionsCol1">Need</th>
				<th class="tableCriterionsCol2">Client Need coefficient (importance)</th>
				<th class="tableCriterionsCol3">Need Response / Score in %</th>
				<th class="tableCriterionsCol4">
					<b>Need Score</b> = Client Need coef. * Need Response Score</th>
			</tr>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="proposition-data">
		<h2>
			<xsl:element name="a">
				<xsl:attribute name="name">
					<xsl:value-of select="name(..)"/>_<xsl:value-of select="@num"/>
				</xsl:attribute>
				<xsl:value-of select="@num"/>
-
<xsl:value-of select="@label"/>
			</xsl:element>

&#160;<a href="#regles">Back</a>
		</h2>
		<p>
Proposition Type:<xsl:value-of select="@type"/> .
</p>

Result:
<ul>
			<li>
Applied on:<xsl:value-of select="@offerClass"/>
			</li>
			<li>
Key:<xsl:value-of select="@key"/>
			</li>
			<li>
Usecase Key:<xsl:value-of select="@businessKey"/>
			</li>
			<li>
Label:<xsl:value-of select="@offerLabel"/>
			</li>
			<li>
Total Score:<xsl:value-of select="@score"/>
			</li>
		</ul>
		<!--
résumé
-->
		<table class="tableResume">
			<tr>
				<th class="tableResumeCol1">Criterion</th>
				<th class="tableResumeCol2">Impact on total score</th>
				<th class="tableResumeCol3">
					<b>Final Score</b> = Client Importance Coef. * Weight</th>
				<th class="tableResumeCol4">How the offer satisfies the need in %</th>
			</tr>
			<xsl:for-each select="criteria/criterion">
				<tr>
					<td>
						<xsl:element name="a">
							<xsl:attribute name="href">#<xsl:value-of select="name(../../..)"/>_<xsl:value-of select="../../@num"/>_<xsl:value-of select="@libCriterion"/>
							</xsl:attribute>
							<xsl:value-of select="@libCriterion"/>
						</xsl:element>
					</td>
					<td>
						<xsl:value-of select="@impactOnTotalScore"/>
					</td>
					<td>
						<b>
							<xsl:value-of select="@finalCriterionWeight"/>
						</b>
=
<xsl:value-of select="@finalClientImportance"/> *
<xsl:value-of select="@weight"/>
					</td>
					<td>
						<xsl:value-of select="round(@offerMatchingPercentage*100)"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<xsl:apply-templates select="criteria"/>
	</xsl:template>
	<xsl:template name="scoring">
		<table class="tableComparatifRegles">
			<tr>
				<th>
					<a name="regles">
						<h1>Propositions <a href="#top">Back</a>
						</h1>
					</a>
				</th>
				<th>
					<h1>Expected Propositions<a href="#top">Back</a>
					</h1>
				</th>
			</tr>
			<tr>
				<td>
					<xsl:apply-templates select="//propositions-data"/>
				</td>
				<td>
					<xsl:apply-templates select="//propositions-attendues-data"/>
				</td>
			</tr>
			<xsl:for-each select="//propositions-data/proposition-data">
				<tr>
					<td>
						<xsl:apply-templates select="."/>
					</td>
					<td>
						<xsl:apply-templates select="./../../propositions-attendues-data/proposition-data[@num=current()/@num]"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="propositions-data | propositions-attendues-data">
		<!--
ne fait que la table des matières
-->
		<ul>
			<xsl:for-each select="proposition-data">
				<li>
					<xsl:element name="a">
						<xsl:attribute name="href">#<xsl:value-of select="name(..)"/>_<xsl:value-of select="@num"/>
						</xsl:attribute>
						<xsl:value-of select="@num"/> - <xsl:value-of select="@label"/> - <xsl:value-of select="@offerLabel"/> (note : <xsl:value-of select="@score"/>)

</xsl:element>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
