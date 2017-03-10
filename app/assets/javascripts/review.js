$(document).on('turbolinks:load', function() {
    $(".feedback").on("click", function() {
        var $post = $(this).parent().parent();
        var feedbackType = $(this).data("ftype");
        var postId = $post.data("post-id");

        $.ajax({
            'type': 'POST',
            'url': '/review/' + postId,
            'data': {
                'feedback_code': feedbackType
            }
        })
        .done(function(data) {
            $post.fadeOut(200, function() {
                $(this).remove();
            });
        })
        .error(function(a, b, c) {
            console.error(a, b, c);
        });
    });
});
