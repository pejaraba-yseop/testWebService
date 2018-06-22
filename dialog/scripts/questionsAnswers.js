$(document).ready(function(){
    
	if (usePictureForTitle == true) {
		$("div#titleQA").append('<h2 class="clientLogo"><span><img src="images/' +
		pictureFileName +
		'""></span></h2>');
	} else {
		$("div#titleQA").append('<h2>' +
		(project.title != undefined ? project.title : "The Yseop injector") +
		'</h2>');	
	}
    

    if (includeLogsInDialogMode == false) {
    	$("footer").empty()	
    }
	

});



