//Adds event listeners
//namely, for submit button click
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
function loadPageHandler() {
	/* Used by views/calendars/new.html.erb */
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
		setApiType("none");
	});

	$("#api_icloud_button").on("click", function(){
		setApiType("icloud");
	});

	$("#api_google_button").on("click", function(){
		setApiType("google");
	});

	$("#calendar_list").on("change", function(){
		var dropdown = document.getElementById("calendars_name");
		var cal_list_hash = JSON.parse(dropdown.options[dropdown.selectedIndex].value);
		document.getElementById("calendar_url").value = cal_list_hash['url'];
		document.getElementById("calendar_uid").value = cal_list_hash['uid'];
		document.getElementById("calendar_name").value = cal_list_hash['displayname'];
	});
	/* Used by views/bills/unbilled.html.erb */
	$(".expand").on("click", function(){
		$("." + $(this).attr("tag")).fadeToggle(200);
	});

	/* Used by views/clients/_form.html.erb (Expander buttons) */
	$("#client-name-expander").on("click", function() {
		$("#client-name2").fadeToggle(200);
		button = $("#client-name-expander");
		if ( button[0]["classList"][1] == "glyphicon-plus-sign") {
			button.removeClass("glyphicon-plus-sign");
			button.addClass("glyphicon-minus-sign");
		}
		else {
			button.removeClass("glyphicon-minus-sign");
			button.addClass("glyphicon-plus-sign");			
		}
	});
	$("#client-phone-expander").on("click", function() {
		phonefields = $(".client-phone")
		for ( var i = 2; i <= 4; i++ ) {
			if (phonefields[i-1]["hidden"] == true) {
				$("#client-phone" + i).fadeIn(200);
				$("#client-phone" + i).removeAttr("hidden");
				break;
			}
		}
	});
	$("#client-pet-expander").on("click", function() {
		petfields = $(".client-pets")
		for ( var i = 0; i <= petfields.length; i++ ) {
			if (petfields[i]["hidden"] == true) {
				$("#client-pet-" + i).fadeIn(200);
				$("#client-pet-" + i).removeAttr("hidden");
				break;
			}
		}
	});
}

//Turbolinks specific linking (works when using link_to)
$(document).on('page:load', function() {
  loadPageHandler();
});
$(function(){
	loadPageHandler();
});
