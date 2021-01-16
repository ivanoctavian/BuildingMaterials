$(".username").mouseenter(function () {
  $(".logout").css("display", "block");
});

$(document).click(function (event) {
  let $target = $(event.target);
  if (
    !$target.closest(".username").length &&
    !$target.closest(".logout").length
  ) {
    $(".logout").css("display", "none");
  }
});
