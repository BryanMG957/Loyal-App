// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
function appointmentLoad() {
  $('.datepicker').datetimepicker({
    format: "M dd yyyy - HH:ii P",
    startView: 1,
    showMeridian: true
  });
	$("#client-searcher").on("keyup", function() {
		var dropdown = $("#appointment_client_id");
		var clients = dropdown.children();
		for ( var i = 0; i < clients.length; i++ ) {
		  if (clients[i].innerText.toLowerCase().search($(this).val().toLowerCase()) > -1) {
		  	dropdown.val(clients[i].value);
		  	break;
		  }
	  }
	});
}