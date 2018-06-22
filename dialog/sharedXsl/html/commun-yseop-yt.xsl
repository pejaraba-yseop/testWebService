<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:yt="http://www.yseop.com/text/2"  xmlns:y="http://www.yseop.com/engine/3" >

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>  
        </xsl:copy>
    </xsl:template>

<!-- this variable allows us to control what is in the XML document -->
<xsl:variable name="commun-yseop-yt-CurrentDocument" select="/" />


<!--********************* FUNCTION reverse a string ******************* -->
<xsl:function name="yt:reverse">
	<xsl:param name="input"/>
	<xsl:sequence select="codepoints-to-string(reverse(string-to-codepoints($input)))"/>
</xsl:function>


	<!-- 
TABLEAUX
-->
	<xsl:template match="yt:table">
		<div class="titreTableau">
			<xsl:apply-templates select="yt:title"/>
		</div>
		<xsl:element name="table">
			<xsl:copy-of select="@id|@class|@style"/>
			<!-- <xsl:attribute name="border">1</xsl:attribute> -->
			<xsl:apply-templates select="yt:cells"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="yt:cells">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="yt:span">
		<xsl:element name="span">
			<xsl:copy-of select="@id|@class|@style"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:div">
		<xsl:element name="div">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:label">
		<xsl:element name="label">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:input">
		<xsl:element name="input">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:h1">
		<xsl:element name="h1">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:h2">
		<xsl:element name="h2">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:h3">
		<xsl:element name="h3">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:h4">
		<xsl:element name="h4">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:h5">
		<xsl:element name="h5">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:h6">
		<xsl:element name="h6">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:row">
		<tr>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="yt:cell">
		<td>
			<xsl:copy-of select="@id|@class|@style|@placeholder|@value|@label|@align"/>
			<xsl:apply-templates/>
		</td>
	</xsl:template>

	<xsl:template match="yt:header">
		<th>
			<xsl:apply-templates/>
		</th>
	</xsl:template>

	
	<!-- 
STRUCTURE DE DOC
-->
	<xsl:template match="yt:title">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="yt:section">
		<xsl:element name="div">
			<xsl:if test="@id">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@class">
					<xsl:attribute name="class">
						<xsl:value-of select="@class"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">section</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="yt:comment">
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
	<!-- 
TEXTES
-->
	<xsl:template match="yt:italic">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="yt:bold">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="yt:underline">
		<u>
			<xsl:apply-templates/>
		</u>
	</xsl:template>
	<xsl:template match="yt:enum">
    <xsl:choose>
      <xsl:when test="@numbering = 'bullet'">
        <ul>  
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </ul>  
      </xsl:when>
      <xsl:when test="@numbering = 'decimal'">
        <ol>
          <xsl:attribute name="type">1</xsl:attribute>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
      <xsl:when test="@numbering = 'lower-alpha'">
        <ol>
          <xsl:attribute name="type">a</xsl:attribute>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
      <xsl:when test="@numbering = 'lower-roman'">
        <ol>
          <xsl:attribute name="type">i</xsl:attribute>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
      <xsl:when test="@numbering = 'upper-alpha'">
        <ol>
          <xsl:attribute name="type">A</xsl:attribute>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
      <xsl:when test="@numbering = 'upper-roman'">
        <ol>
          <xsl:attribute name="type">I</xsl:attribute>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
    </xsl:choose>     
	</xsl:template>
	<xsl:template match="yt:item">
    <xsl:if test="node()">
      <li>
        <xsl:apply-templates/>
      </li>
    </xsl:if>
	</xsl:template>
	<xsl:template match="yt:line">
		<br/>
	</xsl:template>
	<xsl:template match="yt:par">
		<p>
			<xsl:if test="@class != ''">
				<xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@id != ''">
				<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="yt:picture">
		<img>
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name(.)='alternate'">
						<xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</img>
	</xsl:template>
	<xsl:template match="yt:hlink">
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="yt:src"/>
			</xsl:attribute>
			<xsl:attribute name="target">
				<xsl:value-of select="@target"/>
			</xsl:attribute>
			
			<xsl:value-of select="yt:title"/>
		</a>
	</xsl:template>
	
	<xsl:template match="yt:no-break-space">&#160;<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="yt:non-breaking-hyphen">&#8209;</xsl:template>
	

	<xsl:template match="yt:begin-simple-quote">
		<xsl:text>&#8216;</xsl:text>
	</xsl:template>
	<xsl:template match="yt:end-simple-quote">
		<xsl:text>&#8217;</xsl:text>
	</xsl:template>

	<xsl:template match="yt:begin-double-quote">
		<xsl:choose>
			<xsl:when test="@style='en'">
				<xsl:text>&#8220;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>&#171;&#160;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="yt:end-double-quote">
		<xsl:choose>
			<xsl:when test="@style='en'">
				<xsl:text>&#8221;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>&#160;&#187;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="yt:superscript">
	    <sup>
		<xsl:apply-templates/>
	    </sup>
	</xsl:template>
	<xsl:template match="yt:subscript">
	    <sub>
	        <xsl:apply-templates/>
	    </sub>
	</xsl:template>

<!-- 
to load css
-->
<xsl:template name="cssLoader">

/*
  source : http://www.javascriptkit.com/javatutors/loadjavascriptcss.shtml
*/
function loadjscssfile(filename, filetype, onload){
	if (filetype=="js"){ //if filename is a external JavaScript file
		var fileref=document.createElement('script')
		fileref.setAttribute("type","text/javascript")
		fileref.setAttribute("src", filename)
		if (typeof onload !=="undefined")
			fileref.addEventListener("load", onload);
	}
	else if (filetype=="css"){ //if filename is an external CSS file
		var fileref=document.createElement("link")
		fileref.setAttribute("rel", "stylesheet")
		fileref.setAttribute("type", "text/css")
		fileref.setAttribute("href", filename)
	}
	
	if (typeof fileref!="undefined")
		document.getElementsByTagName("head")[0].appendChild(fileref)
}

function loadCssArrayYseop(cssArray) {

//split the URL
//URL form is http://server/yseop-manager/dialog/project-name/....
var split_URL = location.pathname.split("/");


var pn = split_URL[3];
var mode = split_URL[2];

// when in Yseop Manager
  if (location.protocol == 'http:') {

  	if (pn!=null) {
  	  for (var i in cssArray) {
  	  	loadjscssfile("http://" + location.host + "/" + split_URL[1] + "/" + "dialog" + "/" + split_URL[3] + "/" + cssArray[i], "css");
  	  }
  	} else {
  	  alert("project name not found!");
  	}

  // when batch with XSL
  } else {
  	for (var i in cssArray) {
  	  //loadjscssfile("http://" + location.host + "/" + split_URL[1] + "/" + "dialog" + "/" + split_URL[3] + "/" + cssArray[i], "css");
  	  loadjscssfile("../dialog/" + cssArray[i], "css");
  	}
  }
}


function loadJsArrayYseop(jsArray) {
var split_URL = location.pathname.split("/");


var pn = split_URL[3];
var mode = split_URL[2];

  // when in Yseop Manager
  if (location.protocol == 'http:') {
  	
  	if (pn!=null) {
		if (jsArray.length == 0) { return; }
		if (jsArray.length == 1) {
			loadjscssfile("http://" + location.host + "/" + split_URL[1] + "/" + "dialog" + "/" + split_URL[3] + "/"  + jsArray[0], "js");
		} else {
			currentFileToLoad = jsArray[0];
			jsArray.splice(0, 1);
			tempArray = jsArray;
			
			loadjscssfile("http://" + location.host + "/" + split_URL[1] + "/" + split_URL[2] + "/" + split_URL[3] + "/" + currentFileToLoad , 
							"js", 
							function() { loadJsArrayYseop(tempArray); } 
			);
		}
	
  	} else {
  	  alert("project name not found!");
  	}
  // when batch with XSL
  } else {
  	for (var i in jsArray) {
  	  loadjscssfile("../dialog/" + jsArray[i], "js");
  	}
  }
}

</xsl:template>



<!-- for the text traces -->
<xsl:template match="yt:text-eval">

	<!-- to trigger it only one time -->
	<!-- will not work if multiple finalDocument trees -->
	<xsl:variable name="isRoot" select="not(ancestor::*/name() = name())" />

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
		<!-- Do not remove this comment it is required for preview fix YS-737 -->
		<xsl:comment><xsl:value-of select="@id-write"/></xsl:comment>
	</span>
	
</xsl:template>

<xsl:template match="yt:text-eval[@class='MultilingualText']/yt:text-eval">
	<xsl:apply-templates select="node()" />
</xsl:template>

<xsl:template match="yt:text-eval[@class='InternalExpression_textFunctionCall']">
	<xsl:apply-templates select="node()" />
</xsl:template>



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
