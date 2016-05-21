$(".pull_calendars").live("click", function() {
  $.ajax("/pull_calendars")
});