jQuery ->

  $ ->

    $("div.ui-draggable").draggable ->
      start: (event, ui) ->
        ui.helper.removeMe = true

      stop: (event, ui) ->
        ui.helper.remove()  if ui.helper.removeMe
      revert: "valid"

    $("#whole-page").droppable(
      accept: ":not(.ui-sortable-helper)"

      drop: (event, ui) ->
        offset = $(ui.draggable).offset()
        $(ui.draggable).offset(offset).appendTo("#whole-page")
        # $("#whole-page").append $(ui.draggable)
        if $("#new_search").has(".ui-draggable").length == 0
          $("#box").animate
            backgroundColor: "rgba( 250, 250, 250, 1 )"
          $("#box").find("p").html "Drop stuff in here!"
    )

    $("#box").droppable(
      greedy: true
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      drop: (event, ui) ->
        $(this).animate
          backgroundColor: "rgba( 0, 191, 255, 0.3 )"
        $(this).find("p").html "Ready to Search!"
        # $("#new_search").append($(ui.draggable))
        offset = $(ui.draggable).offset()
        $(ui.draggable).appendTo("#new_search").offset offset
        # newElement.draggable().appendTo("#whole-page").offset offset
    )

  $(document).on "dblclick", ".expandable", ($e) ->
    parent = $(this).parent("div")
    if parent.hasClass("grown")
      parent.animate
        width: $(this).width() + 50
      parent.removeClass("grown")
    else
      parent.animate
        width: $(this).width() + 100
      parent.addClass("grown")

  $("#trash").droppable(
    greedy: true
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    drop: (event, ui) ->
      $(ui.draggable).remove()
  )

  nextElement = (element) ->
    offset = element.offset()
    newElement = element.clone()
    newElement.removeClass("ui-draggable-dragging")
    newElement.draggable().appendTo("#whole-page").offset offset

  $(document).on "mousedown", ".cloner", ($e) ->
    nextElement $(this)
    $(this).removeClass("cloner")

  $(document).on "click", "input", ($e) ->
    $(this).on "keyup", ->
      oneLetterWidth = 10
      minCharacters = 13
      dragbox = $(this).parent()
      len = $(this).val().length
      if len > minCharacters

        # increase width
        dragbox.width len * oneLetterWidth + 80
        $(this).width len * oneLetterWidth
      else

        # restore minimal width;
        dragbox.width 200
        $(this).width 120

  $.ajaxPrefilter (options, _, jqXHR) ->
    # alert "something"
    jqXHR.complete ->
      $(".results").addClass "glow-alert"

  $(".results").click ->
    $(this).removeClass "glow-alert"
