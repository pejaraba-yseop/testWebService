/*
  JavajQueryScript for text-eval
*/

function loadScript(url, callback)
{
     // Adding the script tag to the head as suggested before
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;

    // Then bind the event to the callback function.
    // There are several events for cross browser compatibility.
    script.onreadystatechange = callback;
    script.onload = callback;

    // Fire the loading
    head.appendChild(script);
}

function loadCss(url, callback)
{
     // Adding the link tag to the head as suggested before
    var head = document.getElementsByTagName('head')[0];
    var link = document.createElement('link');
    link.type = 'text/css';
    link.rel = "stylesheet";
    link.href = url;

    // Then bind the event to the callback function.
    // There are several events for cross browser compatibility.
    link.onreadystatechange = callback;
    link.onload = callback;

    // Fire the loading
    head.appendChild(link);
}


var go = function () {
/*    $(".text_eval_moreOrLess_icon").click(function() {
      
      $(this).toggleClass("more less");
      $(this).siblings(".text-eval_content").toggle("fold");
    }); */
    
    $("span.text-eval_content:visible").click(function() {
      console.log($(this))
    })

    /*$("span.text-eval-container").tooltip({
      track: false,
      content: function() {
        return $(this).children(".text-eval_data").html();
      },
      items: "span.text-eval"
    })*/

$("span.text-eval_content:visible").each(function(){
    
    $(this).tooltip({
      position: {
                  my: "center bottom-20",
                  at: "center top",
                  using: function (position, feedback) {
                      $(this).css(position);
                      $("<div>")
                          .addClass(feedback.vertical)
                          .addClass(feedback.horizontal)
                          .appendTo(this);
                  }
              },
      track: false,
      content: function() {
        return $(this).prev(".text-eval_data").html();
      },
      items: ".text-eval_content"
    })
  })
}


var JQUERY = "http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js";
var JQUERY_UI = "http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js";
var JQUERY_UI_CSS = "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery.ui.all.css";



if(!window.jQuery)
{

  var textElement = document.createElement('div');
  textElement.style.color = "red";
  textElement.style.fontSize = "1.2em";
  textElement.style.padding = "20px";

  textElement.innerHTML = "<b>Please Note that jQuery and jQuery UI are needed and will be downloaded from googleapis.com website.</b>"
   //document.getElementsByTagName('body')[0].insertBefore(textElement, document.getElementsByTagName('body')[0].firstChild);
  

   loadScript(JQUERY, function() {
      loadScript(JQUERY_UI, function() {
        loadCss(JQUERY_UI_CSS, go);
      });
   });

} else {
  //jQuery is already loaded!
  //now, test if jQuery UI is loaded:
  if (typeof jQuery.ui === 'undefined') {
    //Just load jQuery UI (js and css). Then go

    //BE CAREFUL, we dl the last version of jQuery UI. This might not work with the currently loaded jQuery version 
    loadScript(JQUERY_UI, function() {
      loadCss(JQUERY_UI_CSS, go);
    });
  } else {
    //Ok, Jquery and jQuery UI are loaded. Just go
    go();
  }
}