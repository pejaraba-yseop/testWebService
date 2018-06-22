var keys = []
konami = "38,38,40,40,37,39,37,39,66,65"

styleOuter = "position:fixed; top:50%; left:50%;" + 
			 "margin: -100px 0px 0px -150px;width:300px;" +
			 "height:200px; text-align: center; display:table;" + 
			 "border:2px black solid;border-radius:25px;" + 
			 "background:white; z-index:1; box-shadow:0px 0px 60px 30px black;"

styleInner = "display:table-cell;vertical-align:middle;"

mailto = "mailto:support-us@yseop.com" + 
		 "?Subject=Hey nerds!" + 
		 "&Body=I found your Konami code!"

$(document).keydown(function(e) {
    if (keys.push(e.keyCode), keys.toString().indexOf(konami) >= 0) {
        var t = "<a href='" + mailto + "'>" + 
        		"<div id='cal' style='" + styleOuter + "'>" + 
        		"<div style='" + styleInner + "''>" + 
        			"<img src='http://yseop.com/img/logo.png'>" + 
    			"</div>" + 
    			"</div></a>";
        $("body").prepend(t), $("#cal").fadeIn("slow", function() {
            $(this).delay(5e3).fadeOut("slow", function(){
                $('#cal').remove()    
            });
            
        }), keys = [];
    }
});