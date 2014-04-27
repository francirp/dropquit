$(function(){
  if ( $('body').is('.application') ){

    $(".leave-comment").on('click', function(e){
      e.preventDefault();
      var id = $(this).data('id');
      $("#comment-post-" + id).toggle();
    });

    $(".reply_link").click(function(e) {
      e.preventDefault();
      var comment_id = $(this).parents("p.thread_divider").data("comment-id");
      $("#reply_comment_" + comment_id).toggle();
    });

  }
});
