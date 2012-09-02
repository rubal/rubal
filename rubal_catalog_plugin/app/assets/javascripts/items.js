// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
    $(".item-destroy").change(function() {
        if($(this).attr("checked") == "checked") {
            $("#" + $(this).attr('deleting_photo_id')).closest('div.item-photo').addClass('photo-to-delete');
        }
        else {
            $("#" + $(this).attr('deleting_photo_id')).closest('div.item-photo').removeClass('photo-to-delete');
        }
    });
});
