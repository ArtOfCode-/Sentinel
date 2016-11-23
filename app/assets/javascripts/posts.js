function createFlagOption(item, handler) {
    var container = $("<div></div>");
    container.addClass("clearfix flag-option");
    container.append("<div class='pull-left'><input type='radio' name='flag-option' value='" + item['option_id'] + "' /></div>");
    var details = $("<div class='pull-right'></div>");
    details.append("<p><strong>" + item['title'] + "</strong></p>");
    details.append("<p>" +  item['description'] + "</p>");
    container.append(details);

    container.on('click', handler(item));

    return container;
}

$(document).ready(function() {
    $(".post-flag-link").on("click", function(ev) {
        ev.preventDefault();
        var answerId = $(this).data("answerid");
        $.ajax({
            'type': 'GET',
            'url': '/posts/' + answerId + '/flag_options'
        })
        .done(function(data) {
            var items = data['items'];
            var dialog = $(".modal-body").first();
            for (var i = 0; i < items.length; i++) {
                if (!items[i]['has_flagged']) {
                    var flagOption = createFlagOption(items[i], function(item) {
                        return function(ev) {
                            $(".flag-option").css("background", "none");
                            $(ev.target).css("background", "#ddd");

                            if (item['requires_comment']) {
                                window.flagComment = prompt("Please enter a comment to be sent with this flag:", "");
                            }
                        }
                    });
                    flagOption.prependTo(dialog);
                }
            }
            $(".modal").first().modal('show');
        })
        .error(function(xhr, status, error) {
            sentinel.createNotification('danger', JSON.parse(xhr.responseText)['error_message'], $(this));
        });
    });

    $(".cast-flag").on("click", function(ev) {
        var selected = $("input[name=flag-option]").val();
        var comment = window.flagComment || null;
        var answerId = $(this).data("answerid");
        $.ajax({
            'type': 'POST',
            'url': '/posts/' + answerId + '/flag',
            'data': {
                'option_id': selected,
                'comment': comment
            }
        })
        .done(function(data) {
            sentinel.createNotification('success', "Post flagged successfully.", $(this));
        })
        .error(function(xhr, status, error) {
            sentinel.createNotification('danger', JSON.parse(xhr.responseText)['error_message'], $(this));
        });
    });
});
