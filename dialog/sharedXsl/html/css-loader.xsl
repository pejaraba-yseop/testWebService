<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:yt="http://www.yseop.com/text/2"
xmlns:y="http://www.yseop.com/engine/3">
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
						loadjscssfile("http://" + location.host + "/" + split_URL[1] + "/" + split_URL[2] + "/" + split_URL[3] + "/" + currentFileToLoad , 							"js", 							function() { loadJsArrayYseop(tempArray); } 			);
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
</xsl:stylesheet>