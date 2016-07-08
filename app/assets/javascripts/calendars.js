//Adds event listeners for calendar API type radio buttons
function setApiType(apitype) {
	if (apitype === "none") {
		$(".api").hide();
		$(".api_none").show();
	}
	else if (apitype === "icloud") {
		$(".api").hide();
		$(".api_icloud").show();
	}
	else if (apitype === "google") {
		$(".api").hide();
		$(".api_google").show();
	}
}
function calendarLoad() {
  if (!Modernizr.rgba) {
    $(".ie_color_options").show();
    $("#calendar_color").hide();
    $(".ie_color_sample").css("background-color", $("#calendar_color").val());
  }
  $(".calendar_color_option").on("click", function() {
    $("#calendar_color").val($(this).val());
    $(".ie_color_sample").css("background-color", $(this).val());
  }); 
}
