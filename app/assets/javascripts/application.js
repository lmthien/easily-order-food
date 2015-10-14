// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$("#weekday").bind("change", function(){
   window.location = "/weekly_menu/manage/" + $(this).val()
});

$(".active_user").bind('click', function () {
    var THAT = this;
    var statusOfUser = $(THAT).attr("data_user_status");
    var userId = $(THAT).attr("data_user_id");
    var link =  "/mtx_user/change_status/" + userId + "/" + statusOfUser;
    $.ajax({
        url: link,
        type: "GET",
        success: function(result){
            if (result.active == 1) {
                $(THAT).attr("data_user_status", 0);
                $(THAT).text("Active");
            } else {
                $(THAT).attr("data_user_status", 1);
                $(THAT).text("Inactive");
            }
        }
    })
})
