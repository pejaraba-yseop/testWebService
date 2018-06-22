var pathToCase;
var inputXML;
var projectName = "turbine";
// projectName must be the same as the project name in yseop designer
var sliderChanged;
var refreshed;

function xmlToString(xmlData) { 
    var xmlString;
	xmlString = xmlData.xml || (new XMLSerializer()).serializeToString(xmlData);
    return xmlString;
}   

function loadInput (c) {
	$.get(c, function(data) {
		try {			
			inputXML = $.parseXML(data)	
			callYseop();
		} catch(err) {			
			alert("Bad XML file.  Please try another case.")			
		}		
	}).error(function(data){
		alert("Error in case load, check response data for typos.")
	})
}

function callYseop() {
	if (sliderChanged == true || refreshed == true) {				
		$("div.sliderWidget").each(function (){
			var theVal = $(this).children('input').val()
			theVal = cleanValue(theVal)
			$(inputXML).find($(this).attr("id")).text(theVal)
		});
	}

	$.post("../../direct/" + projectName + "/dialog.do?transformation=html", {"xml": xmlToString(inputXML)}).done(
		function(data) {
			$("div.contentArea").html(data);
			createSliders();
			}).error(function(data){
				alert("Error in in Yseop call. Check log folder for details")
		})
}

function initBtn() {
	$("button.caseBtn").click(function() {
		pathToCase = "cases/" + this.id + ".html";
		sliderChanged = false;		
		refreshed = false;
		loadInput(pathToCase);
	})
}

function createSliders(){
	$(".slider").each(function(index){
		switch ($(this).parents().attr('sliderType')) {
			case "income":
				$(this).slider({
					value: $(this).siblings("input").val(),
					max: 200000,
					min: 10000,
					step: 1,
					slide: function(event, ui) {
						$(this).siblings("input.variable").val("$" + ui.value.toLocaleString());
					},
					stop: function() {
						sliderStop($(this).parents().attr('id'))
					}
				});
				break;
			case "percent":
				$(this).slider({
					value: $(this).siblings("input").val(),
					max: 200,
					min: -200,
					step: 1,
					slide: function(event, ui) {
						$(this).siblings("input.variable").val(ui.value + "%");
					},
					stop: function() {
						sliderStop($(this).parents().attr('id'))
					}
				});
				break;
			// case "stock":
			// 	$(this).slider({
			// 		value: $(this).siblings("input").val(),
			// 		max: 200,
			// 		min: -200,
			// 		step: 1,
			// 		slide: function(event, ui) {
			// 			if (ui.value >= 0) {
			// 				$(this).siblings("input.variable").val("+"+ui.value);
			// 				$(this).siblings("input.variable").addClass('coloredGreen');
			// 				$(this).siblings("input.variable").removeClass('coloredRed');
			// 			} else {
			// 				$(this).siblings("input.variable").val(ui.value);
			// 				$(this).siblings("input.variable").addClass('coloredRed');
			// 				$(this).siblings("input.variable").removeClass('coloredGreen');
			// 			}
			// 		},
			// 		stop: function() {
			// 			sliderStop($(this).parents().attr('id'))
			// 		}
			// 	});
			// 	break;				
		}
	})
}

function refreshButton () {
	refreshed = true
	$('.moved').each(function(){
		$(this).removeClass("moved")
	})
	loadInput(pathToCase);
}

$(document).ready(function() {
	createSliders();
	initBtn();

	// $('input.showAdvice').change(function() {
	// 	$('span.theAdvice').toggle();
	// })

});

$(document).ajaxStart(function() {
	$("img#loading").show();
	$("img#loadingLogo").show();
	$("img#yseopLogo").hide();
})

$(document).ajaxStop(function() {
	$("img#loading").hide();
	$("img#loadingLogo").hide();
	$("img#yseopLogo").show();	
	// $('.configSettings').show();
	
	$("input.variable").val(function(index, value) {
		switch ($(this).parents().attr('sliderType')) {
			case "amount":
				return "$" + parseFloat(this.value).toLocaleString()
				break;
			case "percent":
				return parseFloat(this.value).toLocaleString() + "%"
				break;
			// case "stock":
			// 	if (this.value >= 0) {
			// 		$(this).siblings("input.variable").addClass('coloredGreen');
			// 		$(this).siblings("input.variable").removeClass('coloredRed');
			// 		return "+"+parseFloat(this.value).toLocaleString()	
			// 	} else {
			// 		$(this).siblings("input.variable").addClass('coloredRed');
			// 		$(this).siblings("input.variable").removeClass('coloredGreen');
			// 		return parseFloat(this.value).toLocaleString()
			// 	};			
			// 	break;
			default:
				return parseFloat(this.value).toLocaleString()
				break;
		}
	})	

	if (sliderChanged == true || refreshed == true) {
		$('span.syn').each(function(){
			$(this).addClass('highlight')
		})
		$('.moved').each(function() {
			$('span.val.' + $(this).attr('id')).addClass('highlight')
		})
	};

	// if (refreshed == false) {
	// 	$("input.showAdvice").prop('checked', false)	
	// };
	// if (refreshed && $("input.showAdvice").is(':checked')) {
	// 	$('span.theAdvice').toggle();
	// };

	$('span.highlight').delay(4000).animate({'backgroundColor' : 'white'}, 1500);
})


function showCaseContainer(){
	$('span.casesContainer').delay(10).fadeIn(100);
}

function hideCaseContainer(){
	$('span.casesContainer').delay(500).fadeOut(500, function(){
	})
}

function showConfigSettings(){
	$('span.configSettings').delay(10).fadeIn(100);
}

function hideConfigSettings(){
	$('span.configSettings').delay(500).fadeOut(500, function(){
	})
}

function sliderStop(sliderID){
	sliderChanged = true;
	$('.moved').each(function(){
		$(this).removeClass("moved")
	})
	$('div#' + sliderID).addClass('moved')
	loadInput(pathToCase);
}

function cleanValue(aString) {

	aString = aString.replace(/,/g,"")
	aString = aString.replace("$","")
	aString = aString.replace("%","")
	aString = aString.replace("+","")

	return parseFloat(aString)
}
