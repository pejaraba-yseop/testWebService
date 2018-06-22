window.onload =function() {
 var config = {
      '.controls .chosen-select'           : {width:"20%",search_contains:true},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:10},
      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
      'select.chosen-select-width'     : {width:"25%",search_contains:true}
    }
    
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
    
    $(".chosen-single").find("span").text("Choisissez une option"); 
};