jQuery ->

  $ ->

    $(".cloner").draggable
      helper: "clone"

    $("#whole-page").droppable(
      accept: ":not(.ui-sortable-helper)"

      drop: (event, ui) ->
        offset = ui.helper.offset()
        cloned = ui.helper.clone().removeClass("cloner")
        cloned.draggable().appendTo(this).offset offset
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
        offset = ui.helper.offset()
        cloned = ui.helper.clone().removeClass("cloner")
        cloned.draggable().appendTo(this).offset offset
        $(this).animate
          backgroundColor: "rgba( 0, 191, 255, 0.3 )"
        $(this).find("p").html "Ready to Search!"
        $("#new_search").append($(ui.draggable))
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

  # nextElement = (element) ->
  #   # offset = element.offset()
  #   newElement = element.clone()
  #   newElement.removeClass("ui-draggable-dragging")
  #   newElement.draggable().appendTo("#whole-page")

  # $(document).on "mousedown", ".cloner", ($e) ->
  #   nextElement $(this)
  #   $(this).removeClass("cloner")

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
