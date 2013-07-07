jQuery ->

  $("#add-terms").click ->
    $("<div class='ui-draggable terms' style='left: 215px; position: absolute;'><input id='search_terms' name='search[add_terms]' placeholder='Terms' size='10' type='text'></div>").draggable().appendTo( "#whole-page" );

  $ ->
    $("div.ui-draggable").draggable ->
      start: (event, ui) ->
        ui.helper.removeMe = true

      stop: (event, ui) ->
        ui.helper.remove()  if ui.helper.removeMe
      revert: "valid"

  $(document).on "dblclick", "input", ($e) ->
    parent = $(this).parent("div")
    if parent.hasClass("grown")
      parent.animate width: $(this).width()
      parent.removeClass("grown")
    else
      parent.animate width: $(this).width() + 50
      parent.addClass("grown")

  $("#whole-page").droppable(
    greedy: true
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    accept: ":not(.ui-sortable-helper)"

    drop: (event, ui) ->
      $("#whole-page").append($(ui.draggable))
      if $("#new_search").has(".ui-draggable").length == 0
        $("#box").animate
          backgroundColor: "rgb( 224, 255, 255  )"
        $("#box").find("p").html "Drop stuff in here!"
  )

  $("#box").droppable(
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    accept: ":not(.ui-sortable-helper)"
    drop: (event, ui) ->
      $(this).animate
        backgroundColor: "rgb( 0, 191, 255 )"
      $(this).find("p").html "Ready to Search!"
      $("#new_search").append($(ui.draggable))
  )

  $(document).on "click", "input", ($e) ->
    $(this).on "keyup", ->
      oneLetterWidth = 6
      minCharacters = 10
      dragbox = $(this).parent()
      len = $(this).val().length
      if len > minCharacters

        # increase width
        dragbox.width len * oneLetterWidth
        $(this).width len * oneLetterWidth
      else

        # restore minimal width;
        dragbox.width 70
        $(this).width 70
