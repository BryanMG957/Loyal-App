// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
var fillInApptData = function() {
  var service_field = document.getElementById("appointment_service");
  if (!service_field) return;
  var client_field = document.getElementById("appointment_client_id");
  var selected_service = service_field.selectedIndex + 1;
  var selected_client = client_field.selectedIndex + 1; 
  $("#appointment_charge").val(
      $("#appointment_service :nth-of-type(" + selected_service + ")").attr("data-default-price"));
  $("#appointment_reminder_before").val(15);
  var billing_name = $("#appointment_service :nth-of-type(" + selected_service + ")").attr("data-billing-name");
  var pets = $("#appointment_client_id :nth-of-type(" + selected_client + ")").attr("data-pets");
  $("#appointment_description").val((pets ? pets + " - " : "") + billing_name) ;
}

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
      if (clients[i].innerHTML.toLowerCase().search($(this).val().toLowerCase()) > -1) {
	dropdown.val(clients[i].value);
	break;
      }
    }
    fillInApptData();
  });
  $("#client-searcher").on("blur", function() {
    $(this).val("");
  });
  $("#appointment_client_id, #appointment_service").on("change", function() {
    fillInApptData();    
  });
}
