$(document).ready(function() {
    $('form#update_group_form').bind('ajax:success', function(data, status, xhr) {

    }).bind("ajax:error", function(data, status, xhr) {
        console.log("ajax:error");
    });
});