//Adds event listeners
//namely, for submit button click
function loadPageHandler() {
	$("#pull_calendars").on("click", function() {
		user = document.getElementById("calendar_username").value;
		pass = document.getElementById("calendar_password").value;
		$.ajax({
	    url: "/pull_calendars",
	    data: {
		    username: user,
		    password: pass
	    },
	    type: 'POST'
	  })
	  .done(function(html) {
	  	document.getElementById("calendar_list").innerHTML = html;
	  });
	});

	$("#api_none_button").on("click", function(){
		$(".api").hide();
		$(".api_none").show();
	});

	$("#api_icloud_button").on("click", function(){
		$(".api").hide();
		$(".api_icloud").show();
	});

	$("#api_google_button").on("click", function(){
		$(".api").hide();
		$(".api_google").show();
	});
}

//Turbolinks specific linking (works when using link_to)
$(document).on('page:load', function() {
  loadPageHandler();
});
$(function(){
	loadPageHandler();
});
