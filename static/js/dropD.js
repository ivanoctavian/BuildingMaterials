    $(".username").mouseenter(function() {
        $(".logout").css('display','flex');
    })
    // $(".username").mouseleave(function() {
    //     $(".logout").css('display','none');
    // })
    $(document).click(function(event) {
        let $target = $(event.target);
        if((!$target.closest('.username').length || !$target.closest('.logout').length)){
        $('.logout').css('display','none');
  }
});