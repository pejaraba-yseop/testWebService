<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:yt="http://www.yseop.com/text/2"
xmlns:y="http://www.yseop.com/engine/3">
<!-- for the text traces -->
<xsl:template match="yt:text-eval">

	<!-- to trigger it only one time -->
	<!-- will not work if multiple finalDocument trees -->
	<xsl:variable name="isRoot" select="not(ancestor::*[name() = name()])" />

	<xsl:if test="$isRoot = true()"> 
		<script type="text/javascript">
			//to avoid loading twice css and js.
			if(typeof(text_eval_css_AlreadyLoaded) == "undefined" || typeof(text_eval_js_AlreadyLoaded) == "undefined") {
	        	if (typeof(loadJsArrayYseop) == "undefined" || typeof(loadJsArrayYseop) === "undefined") {
	        		var div=document.createElement('div');
	        		div.style.cssText = "padding: 50px; font-size: 20px; background-color: #FCC;";
	        		var p1 = document.createElement("p");
	        		var t1 = document.createTextNode("In the XSL pipe, the cssLoader XSL template must be called in order for the text traces to be displayed correctly.");
	        		p1.appendChild(t1);
	        		
	        		var p2 = document.createElement("p");
	        		var t2 = document.createTextNode("Please, add the following XSL instruction as close as possible from the root match template in your specific XSL:");
	        		p2.appendChild(t2);

	        		var p3 = document.createElement("pre");
	        		var t3 = document.createTextNode("&lt;script type='text/javascript'&gt; \n\t &lt;xsl:call-template name='cssLoader'&gt; &lt;/xsl:call-template&gt; \n&lt;" + "/script&gt; ");


					p3.appendChild(t3);

	        		div.appendChild(p1);
	        		div.appendChild(p2);
					div.appendChild(p3);

	        		document.body.insertBefore(div, document.body.firstChild);
	  			} else {
	      			loadCssArrayYseop([
	        			"sharedXsl/html/commun-yseop-text-eval.css",
	      			]);
	 
	 
	      			loadJsArrayYseop([
	        			"sharedXsl/html/commun-yseop-text-eval.js",
	      			]);

	      			text_eval_js_AlreadyLoaded = true;
	      			text_eval_css_AlreadyLoaded = true;
	  			}
	  		}
	    </script>
	</xsl:if>


	<span class="text-eval">
		<xsl:if test="$isRoot = true()">
			<xsl:attribute name="class">text-eval text-eval-container</xsl:attribute>
		</xsl:if>
		<!-- <span class="text_eval_moreOrLess_icon less"/> -->
 		<div class="text-eval_data">
			<span class="data_title"><xsl:value-of select="@class"/> yid</span>: <span class="data_value"><xsl:value-of select="@yid"/></span><br/>
			<span class="data_title">source file</span>: <span class="data_value"><xsl:value-of select="@src-file"/></span><br/>
			<span class="data_title">line</span>: <span class="data_value"><xsl:value-of select="@src-line"/></span><br/>
			
			<xsl:if test="@class='MultilingualText'">
				<span class="data_title">language</span>: 
				<span class="data_value">
					<xsl:choose>
						<xsl:when test="yt:text-eval">
							<xsl:value-of select="yt:reverse(substring(yt:reverse(yt:text-eval/@yid), 1, 2))" />
						</xsl:when>
						<xsl:otherwise>unknown</xsl:otherwise>
					</xsl:choose>
				</span>
				<br/>
			</xsl:if>
		</div>
		<span class="text-eval_content">
			<xsl:apply-templates select="node()" />
		</span>

	</span>
	
</xsl:template>

<xsl:template match="yt:text-eval[@class='MultilingualText']/yt:text-eval">
	<xsl:apply-templates select="node()" />
</xsl:template>

<xsl:template match="yt:text-eval[@class='InternalExpression_textFunctionCall']">
	<xsl:apply-templates select="node()" />
</xsl:template>
</xsl:stylesheet>