$(document).ready ->
  $(".login-item-header").click ->
    parent = $(this).parent(".login-list")
    $(parent).children(".login-item-body").slideToggle()

  $(".save_btn").click ->
    $(this).closest(".list-item").find("form").submit()
