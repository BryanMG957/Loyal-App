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