// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var sentinel = {
    createNotification: function(type, message, relativeElement) {
        var offset = sentinel.offset(relativeElement);
        $("<div></div>")
            .addClass("alert alert-dismissible alert-" + type)
            .html('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + message)
            .css({
                'position': 'absolute',
                'top': offset.bottom,
                'left': offset.right,
                'z-index': 100,
                'max-width': '400px',
                'box-shadow': '0 0 10px 2px #aaa',
                'cursor': 'pointer'
            })
            .on('click', function(ev) {
                $(this).fadeOut(200, function() {
                    $(this).remove();
                });
            })
            .appendTo(document.body);
    },
    offset: function(el) {
        var topLeft = $(el).offset();
        return {
            top: topLeft.top,
            left: topLeft.left,
            bottom: topLeft.top + $(el).outerHeight(),
            right: topLeft.left + $(el).outerWidth()
        };
    }
};
