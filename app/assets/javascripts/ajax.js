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

	$("#api_none_button").on("click", function(){
		setApiType("none");
	});

	$("#api_icloud_button").on("click", function(){
		setApiType("icloud");
	});

	$("#api_google_button").on("click", function(){
		setApiType("google");
	});
}

//Turbolinks specific linking (works when using link_to)
$(document).on('page:load', function() {
  loadPageHandler();
});
$(function(){
	loadPageHandler();
});
