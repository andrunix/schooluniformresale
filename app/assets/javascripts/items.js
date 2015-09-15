# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#user_schools').change(function() {
  $.get('items/toggle?' + $(this).val(), function(data, status) {
      if (status === 'success') {
        alert(data);
      }
    });
  });