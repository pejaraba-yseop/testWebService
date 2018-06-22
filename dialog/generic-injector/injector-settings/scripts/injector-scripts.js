/*======================================================================================================================*/
var _formId = "dasForm";
var _f;
var _contentType;
var project;
var caseGroups;
var languages;
var displayLanguages;
var properties;
/*======================================================================================================================*/
/*
DO NOT CHANGE THE FOLLOWING UNLESS YOU KNOW WHAT YOU ARE DOING
*/
var _insertXMLData = "";
var beginXML = ""; // TODO : refactoring
var endXML = "";


$.fn.extend({
	createButton: function (options) {

		//$(this).hide();
		var caseId = $(this).attr("id");
		$(this).next("label").hide();
		$(this).after('<input type="button" class="button mdl-button mdl-js-button" id="btn' + $(this).attr("id") + '" value="' + $(this).next("label").text() + '"/>');
		if ($("#" + caseId).is(":checked") == true) {
			$("#btn" + $(this).attr("id")).addClass("selected");
		}

		$("#btn" + $(this).attr("id")).click(function () {
			$("#cases .button").removeClass("selected");
			$("label[for='" + caseId + "']").click();
			$(this).addClass("selected");


		});
	}
});

function buildXML() {

	loadData();
	$("#xml").show();
	if ($("#xml ul").is(":visible") == false) {
		$("#xml h2").click();
	}

	if (project.resultTarget != "area") {
		var offset = $('#xml').offset();
		$('html,body').animate({ scrollTop: offset.top }, 500);
	}
}
function buildFormStd() {
	addCss("https://fonts.googleapis.com/css?family=Raleway:500,600");
	var body = $(".mdl-layout");
	body.append('<header class="mdl-layout__header ">' +	
	'<div class="mdl-layout__header-row mdl-color--white">'+
			'<span class="mdl-layout-title mdl-color-text--blue-500"></span>'+
	'<div class="mdl-layout-spacer"></div>'+
	'</header>');
	
		//body.append("<h1 class='title'>" + (project.title != undefined ? project.title : ( project.name != undefined ? project.name : "Dataset Builder" )) + "</h1>");
	body.append('<main class="mdl-layout__content"></main>');
	$("main").append("<div class='mdl-cell mdl-cell--8-col mdl-color--white mdl-shadow--2dp'><form name='" + _formId + "' id='" + _formId + "'>" +
	'<input name="text-log" value="false" type="hidden"/>'+
		"<input type='hidden' name='transformation' value=''>" +
		"<div id='tabs'>" +
		"<ul>" +
		"<li>" +

		"</li>" +
		"</ul>" +
		"<div id='tab1'>");
	
	if (project.usePictureForTitle == true) {
		$(".mdl-layout-title").append('<div id="title"><h4 class="clientLogo"><span><img src="../images/' +
			project.pictureFileName +
			'""></span></h4></div>');
	} else {
		$(".mdl-layout-title").append('<div id="title"><h4>' +
			(project.title != undefined ? project.title : "The Yseop injector") +
			'</h4></div>');
	}

	document.title = (project.title != undefined ? project.title : "Yseop DatasetBuilder");
	
	if(project.resultTarget == "area"){
		$("header").after("<div class='mdl-layout__drawer'>" +

		"<ul>" +
		"<li id='propertiesItems'>" +
		"<div id='listeFieldSetDemande'></div>" +
		"</li>");
	}
	else
	{
		$("form").append(
		"<ul>" +
		"<li id='propertiesItems'>" +
		"<div id='listeFieldSetDemande'></div>" +
		"</li>"
		)
	}
	


	if (navigator.appVersion.indexOf("MSIE 6.0") != -1) {
		$('#propertiesItems').append("<br/><input type='button' onclick='loadData(submitForm);' value='" +
			(project.launchButtonLabel != undefined ? project.launchButtonLabel : "Launch Yseop") + "' />");

		$('#propertiesItems').append('<a href="#" id="buildXML" onclick="buildXML();" class="mdl-button mdl-js-button mdl-button--raised mdl-color--blue-500 mdl-color-text--white">' +
			//(project.loadXMLButtonLabel != undefined ? project.loadXMLButtonLabel : "Load XML") + 
			'</a>');

	}
	else {
		if (project.displayLaunchYseopButton != false ) {
		$('#propertiesItems').append(
			"<li id='propertiesButtons' style='vertical-align: top; padding-top: 25px;'>" +
			"<a href='#' id='buildAndLaunch' onclick='" +
			(project.resultTarget == 'area' ? 'generateResult()' : 'loadData(submitForm)') +
			"' class='mdl-button mdl-js-button mdl-button--raised mdl-color--blue-500 mdl-color-text--white'>" +
			(project.launchButtonLabel != undefined ? project.launchButtonLabel : "Launch Yseop") +
			"</a>" +
			"</li>")
		/*$("#propertiesButtons").append(
			'<a href="#" id="buildXML" onclick="buildXML();" class="mdl-button mdl-js-button mdl-button--raised mdl-color--blue-500 mdl-color-text--white">' +
			(project.loadXMLButtonLabel != undefined ? project.loadXMLButtonLabel : "Load XML") +
			'</a>');*/
		}

	}

	$("#propertiesItems").after("</ul></div>");
	
	$("main").append("</div>" +
		"</div>" +
		"</form></div>" );
	body.append(
		
		
		"<div id='logoContainer'>" +
		"<div id='logo'/>" +
		"</div>");
	_f = $("#" + _formId);


	var fsDiv = $("div#listeFieldSetDemande");
	var ul;
	var li;
	
	//build cases inputs
	if (caseGroups) {
		//start div
		fsDiv.append("<div id='cases'>");
		var casesFS = $("div#cases");
		// legend
		casesFS.append("<h6><a href='#'>" +
			(project.casesLabel != undefined ? project.casesLabel : "Cases") +
			"</a></h6>");

		$.each(caseGroups, function (i, _caseGroup) {

			ul = document.createElement("ul");
			casesFS.append('<div id="' +

				(_caseGroup.title != undefined ? _caseGroup.title.replace(/\s/g, "") : ("group_" + i))

				+
				'" class="situation"><p class="casesContainer"></p></div>');




			var caseGroupName = (_caseGroup.title != undefined ? _caseGroup.title.replace(/\s/g, "") : ("group_" + i));
			var caseGroupFS = $("div#" + caseGroupName);

			if (_caseGroup.title != undefined) {
				caseGroupFS.prepend('<h5>' + _caseGroup.title + '<i class="fa fa-chevron-up"></i></h5>');
			}

			if (_caseGroup.folded != false && project.resultTarget == "area") {
				caseGroupFS.children("h5").children("i").removeAttr("class");
				caseGroupFS.children("h5").children("i").attr("class", "fa fa-chevron-down");
				caseGroupFS.children(".casesContainer").toggle();

			}

			$.each(_caseGroup.cases, function (i, _case) {
				li = document.createElement("li");
				if (_case.disabled == true) {
					li.className = "disabled";
				}
				var caseId = _case.label.replace(/\s|,/g, "");
				//radio
				li.innerHTML = "<input type='radio' id='" + caseId +
					(_case.defaultValue == true ? "' checked='checked'" : "'") +
					(_case.disabled == true ? " disabled='disabled'" : "") +
					" name='cases' value='" + _case.file + "' contentType='" + _case.contentType + "' class='required'></input>";
				//label
				li.innerHTML += "<label for='" + caseId + "'>" +
					(_case.disabled == true ? _case.label.strike() : _case.label) +
					"</label>";
				ul.appendChild(li);
				caseGroupFS.children(".casesContainer").append(ul);
				$("#" + caseId).createButton();
			});

			if (project.resultTarget == "area") {
				$(caseGroupFS).children("h5").click(function () {

					$(this).parent().children(".casesContainer").toggle(50);

					if ($(this).children("i").hasClass("fa-chevron-down")) {
						$(this).children("i").removeAttr("class");
						$(this).children("i").attr("class", "fa fa-chevron-up");
					}
					else {
						$(this).children("i").removeAttr("class");
						$(this).children("i").attr("class", "fa fa-chevron-down");
					}
				});
			}

		});


		//end div
		fsDiv.append("</div>");
	}

	if (languages) {
		$("#cases").after('<div id="languages"><h6 class="mdl-color-text--blue-500">Languages</h6></div>');
		$.each(languages, function (i, _language) {
			$("#languages").append('<input type="button"  id="lang_' + _language + '" value="' + _language + '" class="mdl-button ' + (i == 0 ? "selected" : "") + '" />');
		});
		$("#languages").children(".mdl-button").each(function () {
			$(this).click(function () {
				$("#languages .mdl-button").removeClass("selected");
				$(this).addClass("selected");
				generateResult();
			});
		});
	}
	if (!displayLanguages) {
		$("#languages").hide();
	}
	//build properties inputs

	console.log(properties.length);
	if (properties.length != undefined && properties.length > 0) {
		$.each(properties, function (i, _property) {
			ul = document.createElement("ul");
			switch (_property.type) {
				case "radio":
					//div
					fsDiv.append("<div class='radio' id='" + _property.id + "' ></div>");
					var propertyFS = $("div#" + _property.id);
					// legend
					propertyFS.append("<h6><a href='#'>" + _property.label + "</a></h6>");
					$.each(_property.choices, function (ii, _choice) {
						li = document.createElement("li");
						if (_choice.disabled == true) {
							li.className = "disabled";
						}
						//radio
						li.innerHTML = "<input type='radio' id='rb_" + _choice.value +
							(_choice.defaultValue == true ? "' checked='checked'" : "'") +
							(_property.required ? " class='required'" : "") +
							(_choice.disabled == true ? " disabled='disabled'" : "") +
							" name=" + _property.id + " value='" + _choice.value + "'></input>";
						//label
						li.innerHTML += "<label for='rb_" + _choice.value + "'>" +
							(_choice.disabled == true ? _choice.label.strike() : _choice.label) +
							"</label>";
						ul.appendChild(li);
						propertyFS.append(ul);
					});
					break;
				case "checkbox":
					//div
					fsDiv.append("<div class='checkbox' id='" + _property.id + "' ></div>");
					var propertyFS = $("div#" + _property.id);
					// legend

					if (_property.legend != undefined) {
						propertyFS.append("<h6><a href='#'>" + _property.label + "</a></h6>");
					}

					if (_property.choices != undefined) {
						$.each(_property.choices, function (ii, _choice) {
							li = document.createElement("li");
							if (_choice.disabled == true) {
								li.className = "disabled";
							}
							//radio
							li.innerHTML = "<input type='checkbox' id='chkm_" + _choice.value +
								(_choice.defaultValue == true ? "' checked='checked'" : "'") +
								(_property.required ? " class='required'" : "") +
								(_choice.disabled == true ? " disabled='disabled'" : "") +
								" name=" + _property.id + " value='" + _choice.value + "'></input>";
							//label
							li.innerHTML += "<label for='chkm_" + _choice.value + "'>" +
								(_choice.disabled == true ? _choice.label.strike() : _choice.label) +
								"</label>";
							ul.appendChild(li);
							propertyFS.append(ul);
						});
					}
					else {
						li = document.createElement("li");
						if (_property.disabled == true) {
							li.className = "disabled";
						}
						li.innerHTML = "<input type='checkbox' id='chk" + _property.id +
							(_property.defaultValue == true ? "' checked='checked'" : "'") +
							(_property.required ? " class='required'" : "") +
							(_property.disabled == true ? " disabled='disabled'" : "") +
							" name=" + _property.id + " value='" + _property.value + "'></input>";
						//label
						li.innerHTML += "<label for='chk" + _property.id + "'>" +
							(_property.disabled == true ? _property.label.strike() : _property.label) +
							"</label>";
						ul.appendChild(li);
						propertyFS.append(ul);
					}
					break;
				case "text":
					//div
					fsDiv.append("<div class='text' id='" + _property.id + "' ></div>");
					var propertyFS = $("div#" + _property.id);
					// legend
					if (_property.legend != undefined) {
						propertyFS.append("<h6><a href='#'>" + _property.legend + "</a></h6>");
					}
					li = document.createElement("li");
					if (_property.disabled == true) {
						li.className = "disabled";
					}
					//label
					li.innerHTML = "<label for='" + _property.id + "'>" +
						(_property.disabled == true ? _property.label.strike() : _property.label) +
						"</label>";
					li.innerHTML += "<input type='text' id='" + _property.id + "' name=" + _property.id +
						(_property.required ? " class='required'" : "") +
						(_property.disabled == true ? " disabled='disabled'" : "") +
						"></input>";
					ul.appendChild(li);
					propertyFS.append(ul);
					break;
				case "select":
					fsDiv.append("<div class='selectable' id='" + _property.id + "' ></div>");
					var propertyFS = $("div#" + _property.id);
					if (_property.legend != undefined) {
						propertyFS.append("<h6><a href='#'>" + _property.legend + "</a></h6>");
					}
					li = document.createElement("li");
					li.innerHTML = "<label for='" + _property.id + "'>" +
						(_property.disabled == true ? _property.label.strike() : _property.label) +
						"</label>";
					if (project.submitOnSelectChange == true) {
						li.innerHTML += "<select name='" + _property.id + "' id='" + _property.id + "' onChange='generateResult()'></select>";
					} else {
						li.innerHTML += "<select name='" + _property.id + "' id='" + _property.id + "'></select>";
					}

					ul.appendChild(li);
					propertyFS.append(ul);

					var sel = $("select#" + _property.id);

					$.each(_property.choices, function (key, value) {

						if($.isNumeric(key) == false) {
							sel.append("<option value='" + key + "'>" + value + "</option>");
						}
						else {
							sel.append("<option value='" + value + "'>" + value + "</option>");
						}
					});


					break;
				case "slider":
					//div
					fsDiv.append("<div id='container" + _property.id + "' ></div>");
					var propertyFS = $("div#container" + _property.id);
					// legend
					if (_property.legend != undefined) {
						propertyFS.append("<h6><a href='#'>" + _property.legend + "</a></h6>");
					}
					li = document.createElement("li");
					if (_property.disabled == true) {
						li.className = "disabled";
					}
					//label
					li.innerHTML = "<label for='" + _property.id + "'>" +
						(_property.disabled == true ? _property.label.strike() : _property.label) +
						"</label>";
					li.innerHTML += "<p class='range-value'>"+ (_property.value != undefined ? _property.value : 50)  +"</p> <p class='range-field'> <input type='range' id='" + _property.id + "' name='" + _property.id + "'"+
						(_property.required ? " class='required'" : "") +
						(_property.disabled == true ? " disabled='disabled'" : "") +
						"min='" +(_property.min != undefined ? _property.min : 0) + "'"+
							"max='" +(_property.max != undefined ? _property.max : 0) +"'"+
							"step='" +(_property.step != undefined ? _property.step : 5)+"'"+
							"value='" +(_property.value != undefined ? _property.value : 50) +"'"+
						"></input></p>";
					ul.appendChild(li);
					propertyFS.append(ul);
					$("input#" + _property.id).change(function(){
						$(this).parent().prev('.range-value').text($(this).val());
					});
					/*$("input#" + _property.id).createSlider(
						{
							"min": _property.min != undefined ? _property.min : 0,
							"max": _property.max != undefined ? _property.max : 0,
							"step": _property.step != undefined ? _property.step : 5,
							"value": _property.value != undefined ? _property.value : 50
						});*/
					break;
				case "spinner":
					//div
					fsDiv.append("<div class='text' id='" + _property.id + "' ></div>");
					var propertyFS = $("div#" + _property.id);
					// legend
					if (_property.legend != undefined) {
						propertyFS.append("<h6><a href='#'>" + _property.legend + "</a></h6>");
					}
					li = document.createElement("li");
					if (_property.disabled == true) {
						li.className = "disabled";
					}
					//label
					li.innerHTML = "<label for='" + _property.id + "'>" +
						(_property.disabled == true ? _property.label.strike() : _property.label) +
						"</label>";
					li.innerHTML += "<input id='" + _property.id + "' name=" + _property.id +
						(_property.required ? " class='required'" : "") +
						(_property.disabled == true ? " disabled='disabled'" : "") +
						" type='number'></input>";
					ul.appendChild(li);
					propertyFS.append(ul);
					break;

			}
		});
	}

	//build transformation inputs
	if (project.modeDirect == true && typeof (project.transformations) != "undefined") {
		//div
		fsDiv.append("<div id='transformations'> </div>");
		var transfoFS = $("div#transformations");
		// legend
		transfoFS.append("<h6><a href='#'>XSL Transformation</a></h6>");
		ul = document.createElement("ul");
		$.each(project.transformations, function (i, _transformation) {
			li = document.createElement("li");
			//class required
			li.innerHTML = "<input type='radio' id='transformation" + i +
				(project.defaultTransformation == _transformation ? "' checked='checked'" : "'") +
				" name='transformations' value='" + _transformation + "' class='required'></input>";
			//label
			li.innerHTML += "<label for='transformation" + i + "'>" + _transformation + "</label>";
			ul.appendChild(li);
		})
		//add the no transformation option
		li = document.createElement("li");
		//class required
		li.innerHTML = "<input type='radio' id='transformation99999'" +
			(project.transformations != undefined && project.defaultTransformation == "none" ? "' checked='checked'" : "") +
			" name='transformations' value='none' class='required'></input>";
		//label
		li.innerHTML += "<label for='transformation99999'>none</label>";
		ul.appendChild(li);
		transfoFS.append(ul);
	}

	//textarea containing XML for input
	$("#tab1").append("<div id='xml' style=\"display:none\"></div>");
	var xmlFS = $("div#xml");
	//prise en compte du param trage du titre de l'onglet de visualisation XML

	xmlFS.append("<h2><a href='#'>" + (project.tabXMLLabel != undefined ? project.tabXMLLabel : "XML") + "</a></h2>");

	ul = document.createElement("ul");
	li = document.createElement("li");
	// legend
	li.innerHTML = "<textarea id='xmlInput' rows='26' cols='120' wrap='virtual'></textarea>";
	ul.appendChild(li);
	li = document.createElement("li");
	if (project.descriptionText != undefined) {
		li.innerHTML = "<textarea id='description' readonly>" + project.descriptionText + "</textarea>";
	}
	ul.appendChild(li);

	li = document.createElement("li");
	li.id = "xmlButtons";
	li.setAttribute("style", "vertical-align: top; padding-top: 25px;");
	/*li.innerHTML = '<a href="#" id="buildXML" onclick="loadData();" class="ui-state-default ui-corner-all button">' +
									'<span class="ui-icon ui-icon-newwin"></span>' +
									(project.loadXMLButtonLabel != undefined ? project.loadXMLButtonLabel : "Load XML") +
					'</a>' +
					'<a href="#" id="launch" onclick="submitForm();" class="ui-state-default ui-corner-all button">' +
						'<span class="ui-icon ui-icon-newwin"></span>' +
						(project.launchButtonLabel != undefined ? project.launchButtonLabel : "Launch Yseop") +
					'</a>';*/
	ul.appendChild(li);
	xmlFS.append(ul);

	$("#logoContainer").append('<p class="byYseop">Powered by Yseop</p>');
}


function generateResult() {
	$("#loading").show();
	loadData();
	xmlInput = $("#xmlInput").val();
	var action = "../../../";
	action += "direct/" + project.name + "/dialog.do?text-log=false";
	var transformation = $("div#listeFieldSetDemande div#transformations input:checked").val();
	if (transformation != "none") {
		action += "&transformation=" + transformation;
	}

	var charset;
	if (project.resultTarget == "area") { 
		 charset = "application/x-www-form-urlencoded; charset=UTF-8"
	}
	else {
		charset =  "application/x-www-form-urlencoded; charset=UTF-8"
	}
	$.ajax(
		{
			method: "POST",
			url: action,
			dataType: "html",
			async: true,
			data: { xml: xmlInput },
			contentType: charset,
		}).done(function (innerHTML) {
			$("#resultContent").empty().append(innerHTML);
			$("#titleResult").html($("div#listeFieldSetDemande div#cases .selected").val());
			$("#xml").hide();

			$("#loading").hide();
			if (!project.displayRewriteMeButton) {
				$(".regenBtn").hide();
			};

		})
		.error(function(){
			window.location.href="error.html";
		});

}

function buildFormSamePage() {

	buildFormStd();
	var xmlTag = $("#xml");
	xmlTag.before('<div id="result" class="mdl-cell mdl-cell--12-col">'+ 
	'<div class="mdl-card__title mdl-color-text--blue-500"><h2 class="mdl-card__title-text">'+
		(project.titleResult != undefined ? project.titleResult : "Result")
		+ '</h2></div><div id="resultContent" class="mdl-card__supporting-text">'
		+ (project.descResult != undefined ? project.descResult : "The result will be generated here") +
		'</div></div>');


	$("#launch").removeAttr("onclick");
	$("#launch").click(function () { generateResult(); });


	addCss("injector-settings/css/font-awesome.css");

}

function getXML(val) {


	//for dialog mode (default Mode)
	if (_insertXMLData != "") {
		endXML += '\n' + _insertXMLData;
	}

	if (project.modeDirect == true) {

		
		//direct Mode
		if (project.resultTarget == "area") {
			beginXML = "<?xml version='1.0' encoding='UTF-8'?>\n";
		}
		else {
			beginXML = "<?xml version='1.0' encoding='UTF-8'?>\n";
		}
		beginXML += "<y:input xmlns:y='http://www.yseop.com/engine/3'>\n";
		beginXML += "\t<y:datas>\n";
		endXML = "";
		/*
				var dDay = new Date();
				var day = dDay.getDate();
				var month = dDay.getMonth() + 1;
		
				beginXML += "\t\t\t<currentDate>" + (day < 10 ? "0" : "") + day + "/" + (month < 10 ? "0" : "") + month + "/" + dDay.getFullYear() + "</currentDate>\n";
		*/


		
		if (project.usecase != undefined) {
			endXML += "\n\t\t<y:instance yclass='" + project.usecase + "'>";
			endXML += "\n\t\t</y:instance>";
		}
		if (_insertXMLData != "") {
			endXML += "\n\t\t" + _insertXMLData;
		}
		endXML += "\n\t</y:datas>";
		endXML += "\n</y:input>";
	}

	return (beginXML + val + endXML);
}
/*======================================================================================================================*/

function validateRequirements() {
	//for more information and customization possibilities, google jquery validations plugin, the official doc is well done
	var validator = _f.validate(
		{
			//success handler: you can change the succes message
			success: function (label) {
				label[0].parentElement.parentElement.parentElement.firstChild.innerHTML += '' +
					'<div class="ui-state-highlight notification" style="position: relative; background: none; border: 0px;">' +
					'<span class="ui-icon ui-icon-circle-check" style="position: relative;"></span>' +
					'</div>';
			},
			//error handler
			errorPlacement: function (error, element) {
				if (element.is(":radio"))
					error.insertAfter(element.next());
				else if (element.is(":checkbox"))
					error.appendTo(element.next());
				else
					error.appendTo(element.parent().next());
			}
		});
}
/*======================================================================================================================*/
function resetStates() {
	var coll = $("div[class~='notification']");
	for (var i = 0; i < coll.length; i++) {
		removeNode(coll[i]);
	}
}
/*======================================================================================================================*/
// pour stocker le noeud supprim?, la m?thode W3C retourne une r?f?rence au noeud supprim?
// pour faire propre il faudrait pouvoir stocker les r?f?rences afin de retrouver les noeuds supprim?s pour ?ventuellement retravailler dessus,
// mais ce besoin n'existe pas forc?ment pour le moment
// opera notament provoque des exceptions/warning si on affecte pas quelque part le retour de removeChild!!
var _nodeRemoved = null;

/**
 * @param node, node to remove
 */
function removeNode(node) {
	_nodeRemoved = node.parentNode.removeChild(node);
}
/*======================================================================================================================*/

function submitForm() {
	resetStates();

	//Setting form attributes
	var action = "../../../";
	var xmlInputName = "xml";
	

	//fill in form parameters (in particular, the action field)
	if (project.modeDirect == true) {
		action += "direct/" + project.name + "/dialog.do";
		var transformation = $("div#listeFieldSetDemande div#transformations input:checked").val();

		if (transformation != "none") {
			action += "?transformation=" + transformation;
		}
	}
	else {
		action += "dialog/" + project.name + "/dialog.do?command=init-dialog";
		if (_contentType == "json") {

			xmlInputName = "usecase-json";
			action += "&transformation=json";
		}
		else {
			xmlInputName = "usecase";
		}

	}

	_f.attr("method", "post");
	_f.attr("action", action);
	$("#xmlInput").attr("name", xmlInputName);

	//setting form target, must be implemented here rather than buildForm method : the target can be dynamically setted for the "tab" mode
	if (project.resultTarget && (project.autoSubmit == undefined || !project.autoSubmit)) {
		switch (project.resultTarget) {/*
			case ("iframe"):
				{
							alert(f.attr("target"));
				}
				break;*/
			case ("tab"):
				var tabName = $("div#cases input:checked").attr("id");
				tabName = replaceNotAlphaNumCharByUnderscore(tabName);
				_f.attr("target", tabName);
				break;
			default:
				_f.attr("target", "_self");
				break;
		}
	}
	_f.submit();
}

function createPattern(_property, value) {
	if (value != null && typeof (value) != undefined) {
		var pattern = "<" + _property.id;

		switch (_property.typeData) {
			case ("enum"):
			case ("yidAttribute"):
				pattern += " yid=\"" + value + "\"/>";
				break;
			case ("list"):
				pattern += " yclass=\"List\">" + value + "</" + _property.id + ">";
				break;
			case ("nodeValue"):
			default:
				pattern += ">" + value + "</" + _property.id + ">";
				break;
		}
	}
	return pattern;
}

/*======================================================================================================================*/
//function to replace matching patterns 
function replacePattern() {
	_contentType = $("div#cases input:checked").attr("contentType");
	if (properties.length != undefined && properties.length > 0) {


		$.each(properties, function (i, _property) {
			var value;
				if($("input#" + _property.id).attr("type")=='range' || $("input#" + _property.id).attr("type")=='number'){
			   	value = $("input#" + _property.id).val(); 
			}
			else
			{
			if ($("div#" + _property.id).is(".text")) {
				value = $("div#" + _property.id + " input:text").val();
			}
			else {
				if ($("div#" + _property.id).is(".checkbox")) {
					if (_property.choices == undefined) {
						value = $("div#" + _property.id + " input").is(":checked");
					}
				}
				else {
					if ($("div#" + _property.id).is(".selectable")) {
						value = $("select#" + _property.id + " option:selected").val();
					}
					else {
						value = $("div#" + _property.id + " input:checked").val();
					}
				}
			}
			}
			if (_property.type == "checkbox" && _property.choices != undefined) {
				var finalPattern = "";

				$.each(_property.choices, function (j, _choice) {
					if ($("input#" + _choice.id).is(":checked")) {
						value = $("input#" + _choice.id).val();
						finalPattern += createPattern(_property, value) + "\n";
					}


				});
				$("#xmlInput").val($("#xmlInput").val().replace("$" + _property.id, finalPattern));
			}
			else {
				if (_contentType == "json") {
					$("#xmlInput").val($("#xmlInput").val().replace("$" + _property.id, "\""+value+"\""));
				}
				else {
					$("#xmlInput").val($("#xmlInput").val().replace("$" + _property.id, createPattern(_property, value)));
				}

			}

		});
	}
	
	var intermedXML = "";
		$.each(languages,function(i,_language){
			if($('#lang_'+_language).hasClass("selected"))
			{
				intermedXML +='\t\t\t<language yid="LANG_'+_language +'" />';
			}
		
		});
	$("#xmlInput").val($("#xmlInput").val().replace("</y:instance>",intermedXML + "</y:instance>"));
}
/*======================================================================================================================*/
function deleteComments(str) {
	var output = "";

	while (str.indexOf("<!--") >= 0) {
		output += str.substring(0, str.indexOf("<!--"));
		str = str.substring(str.indexOf("-->") + 3);
	}

	return deleteEmptyLines(output + str);
}
/*======================================================================================================================*/
function deleteEmptyLines(str) {
	var emptyLine = /[\n]+[\t]*[\s]*[\n]+/;
	str.replace(new RegExp(emptyLine, 'g'), "\n");
	//1ere ligne vide :-()
	emptyLine = /^[\t]*[\s]*\n/;
	if (str.search(emptyLine) == 0) {
		str = str.replace(emptyLine, "");
	}

	return str;
}
/*======================================================================================================================*/
/**
 * Encodes a string, replacing not alpha and not numeric characters with "_".
 *
 * @return encoded	The encoded string given in parameter
 *
 */
function replaceNotAlphaNumCharByUnderscore(str) {
	var characters = str.split('');
	var currentChar = "";
	var pattern = /\W/;
	var encoded = "";

	for (var i = 0; i < characters.length; i++) {
		currentChar = characters[i];

		if (!pattern.test(currentChar)) {
			encoded += currentChar;
		}
		else {
			encoded += "_";
		}
	}

	return encoded;
}
/*======================================================================================================================*/
function loadData(callback) {
	project.pathToCases = project.pathToCases != undefined ? project.pathToCases : "injector-settings/cases/";
	//load the right XML content
	
	//empty for security $("#xmlInput").empty(); ne marche pas
	$("#xmlInput").val("");
	$.ajaxSetup(
		{
			"beforeSend": function (xhr) {
				xhr.overrideMimeType("text/html; charset=UTF-8");
			}
		});
	$.ajax(
		{
			type: "GET",
			url: project.pathToCases + $("div#cases input:checked").val(),
			dataType: "html",
			async: false,
			success: function (data) {
				//empty for security
				//$("#xmlInput").empty();
				//fill textarea with data
				$("#xmlInput").val(data);
				addXML(callback);
			}
		})
		.error(function (error) {
			if ($("#errorDialog")[0] == undefined) {
				var d = document.createElement("div");
				d.id = "errorDialog";
				d.title = "Error";
				d.appendChild(document.createTextNode("Failed to load case."));
				var breakLine = document.createElement("br");
				d.appendChild(breakLine);
				d.appendChild(document.createTextNode("Please select a valid case."));
				$(".mdl-layout").append(d);
			}
			$("#errorDialog").dialog({ modal: true });
		})
		;
}
/*======================================================================================================================*/
function addXML(callback) {
	$("#xmlInput").val(deleteComments(getXML($("#xmlInput").val())));
	//call function to replace patterns
	replacePattern();
	if (typeof (callback) == "function") {
		callback();
	}
}
/*======================================================================================================================*/
function buildForm() {

	if (project.resultTarget == "area") {
		//addCss("injector-settings/css/samePage.css");
		//addCss("injector-settings/css/loader.css");
		//addCss("injector-settings/css/main.css");
		buildFormSamePage();

	}
	else {
		//addCss("injector-settings/css/tabPage.css");
		addCss("injector-settings/css/loader.css");
		addCss("injector-settings/css/main-dialog.css");

		buildFormStd();
	}

}
/*======================================================================================================================*/
$(document).ready(
	function () {

		//uncomment following black to handle ajax errors
		/*$.ajaxSetup(
		{
			error:function(x,e)
			{
				if (x.status == 0)
				{
					alert("You are offline!!\n Please Check Your Network.");
				}
				else if (x.status == 404)
				{
					alert("Please select a valid case.");
				}
				else if (x.status == 500)
				{
					alert("Internel Server Error.");
				}
				else if (e == "parsererror")
				{
					alert("Error.\nParsing JSON Request failed.");
				}
				else if (e == "timeout")
				{
					alert("Request Time out.");
				}
				else
				{
					alert("Unknow Error.\n" + x.responseText);
				}
			}
		});*/
		//show or hide textarea


		/*
      auto find out project name
      ex. /yseop-manager/dialog/profile/generic-injector/injector.html
    */

	//get JSON data
$.getJSON("injector-settings/cases/injector-properties.json",function(data){
	project= data.project;
	console.log(project);
	caseGroups = data.caseGroups;
	languages = data.languages;
	displayLanguages = data.displayLanguages;
	properties = data.properties;
}).done(function(){

	var pn = location.pathname.match(/([^\/]*)\/generic-injector/)[1];
		if (pn != null && project.name == null) {
			project.name = pn;
		}


		if (typeof (project) != "undefined") {

			if (typeof (project.cssFiles) != "undefined") {
				$.each(project.cssFiles, function (i, _cssFile) {
					addCss(_cssFile);
				});
			}

			//build the form and set up validation
			buildForm(validateRequirements);
			
			//hover states on the static widgets
			$("a[class~='button'], ul#icons li").hover(
				function () { $(this).addClass("ui-state-hover"); },
				function () { $(this).removeClass("ui-state-hover"); }
			);

			if (project.visualizeXML == false) {
				$("#xml").hide();
			}

			if (project.hideXSLTransformationChoice == true) {
				$("#transformations").hide();
			}

			if (project.autoSubmit == true) {
				// setting the target of the form to the document itself, in order to hide the injector as it is auto-submitted
				_f.attr("target", "_self");
				loadData(submitForm);
			}
		}
		else {
			if ($("#errorDialog2")[0] == undefined) {
				var d = document.createElement("div");
				d.id = "errorDialog2";
				d.title = "Error";
				d.appendChild(document.createTextNode("Please update your injector-properties.js file."));
				var breakLine = document.createElement("br");
				d.appendChild(breakLine);
				d.appendChild(document.createTextNode("Fix the project name(JSON project object)"));
				document.body.appendChild(d);
			}
			$("#errorDialog2").dialog({ modal: true });
		}

		if (project.resultTarget == "area") {
			$("#properties").children('h2').remove();
			$("#properties").children('ul').removeAttr("role");


			$("#properties").children('ul').removeAttr("style");
		}
		
		
		$('select').material_select();
		
		
	if (project.cssOverride == true) {
		addCss("../css/cssOverride.css");
	}

	if (project.submitOnCaseChange == true) {
		$("#cases .button").click(function () { generateResult(); });
	}

});
		
		
		
		
	}
);



/*======================================================================================================================*/
function addCss(location) {
	var css = document.createElement("link");
	css.type = "text/css";
	css.rel = "stylesheet";
	css.href = location;
	//Enlev? pour cause de bug IE
	//document.head.appendChild(css);
	document.getElementsByTagName("head")[0].appendChild(css);
}


