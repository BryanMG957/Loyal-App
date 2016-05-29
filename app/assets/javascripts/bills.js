//Event listener function for unbilled item checkbox
//Adds charge to bill amount, sets client dropdown
function unbilledItemCheckbox(cb, charge, clientid) {
	curamt = Number($("#bill_total_amount").val());
	if (cb.checked == true) {
		$("#bill_client_id").val(clientid);
	  $("#bill_total_amount").val(curamt + charge);
	}
  else {
	  $("#bill_total_amount").val(curamt - charge);
	}
}